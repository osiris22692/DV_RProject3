require("jsonlite")
require("RCurl")
# Change the USER and PASS below to be your UTEid
df_MI <- data.frame(fromJSON(getURL(URLencode('129.152.144.84:5001/rest/native/?query="select * from NDARept2MI"'),httpheader=c(DB='jdbc:oracle:thin:@129.152.144.84:1521/PDBF15DV.usuniversi01134.oraclecloud.internal', USER='cs329e_jzp78', PASS='orcl_jzp78', MODE='native_mode', MODEL='model', returnDimensions = 'False', returnFor = 'JSON'), verbose = TRUE), ))
df_MI

# Change the USER and PASS below to be your UTEid
df_stroke <- data.frame(fromJSON(getURL(URLencode('129.152.144.84:5001/rest/native/?query="select * from NDARept2STROKE"'),httpheader=c(DB='jdbc:oracle:thin:@129.152.144.84:1521/PDBF15DV.usuniversi01134.oraclecloud.internal', USER='cs329e_jzp78', PASS='orcl_jzp78', MODE='native_mode', MODEL='model', returnDimensions = 'False', returnFor = 'JSON'), verbose = TRUE), ))
df_stroke

df_join2 <- dplyr::left_join(df_mainData, df_MI, by="PCTCODE")
df_join3 <- dplyr::left_join(df_join2, df_stroke, by="PCTCODE")
df_graph2 <- df_join3 %>% select(TYPE11011PREV, TYPE21011PREV, ALL1011PREV, ADDITIONALRISKOFCOMPLICATION, ADDITIONALRISKOFSTROKE)
