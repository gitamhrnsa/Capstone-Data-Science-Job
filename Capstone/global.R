

library(ggplot2)
library(scales)
library(glue)
library(plotly)
library(dplyr)
library(lubridate)
library(shiny)
library(shinydashboard)

# Import Data
job <- read.csv("data/DS_Jobs.csv", stringsAsFactors = T)

#Cleaning Data
job_clean <- job %>% 
  select(-c(Job.Description, Headquarters, Revenue, job_simp, job_state, same_state, python, excel, hadoop, spark, aws, tableau, big_data, Type.of.ownership, min_salary, max_salary, seniority))

job_count <- job %>% 
  group_by(Sector) %>% 
  summarise(count_cat = n()) %>% 
  arrange(desc(count_cat)) %>% 
  ungroup()

job_count2 <- job_count %>%
  mutate(label = glue("Sector: {Sector}
                      Job Count: {count_cat}"))