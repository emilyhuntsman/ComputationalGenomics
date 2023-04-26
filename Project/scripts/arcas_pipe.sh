#!/bin/sh
# shell script to run arcasPipeline for all bam files (chr 6 only)

# arcasHLA/arcasHLA reference --version 3.24.0 already rolled back once
# file at same level as bam_files directory and arcasHLA

cd bam_files
mkdir arcas_output
mkdir extracted_files
for BAM_FILE in *.bam
do
   echo ${BAM_FILE}
   ../arcasHLA/arcasHLA extract ${BAM_FILE} -o extracted_files -t 8 -v --single
   rm ${BAM_FILE}.bai
   rm extracted_files/${BAM_FILE:0:${#BAM_FILE}-4}.extract.log
   #rm ${BAM_FILE}
   mkdir arcas_output/${BAM_FILE:0:${#BAM_FILE}-9}
   ../arcasHLA/arcasHLA genotype extracted_files/${BAM_FILE:0:${#BAM_FILE}-4}.extracted.fq.gz -g A,B,C,DPB1,DQB1,DQA1,DRB1 -o arcas_output/${BAM_FILE:0:${#BAM_FILE}-9} -t 8 -v --single
done