#!/bin/sh

cd ../data/inputs/bam_files

for i in {1..127}
do
   echo ${i}
   samtools bam2fq ${i}_chr6.bam > ../fq_files/${i}_chr6.fastq
   razers3 -i 95 -m 1 -dr 0 -o ../fq_files/${i}_chr6.bam ../../../OptiType/data/hla_reference_rna.fasta ../fq_files/${i}_chr6.fastq
   samtools bam2fq ../fq_files/${i}_chr6.bam > ../fq_files/${i}_chr6_razer3.fastq
done
gzip ../fq_files/*.fastq
rm ../fq_files/*.fastq
rm ../fq_files/*.bam