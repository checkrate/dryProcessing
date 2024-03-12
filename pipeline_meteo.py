from sklearn.pipeline import Pipeline
from sklearn.preprocessing import FunctionTransformer
pipeline_meteo = Pipeline([
    ('extract_iden_obsr', FunctionTransformer(lambda x: x.assign(IDEN=x['IDEN    OBSR'].astype(str).str[:5], OBSR=x['IDEN    OBSR'].astype(str).str[5:13]))),
    ('drop_columns', FunctionTransformer(lambda x: x.drop(columns=['IDEN    OBSR', 'SSSD', 'NNN0', 'NN25', 'NNNR', 'NNTR', 'NNRS', 'NNNM', 'NNNB', 'NNTX', 'NNNU', 'NNTG', 'NNR1', 'NNR5', 'NNNF', 'NNNG', 'TZTZ', 'TRTR', 'TT10', 'TIME    CCCC', 'SPED', 'DAYP', 'TMAX', 'TMIN', 'TGTG', 'R0R0', 'RMAX', 'T0T0', 'UDUD'], axis=1))),
    ('extract_month_year', FunctionTransformer(lambda x: x.assign(YEAR=x['OBSR'].astype(str).str[:4], MONTH = x['OBSR'].astype(str).str[4:6], DEC=x['OBSR'].astype(str).str[6:8]))),
    ('drop_obsr', FunctionTransformer(lambda x: x.drop(columns=['OBSR'], axis=1)))
])