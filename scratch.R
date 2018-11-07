# Scratch file for working with the files in data. I load (also known as
# "attach") the three libraries that are most useful, I think, for this sort of
# work. One of my roles is to point out which packages are useful. Including the
# package name (or "tidyverse" or "dplyr") when googling will often lead to
# better results than a straight google.

library(tidyverse)
library(stringr)
library(fs)
library(readr)
library(janitor)

# 1. Read data/ex_926_I.csv into a tibble and provide a summary.

data1 <- read_csv("data/ex_926_I.csv") %>%
  clean_names()

summary(data1)
head(data1)

# 2. Create a vector with all the file names in data/.

file_list <- dir_ls("data/")


# 3. Create a vector with just the file names that have an "A" in them.

str_subset(file_list, "A")

# 4. Read in all the files into one big tibble. Check out ?map_dfr . . .
# Background reading here:
# https://r4ds.had.co.nz/iteration.html#the-map-functions

x <- map_dfr(file_list, read_csv, .id = "source")

# 5. Read in everything and also add a new variable, source, which records the
# file name from which the data came.


# 6. Find the 4 files with the largest number of observations.

x %>%
  group_by(source) %>%
  summarize(total_obs = n()) %>%
  arrange(desc(total_obs))
  
# 7. Write a function which takes a character string like "A" and then reads in
# all the files which have "A" in the name.

file_list_A <- str_subset(file_list, "A")
data <- map_dfr(file_list_A, read_csv, .id = "source")

read_a_files <- function(x) {
  file_list <- dir_ls("data/")
  file_list_A <- str_subset(file_list, x)
  table <- map_dfr(file_list_A, read_csv, .id = "source")
  table
}

read_a_files("A")

# 8. Create a Shiny App which displays the histogram of b, allowing the user to
# subset the display for specific values of c.

