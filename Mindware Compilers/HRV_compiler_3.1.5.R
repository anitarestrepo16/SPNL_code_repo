library(tidyverse)
library(readxl)


compile <- function(directory = getwd(), vars_to_keep = c("Segment Number", "RSA", "RMSSD")) {
  directory = paste0(directory, "/")
  # obtain the excel file names
  files = c(list.files(directory, pattern = "*.xlsx$"))
  
  # extract data for each excel file
  df_out <- data.frame(matrix(ncol = (length(vars_to_keep) + 1), nrow = 0))
  colnames(df_out) <- c(vars_to_keep, "ID")
  for(file in files){
    # save file name as id 
    filename <- str_replace(file, ".xlsx", "")
    # read in the file
    df1 <- read_excel(paste0(directory, file)) 
    # filter the file
    df2 <- df1[40:nrow(df1), ] %>%
      # keep only relevant variables
      filter(Version %in% vars_to_keep)
    # transpose the df
    df3 <- as_tibble(t(df2))[3:nrow(t(df2)), ]
    # change column names
    names(df3) <- vars_to_keep
    # add id column
    df3$filename <- filename
    # append the subject data to the final df
    df_out = rbind(df_out, df3)
  }
  return(df_out)
}