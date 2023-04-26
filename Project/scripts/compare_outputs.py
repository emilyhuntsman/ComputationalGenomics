#!/usr/bin/env python3
#%%
import pandas as pd
#%%
def main():
    # arcas
    arcas = pd.read_csv('../results/arcas_merge/genotypes.tsv',sep='\t')
    arcas.loc[:,'ind'] = arcas.loc[:,'subject'].map(lambda x:x.split('_')[0])
    arcas.set_index('ind',inplace=True)
    arcas.index = arcas.index.astype(int)
    arcas.sort_index(inplace=True)
    for col in ['A1','A2','B1','B2','C1','C2']:
       arcas.loc[:,col] = arcas.loc[:,col].map(lambda x:x[:x.find(':')+3])
    arcas.loc[:,'A'] = [set([a1,a2]) for a1,a2 in zip(arcas.loc[:,'A1'],arcas.loc[:,'A2'])]
    arcas.loc[:,'B'] = [set([b1,b2]) for b1,b2 in zip(arcas.loc[:,'B1'],arcas.loc[:,'B2'])]
    arcas.loc[:,'C'] = [set([c1,c2]) for c1,c2 in zip(arcas.loc[:,'C1'],arcas.loc[:,'C2'])]
    # optitype
    optitype = pd.read_csv('../results/optitype_merge/optitype_genotypes.tsv',sep='\t')
    optitype.rename(columns={'Unnamed: 0':'ind'},inplace=True)
    optitype.set_index('ind',inplace=True)
    optitype.loc[:,'A'] = [set([a1,a2]) for a1,a2 in zip(optitype.loc[:,'A1'],optitype.loc[:,'A2'])]
    optitype.loc[:,'B'] = [set([b1,b2]) for b1,b2 in zip(optitype.loc[:,'B1'],optitype.loc[:,'B2'])]
    optitype.loc[:,'C'] = [set([c1,c2]) for c1,c2 in zip(optitype.loc[:,'C1'],optitype.loc[:,'C2'])]
    # combine and write
    arcas.rename(columns={'A':'A_a','B':'B_a','C':'C_a'},inplace=True)
    optitype.rename(columns={'A':'A_o','B':'B_o','C':'C_o'},inplace=True)
    combined = pd.concat([arcas[['A_a','B_a','C_a']],optitype[['A_o','B_o','C_o']]],axis=1)
    combined.to_csv('combined_HLA.tsv',sep='\t')

    for type in ['A','B','C']:
        exact_match = 0
        partial_match = 0
        no_match = 0
        for ind, row in combined.iterrows():
            if row[f'{type}_a'] == row[f'{type}_o']:
                exact_match += 1
            elif len(row[f'{type}_a'].intersection(row[f'{type}_o'])) == 1: 
                partial_match += 1
            else:
                no_match += 1
                print(row[[f'{type}_a',f'{type}_o']])
        print(f'{type.upper()}: exact: '+str(exact_match)+', partial: '+str(partial_match)+', none: '+str(no_match))

if __name__ == "__main__":
    main()