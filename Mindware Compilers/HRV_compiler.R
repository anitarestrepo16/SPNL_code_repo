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
    filter(`Segment Number` %in% vars_to_keep)
  df2 = as_tibble(t(df))[2:nrow(df2), ]
  names(df2) = vars_to_keep
  df2$Segment = c(seq(1, nrow(df2)))
  df2$id = id
  
}
