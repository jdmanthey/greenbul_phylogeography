#!/bin/sh
#SBATCH --chdir=./
#SBATCH --job-name=filter
#SBATCH --nodes=1
#SBATCH --ntasks=4
#SBATCH --partition=nocona
#SBATCH --time=48:00:00
#SBATCH --mem-per-cpu=8G
#SBATCH --array=1-34

source activate bcftools

# define main working directory
workdir=/lustre/scratch/jmanthey/greenbul_redo

# define variables
region_array=$( head -n${SLURM_ARRAY_TASK_ID} ${workdir}/vcfs.txt | tail -n1 )

# filter for structure (minimum 45/49 individuals to keep a site)
vcftools --vcf ${workdir}/04_vcf/${region_array}.vcf --keep ingroup.txt \
--max-missing 0.9 --mac 2 --max-alleles 2 --max-maf 0.49 --recode \
--recode-INFO-all --out ${workdir}/05_pca/structure45_${SLURM_ARRAY_TASK_ID}

