# Read in, clean up and output into a single file the responses to demographics questions 
# Gorilla filename: questionnaire-i5jp
# Main: 
# 1) Read in data file.
# 2) Extract relevant columns and rows, pivot and rename and recode variables
# 3) Save results in new data file.

# Set-up ------------------------------------------------------------------
# Load relevant libraries
library(tidyverse)

# 1) Read in data file -----------
demo <- read_csv("Week12-files/data_exp_72623-v17_questionnaire-i5jp.csv")

# 2) Extract relevant columns and rows, pivot and rename and recode variables
demo_proc <- demo %>%
  select(`Participant Private ID`, `Question Key`, `Response`) %>%
  filter(!`Question Key` == "BEGIN QUESTIONNAIRE") %>%
  filter(!`Question Key` == "END QUESTIONNAIRE") %>%
  pivot_wider(names_from = `Question Key`, values_from = Response) %>%
  rename(origID = `Participant Private ID`,
         age = Age,
         gender = Gender,
         gender_text = `Gender-text`,
         bilingual_text = `bilingual-text`,
         handedness = categorical_hand) %>%
  select(origID, age, gender, gender_text, bilingual, bilingual_text, handedness) %>%
  mutate(gender = dplyr::recode(gender,
                                `Male` = "Man",
                                `Female` = "Woman",
                                `Other (please specify)` = "Other")) %>%
  mutate(bilingual = dplyr::recode(bilingual,
                                   `Yes. My strongest language is:` = "Yes")) %>%
  mutate(origID = as.factor(origID),
         age = as.numeric(age),
         gender = as.factor(gender),
         handedness = as.factor(handedness))

# 3) Save results in new data file -----------
write_csv(demo_proc, ("Week12-files/demo_proc.csv"))
