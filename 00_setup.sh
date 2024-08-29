# define main working directory
workdir=/lustre/scratch/jmanthey/01_greenbuls

# make output directories
cd ${workdir}

mkdir 00_fastq
mkdir 01_cleaned
mkdir 01_bam_files
mkdir 02_vcf
mkdir 03_vcf
mkdir 04_filtered_vcf
mkdir 05_pca
mkdir 06_window_stats
mkdir 06_window_stats/windows
mkdir 10_filter
mkdir 11_filter_vcf
