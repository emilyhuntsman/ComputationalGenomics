#!/usr/bin/env python3

import pandas as pd

def main():
    merged_df = pd.DataFrame(columns=['A1','A2','B1','B2','C1','C2','Reads','Objective'])
    for i in range(1,128):
        single_result = pd.read_csv(f'../results/optitype_merge/{i}_result.tsv',sep='\t')
        merged_df = pd.concat([merged_df,single_result])
    merged_df.set_index(pd.Index(range(1, 128)),inplace=True)
    merged_df.drop(columns=['Unnamed: 0'],inplace=True)
    merged_df.to_csv('../results/optitype_merge/optitype_genotypes.tsv',sep='\t')

if __name__=='__main__':
    main()