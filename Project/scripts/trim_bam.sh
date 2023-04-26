#!/bin/sh
# shell script to subset 1.3 TB of data to only chromosome 6 and create gzipped fq files

# rename directories from HCA data to numbers for easy access
# index, subset, fastq, gz files by directory

# shell script to run arcasPipeline for all bam files (chr 6 only)

# arcasHLA/arcasHLA reference --version 3.24.0 already rolled back once

mkdir bam_files
cd full_files
ITER=1
for dir in */
do
   echo ${dir} '('${ITER}')'
   mv ${dir} ${ITER}
   cd ${ITER}
   for file in *
   do 
      mv ${file} ${ITER}.bam
      echo 'indexing'
      samtools index ${ITER}.bam
      echo 'subsetting'
      samtools view -b ${ITER}.bam 'chr6:29691116-33054976' > ${ITER}_chr6.bam
      mv ${ITER}_chr6.bam ../../bam_files/${ITER}_chr6.bam
      rm ${ITER}.bam
      rm ${ITER}.bam.bai
      cd ..
      rm -rf ${ITER}
      ITER=$(expr $ITER + 1)
   done
done