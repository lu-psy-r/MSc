# Read in, clean up and output into a single file the responses to demographics questions 
# Gorilla: questionnaire-i5jp
# Assumes separate .csv files for each experiment/version/project/wave of data collection
# Optional: Can use function check.n() for checking n participants
# Main: 
# 1) Read in data files
# 2) Use function clean.demo() to pivot, select and rename relevant variables. For the first data file, assign output to a 
# new data frame (e.g., 'demo_dys').
# 3) For subsequent data files, use function clean.demo() again, but assign output to 'temp' and add rows to the original data frame.
# 4) Save results in new data file

## Amended on 21st Feb 2023 to recode values for bilingual_text to "english" for varieties
## in spelling ("English", "Enlish").

# Set-up ------------------------------------------------------------------
# Load relevant libraries
library(here)
library(tidyverse)

# Functions
## check n participants
check.n <- function(data){
obs <- length(data$`Event Index`)
data_n <- data.frame(matrix(ncol = 1, nrow = obs))
data_n$origID<- data$`Participant Private ID`
data_n$origID <- as.factor(data_n$origID)
nsub <-length(levels(data_n$origID)) ### count and print subjects
print(paste0("subjects: ", nsub))
}

clean.demo <- function(data){
  data %>%
    select("Participant Private ID", "Task Name", "Task Version", "Question Key", "Response") %>%
    filter(!.data$`Question Key` == "BEGIN QUESTIONNAIRE") %>%
    filter(!.data$`Question Key` == "END QUESTIONNAIRE") %>%
    pivot_wider(names_from = `Question Key`, values_from = Response) %>%
    rename(origID = `Participant Private ID`,
           age = Age,
           gender = Gender,
           gender_text = `Gender-text`,
           bilingual_text = `bilingual-text`,
           handedness = categorical_hand) %>%
    mutate(origID = as.factor(origID),
           age = as.numeric(age)) %>%
    mutate (bilingual_text = recode(bilingual_text,
                                    english = "english", English = "english", Enlish = "english")) %>%
    select(origID, age, gender, gender_text, bilingual, bilingual_text, handedness)
}

# 1) Read in data files -----------
demo_sona_jan22 <- read_csv(here("colaLU_06data/colaLU_data_20221213/colaLU_data_20221213_all", "data_exp_73620-v5_questionnaire-i5jp.csv"))
demo_slv11_jan22 <- read_csv(here("colaLU_06data/colaLU_data_20221213/colaLU_data_20221213_all", "data_exp_72623-v11_questionnaire-i5jp.csv"))
demo_slv13_jan22 <- read_csv(here("colaLU_06data/colaLU_data_20221213/colaLU_data_20221213_all", "data_exp_72623-v13_questionnaire-i5jp.csv"))
demo_sona_nov22 <- read_csv(here("colaLU_06data/colaLU_data_20221213/colaLU_data_20221213_all", "data_exp_106838-v2_questionnaire-i5jp.csv"))
demo_sl_nov22 <- read_csv(here("colaLU_06data/colaLU_data_20221213/colaLU_data_20221213_all", "data_exp_72623-v17_questionnaire-i5jp.csv"))
demo_pl_nov22 <- read_csv(here("colaLU_06data/colaLU_data_20221213/colaLU_data_20221213_all", "data_exp_110210-v3_questionnaire-i5jp.csv"))

# 2) For first data file -----------
n <- check.n(demo_sona_jan22) # check number of participants in data file
demo_dys <- clean.demo(demo_sona_jan22) # first data file: pivot, select and rename relevant variables

# 3) For subsequent data files -----------
## demo_slv11_jan22
n <- check.n(demo_slv11_jan22) # check number of participants in data file
temp <- clean.demo(demo_slv11_jan22) # subsequent data files: pivot, select and rename relevant variables

demo_dys <- demo_dys %>% # add participants 'temp' to main data frame
  add_row(temp)

## demo_slv13_jan22
n <- check.n(demo_slv13_jan22) # check number of participants in data file
temp <- clean.demo(demo_slv13_jan22) # subsequent data files: pivot, select and rename relevant variables

demo_dys <- demo_dys %>% # add participants 'temp' to main data frame
  add_row(temp)

## demo_sona_nov22
n <- check.n(demo_sona_nov22) # check number of participants in data file
temp <- clean.demo(demo_sona_nov22) # subsequent data files: pivot, select and rename relevant variables

demo_dys <- demo_dys %>% # add participants 'temp' to main data frame
  add_row(temp)

## demo_sl_nov22
n <- check.n(demo_sl_nov22) # check number of participants in data file
temp <- clean.demo(demo_sl_nov22) # subsequent data files: pivot, select and rename relevant variables

demo_dys <- demo_dys %>% # add participants 'temp' to main data frame
  add_row(temp)

## demo_pl_nov22
n <- check.n(demo_pl_nov22) # check number of participants in data file
temp <- clean.demo(demo_pl_nov22) # subsequent data files: pivot, select and rename relevant variables

demo_dys <- demo_dys %>% # add participants 'temp' to main data frame
  add_row(temp)

# 4) Save results in new data file -----------
write_csv(demo_dys, here("colaLU_06data/colaLU_data_processed", "demo_dys_20230221.csv"))

test <- read_csv(here("colaLU_06data/colaLU_data_processed", "demo_dys_20230221.csv"))



####################################
# Original piped code
demo_dys <- demo_sona_jan22 %>%
  select(`Participant Private ID`, `Task Name`, `Task Version`, `Question Key`, `Response`) %>%
  filter(!`Question Key` == "BEGIN QUESTIONNAIRE") %>%
  filter(!`Question Key` == "END QUESTIONNAIRE") %>%
  pivot_wider(names_from = `Question Key`, values_from = Response) %>%
  rename(origID = `Participant Private ID`,
         age = Age,
         gender = Gender,
         gender_text = `Gender-text`,
         bilingual_text = `bilingual-text`,
         handedness = categorical_hand) %>%
  mutate(origID = as.factor(origID)) %>%
  select(origID, age, gender, gender_text, bilingual, bilingual_text, handedness)



