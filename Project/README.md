# CBMF W4761-Computational Biology: Final Project

##### Ragyie Rawal (rr3423), Emily Huntsman (emh2237)
***
### Submission Files
```
Project
|    scripts
    |    trim_bam.sh
    |    pipelines.sh
    |    merge_results.sh
    |    merge_opti.py
    |    compare_outputs.py
|   data
    |    inputs
        |    bam_files
        |    extracted_files
    |    outputs
        |   arcas_output
        |   optitype_output
        |   combined_HLA.tsv
|    README.md
```

### Program Usage
1. git clone arcasHLA and Optitype repos
```
cd Project
git clone https://github.com/RabadanLab/arcasHLA.git
git clone https://github.com/FRED-2/OptiType.git
```
These repositories should be at the same level as the data and scripts folders.

2. Enter input directory and make folder to store curled BAM files
```
cd data/inputs
mkdir full_files
cd full_files
```

3. Get curl command for immune files from HCA (https://data.humancellatlas.org/explore/projects/cc95ff89-2e68-4a08-a234-480eca21ce79/get-curl-command) by selecting 'Homo sapiens' -> 'bam' -> 'bash' -> 'Request curl Command'

4. Paste curl command into terminal (making sure its in the full_files directory). We did this step on an external hardrive with 1Tb of storage so that we could run the trim_bam script when the majority of the files were downloaded so that we could accommodate all 1.3Tb of total files from this curl command.

5. After ~4 hours (so that the curl and trimming script can both run at the same time), run trim_bam.sh script
```
cd ../../../scripts
bash trim_bam.sh
```
This script will create the bam_files directory in the datafolder, which has been included in the repo already.

6. Once all bam files have been subsetted to the HLA region, run pipelines.sh to run arcasHLA, generate fastq files for Optitype input (into data/inputs/extracted_files), and run the Optitype pipeline.
```
bash pipelines.sh
```
pipelines.sh will create data/outputs/arcas_output and data/outputs/optitype_output.

7. Run merge_results.sh, which calls arcasHLA merge on the arcas output files and merges optitype results using merge_opti.py. Compare_outputs.py is also called within the script to create one merged file for all 127 original bams and class 1 types.
```
bash merge_results.sh
```
The type comparisons will be printed to the terminal, and the combined results are written to data/outputs/combined_HLA.tsv to be further inspected.

Note: To run our pipeline without having the curl or trim the bam files, one can use pipelines.sh (trimmed bams are included in the git repo).
We ran our pipeline on a macbook pro with normal processing power. The only import our files require (on top of the dependencies of arcasHLA and Optitype as listed on their githubs) are pandas and samtools. Our pipeline is designed to run with python3.

### File Descriptions
- trim_bam.sh : shell script to subset 1.3Tb of HCA data to only the HLA region on the short arm of chromosome 6 (8Gb) using samtools.
- pipelines.sh : Runs both arcasHLA and Optitype packages on all files. ArcasHLA is run for A,B,C,DPB1,DQB1,DQA1,DRB1 with 8 threads and single end reads as shown in the script's call. Optitype is run with the --rna flag for our single-end reads. 
- merge_results.sh : This file combines all arcas results using their built in command 'merge'. Also, we have written code to do a similar process for the optitype results via pandas (found in merge_opti.py). The script also calls compare_outputs.py, which is described below. 
- compare_outputs.py : merged outputs from arcas and optitype are formatted in the same way for comparison. A dataframe is constructed with each original bam file as a row and the class 1 typing outputs as the columns. This combined file is written to a tsv, and the script also prints to the terminal complete typing matches, partial matches (one call common across the two pipelines), and no matching. The cases in which there is no matching are printed to the terminal.