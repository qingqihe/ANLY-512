



library(tidyverse)

data <- read_csv("Gender_Stats_csv/Gender_StatsData.csv")

#select some variable
remarry <- data[data$`Indicator Code` == "SG.REM.RIGT.EQ", ]
judge_divorce <- data[data$`Indicator Code` == "SG.OBT.DVRC.EQ", ]
first_m_fe <- data[data$`Indicator Code` == "SP.DYN.SMAM.FE", ]
first_m_ma <- data[data$`Indicator Code` == "SP.DYN.SMAM.MA", ]
GDP_per_cap <- data[data$`Indicator Code` == "NY.GDP.PCAP.CD", ]
school_fe <- data[data$`Indicator Code` == "HD.HCI.EYRS.FE", ]
school_ma <- data[data$`Indicator Code` == "HD.HCI.EYRS.MA", ]

#bind the dataset
selectdata <- rbind(remarry,judge_divorce,first_m_fe,first_m_ma, GDP_per_cap, school_fe,school_ma)

# tidy data format
long_data <- selectdata %>% gather(year,value,-`Country Name`, -`Country Code`,-`Indicator Name`,-`Indicator Code`)

#change variable name to merge the data
colnames(long_data) <- c('Country','Code',"Indicator", 'Indicatorcode', 'Year','value') 

#subset data
long_data <- long_data[,c(1,3,5,6)]

final_data <- pivot_wider(long_data, names_from = Indicator, values_from = value)
colnames(final_data)<- c("Country",'Year','remarry_right',
                         'judgment_divorce','age_first_marriage_female',
                         'age_first_marriage_male','GDP_per_capita','year_school_female',
                         'year_school_female')

write_csv(final_data,"data_from_worldbank.csv")



origin_data <- read_csv("ANLY-512/FULL_df.csv")
new_data <- merge(x = origin_data, y = final_data, all.x = TRUE)







