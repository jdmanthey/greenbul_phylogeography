interactive -p nocona

cd references

source activate bcftools

bwa-mem2 index GCF_009819655.1_bSylAtr1.pri_genomic.fna

samtools faidx GCF_009819655.1_bSylAtr1.pri_genomic.fna

java -jar picard.jar CreateSequenceDictionary \
R=/home/jmanthey/references/GCF_009819655.1_bSylAtr1.pri_genomic.fna \
O=/home/jmanthey/references/GCF_009819655.1_bSylAtr1.pri_genomic.dict


