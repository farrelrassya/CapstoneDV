options(scipen = 123)
library(dplyr)
library(tidyverse)
library(ggplot2)
library(plotly)
library(glue)
library(DT)


# 1. Input Data
ispu <- read.csv("indeks-standar-pencemar-udara-di-spku-bulan-mei-tahun-2021.csv")

# 2. Data Wrangling

ispu <- 
  ispu %>% 
  mutate(tanggal = as.Date(tanggal)) %>% 
  mutate(stasiun = as.factor(stasiun)) %>% 
  mutate(pm10 = as.numeric(pm10)) %>% 
  mutate(pm25 = as.numeric(pm25)) %>% 
  mutate(co = as.numeric(co)) %>% 
  mutate(o3 = as.numeric(o3)) %>% 
  mutate(no2 = as.numeric(no2)) %>% 
  mutate(critical = as.factor(critical)) %>% 
  mutate(categori = as.factor(categori))


ispu <- 
  ispu %>% 
  drop_na(pm10, pm25, so2, co, o3, no2)


ispu <- 
  ispu %>% 
  rename(CO = co,
         NO2 = no2,
         O3 = o3,
         SO2 = so2,
         PM10 = pm10,
         PM2.5 = pm25)


ispu_case1 <- 
  ispu %>% 
  select(stasiun, PM10, PM2.5, SO2, CO, O3, NO2) %>% 
  pivot_longer(cols = c(PM10, PM2.5, SO2, CO, O3, NO2),
               names_to = "Parameter_Polutan",
               values_to = "Total")