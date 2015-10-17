require(tidyr)
require(dplyr)
require(ggplot2)

setwd("~/DataVisualizations/DV_Project3/01 Data/CSVs")

file_path <- "2010-11_NDA_Rept2_Mortality.csv"

df_DataMortality <- read.csv(file_path, stringsAsFactors = FALSE)

# Replace "." (i.e., period) with "_" in the column names.
names(df_DataMortality) <- gsub("\\.+", "", names(df_DataMortality))

str(df_DataMortality) # Uncomment this and  run just the lines to here to get column types to use for getting the list of measures.

measures <- c("PYaR", "Expecteddeaths", "Deaths", "ÿSMR", "X95LowerConfidenceInterval" , "X95UpperConfidenceInterval", "Additionalriskofmortality")
#measures <- NA # Do this if there are no measures.

# Get rid of special characters in each column.
# Google ASCII Table to understand the following:
for(n in names(df_DataMortality)) {
  df_DataMortality[n] <- data.frame(lapply(df_DataMortality[n], gsub, pattern="[^ -~]",replacement= ""))
}

dimensions <- setdiff(names(df_DataMortality), measures)

if( length(measures) > 1 || ! is.na(dimensions)) {
  for(d in dimensions) {
    # Get rid of " and ' in dimensions.
    df_DataMortality[d] <- data.frame(lapply(df_DataMortality[d], gsub, pattern="[\"']",replacement= ""))
    # Change & to and in dimensions.
    df_DataMortality[d] <- data.frame(lapply(df_DataMortality[d], gsub, pattern="&",replacement= " and "))
    # Change : to ; in dimensions.
    df_DataMortality[d] <- data.frame(lapply(df_DataMortality[d], gsub, pattern=":",replacement= ";"))
  }
}

library(lubridate)
# Fix date columns, this needs to be done by hand because | needs to be correct.
#                                                        \_/
#df_DataMortality$Order_Date <- gsub(" [0-9]+:.*", "", gsub(" UTC", "", mdy(as.character(df_DataMortality$Order_Date), tz="UTC")))
#df_DataMortality$Ship_Date  <- gsub(" [0-9]+:.*", "", gsub(" UTC", "", mdy(as.character(df_DataMortality$Ship_Date),  tz="UTC")))

# The following is an example of dealing with special cases like making state abbreviations be all upper case.
# df_DataMortality["State"] <- data.frame(lapply(df_DataMortality["State"], toupper))

# Get rid of all characters in measures except for numbers, the - sign, and period.dimensions


write.csv(df_DataMortality, paste(gsub(".csv", "", file_path), ".reformatted.csv", sep=""), row.names=FALSE, na = "")

tableName <- gsub(" +", "", gsub("[^A-z, 0-9, ]", "", gsub(".csv", "", file_path)))
sql <- paste("CREATE TABLE", tableName, "(\n-- Change table_name to the table name you want.\n")
if( length(measures) > 1 || ! is.na(dimensions)) {
  for(d in dimensions) {
    sql <- paste(sql, paste(d, "varchar2(4000),\n"))
  }
}
if( length(measures) > 1 || ! is.na(measures)) {
  for(m in measures) {
    if(m != tail(measures, n=1)) sql <- paste(sql, paste(m, "number(38,4),\n"))
    else sql <- paste(sql, paste(m, "number(38,4)\n"))
  }
}
sql <- paste(sql, ");")
cat(sql)
