#!/bin/sh
# shell script to run arcasPipeline for all bam files (chr 6 only)

# arcasHLA/arcasHLA reference --version 3.24.0 already rolled back once
# file at same level as bam_files directory and arcasHLA

mkdir ../data/outputs/optitype_output
mkdir ../data/outputs/tmp_output
cd ../data/inputs/fq_files

for i in {1..127}
do
   echo ${i}
   python3 ../../../OptiType/OptiTypePipeline.py -i ${i}_chr6.fastq.gz --rna -e 3 --outdir ../../outputs/tmp_output
   cd ../../outputs/tmp_output
   for DIR in */
   do 
      mv ${DIR}${DIR:0:${#DIR}-1}_coverage_plot.pdf ${DIR}${i}_coverage_plot.pdf
      mv ${DIR}${DIR:0:${#DIR}-1}_result.tsv ${DIR}${i}_result.tsv
      mv ${DIR} ../optitype_output/${i}
   done
   cd ../../inputs/fq_files
done

rm -rf ../../outputs/tmp_output