interactive -p nocona -c 4 -m 8G

source activate bcftools

workdir=/lustre/scratch/jmanthey/01_greenbuls

cd ${workdir}/05_pca


##########################################
##########################################
### cat all individual scaffolds together
##########################################
##########################################

grep "^#" structure45_NC_089171.1.recode.vcf > structure.vcf

for i in $( ls structure45_*.recode.vcf ); do grep -v "^#" $i >> structure.vcf; done

##########################################
##########################################
### remove all individual scaffold files
##########################################
##########################################

rm *recode*

##########################################
##########################################
### thin for 5 kbp separation between SNPs for PCA
##########################################
##########################################

vcftools --vcf structure.vcf --max-missing 1.0 --thin 5000 --recode --recode-INFO-all --out structure

##########################################
##########################################
### run plink for pca
### and run ADMIXTURE
##########################################
##########################################

# make chromosome map for this vcf
grep -v "#" structure.recode.vcf | cut -f 1 | uniq | awk '{print $0"\t"$0}' > chrom_map.txt

#plink output format
vcftools --vcf structure.recode.vcf  --plink --chrom-map chrom_map.txt --out structure 

# convert  with plink
plink --file structure --recode12 --allow-extra-chr \
--out structure_plink

# run pca on dataset
plink --file structure_plink --pca --allow-extra-chr \
--out structure_plink_pca

# convert with plink for admixture dataset
plink --file structure --recode12 --allow-extra-chr --out admixture_plink

# run admixture
for K in 1 2 3 4 5 6 7 8 9 10; do admixture --cv admixture_plink.ped $K  | tee log_${K}.out; done

