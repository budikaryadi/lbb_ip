# Untuk menyiapkan lingkungan aplikasi, misalnya, library, impor data dan persiapan data

# --------- LOAD LIBRARIES

# dashboarding
library(shiny)
library(shinydashboard)
library(DT) # datatable
library(dplyr)

options(scipen = 99) # me-non-aktifkan scientific notation
library(tidyverse) # koleksi beberapa package R
library(plotly) # plot interaktif
library(glue) # setting tooltip
library(scales) # mengatur skala pada plot


# --------- READ DATA 

covids <- read_csv("data_input/covid.csv", locale = locale(encoding = "latin1"))

# --------- DATA PREPARATION

covids_clean <- covids %>% 
  mutate(benua = as.factor(benua),
         negara = as.factor(negara),
         tanggal = as.factor(tanggal))
         #total_kasus = as.factor(total_kasus),
         #total_kematian = as.factor(total_kematian))
         #likes_per_views = likes / views,
         #dislikes_per_views = dislikes / views,
         #comments_per_views = comment_count / views)

