library(kableExtra)
library(stargazer)
library(dplyr)
library(ggplot2)
library(tidyr)
library(tidyverse)
library(naniar)

df1 <- read.csv(file = "first_3_datasets_merged_and_cleaned.csv", header = T,stringsAsFactors = T)

df2 <- read.csv(file = "mydf_clean.csv", header = T,stringsAsFactors = T)

df2 <- subset(df2, select = -c(2))

df2$Country <- df2$Entity
df2 <- subset(df2, select = -c(1))

# merge
marriageDF <- merge(df1, df2, by = c('Country','Year'), all=T)

# fill Same_Sex_Marriage column
marriageDF <- marriageDF %>%
  group_by(Country) %>%
  fill(Same_Sex_Marriage) %>%
  fill(Same_Sex_Marriage, .direction = "down")

#replace NA values in column Same_Sex_Marriage with "not legal"
marriageDF$Same_Sex_Marriage <- marriageDF$Same_Sex_Marriage %>% replace_na('not legal')

# save as csv
write.csv(marriageDF,"FULL_df.csv", row.names = FALSE)
