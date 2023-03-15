library(tidyverse)
library(readxl)

vars_to_keep = c("RSA", "RMSSD")

# save current directory
files_dir <- paste0(getwd(), '/Mindware Compilers/HRV_data/')

# obtain the HRV excel file names from the "HRV_data" folder
files = list(list.files(files_dir))


for(file in files){
  id = str_replace(file, ".xlsx", "")
  df = read_excel(paste0(files_dir, file)) %>%
    filter(.[1] %in% vars_to_keep)
}
