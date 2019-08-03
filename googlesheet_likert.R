library(googlesheets)
library(dplyr)

gs_gap() %>% 
  gs_copy(to = "Gapminder")
# google will ask you to let tidyverse-googlesheets access your account
# Allow


#list sheets
gs_ls()

#register the sheet for use
lik <- gs_title("likert_questionnaire (Responses)")
lik

# set up your survey anonymously

# list worksheets
gs_ws_ls(lik)

#read data in a worksheet
df <- gs_read(lik)
length(df)

# likert must have a data frame not a tibble
# just get the questions
df <- as.data.frame(df[3:length(df)])

# rename variables use sub, see rna seq
# but this will for time being
names(df) <- c("blue", "green", "red", "yellow", "purple")


my_levels <- c("Strongly disagree",
               "Disagree",
               "Neither agree nor disagree",
               "Agree",
               "Strongly agree")
# make a factor and relevel
df <- df %>% 
  mutate(blue = factor(blue, levels = my_levels),
         green = factor(green, levels = my_levels),
         red = factor(red, levels = my_levels),
         yellow = factor(yellow, levels = my_levels),
         purple = factor(purple, levels = my_levels))


library(likert)
library(psych)

col <- likert(df)
plot(col,type = "heat")
