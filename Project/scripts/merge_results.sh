#!/bin/sh
# to move all outputs from arcas pre-merge

mkdir ../results/arcas_merge
cd ../data/outputs/arcas_output

for i in {1..127}
do
   echo ${i}
   cp ${i}/${i}_chr6.genotype.json ../../../results/arcas_merge/${i}_chr6.genotype.json
done
cd ../../../results/arcas_merge
../../arcasHLA/arcasHLA merge

mkdir ../optitype_merge
cd ../../data/outputs/optitype_output_2

for i in {1..127}
do
   echo ${i}
   cp ${i}/${i}_result.tsv ../../../results/optitype_merge/${i}_result.tsv
done

cd ../../../scripts
python3 merge_opti.py