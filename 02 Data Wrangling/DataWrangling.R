require("jsonlite")
require("RCurl")
# Change the USER and PASS below to be your UTEid
df_mainData <- data.frame(fromJSON(getURL(URLencode('129.152.144.84:5001/rest/native/?query="select * from NDARept1"'),httpheader=c(DB='jdbc:oracle:thin:@129.152.144.84:1521/PDBF15DV.usuniversi01134.oraclecloud.internal', USER='cs329e_jzp78', PASS='orcl_jzp78', MODE='native_mode', MODEL='model', returnDimensions = 'False', returnFor = 'JSON'), verbose = TRUE), ))
df_mainData

# Change the USER and PASS below to be your UTEid
df_mainData <- data.frame(fromJSON(getURL(URLencode('129.152.144.84:5001/rest/native/?query="select * from NDARept1"'),httpheader=c(DB='jdbc:oracle:thin:@129.152.144.84:1521/PDBF15DV.usuniversi01134.oraclecloud.internal', USER='cs329e_jzp78', PASS='orcl_jzp78', MODE='native_mode', MODEL='model', returnDimensions = 'False', returnFor = 'JSON'), verbose = TRUE), ))
df_mainData

