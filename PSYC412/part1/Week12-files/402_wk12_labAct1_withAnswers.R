# PSYC402: Week 12 - Lab activity 1

# Our research question: Does the negative association between hours of use and well-being (beyond the 
# one-hour point) differ for adolescent boys and girls?


# Step 1: Background and set-up ------------------------------------------------------------------
#
# Empty R environment
rm(list=ls())                            

# Load relevant libraries
library(broom)
library(car)
library(tidyverse)

# Read in the data
pinfo <- read_csv("participant_info.csv")                                   
screen <- read_csv("screen_time.csv")
wellbeing <- read_csv("wellbeing.csv")

# Step 2: Checking the formatting -----------------------------------------
head(pinfo)                                                         # Look at the data frames
head(screen)
head(wellbeing)

# Recode the sex variable to reflect word labels of female and male. 
pinfo$sex <- ifelse(pinfo$sex == 1, "male", "female")
head(pinfo)

# Step 3: Data preparation - Aggregating the total well-being scores ------------------------
wb_tot <- wellbeing %>%
  pivot_longer(-Serial, names_to = "question", values_to = "score") %>%
  group_by(Serial) %>%
  summarise(tot_wellbeing = sum(score))

# Calculate some descriptive statistics for the wb_tot data.
wb_tot %>% summarise(mean = mean(tot_wellbeing),
                     sd = sd(tot_wellbeing),
                     min = min(tot_wellbeing), 
                     max = max(tot_wellbeing))

# Visualise the distribution in a histogram
ggplot(wb_tot, aes(tot_wellbeing)) +
  geom_histogram() 

# Step 4: Data preparation - Transforming screen time data -----------------------------------------

# Split the character strings already in the dataset;
screen_long <- screen %>%                                          # take the 'screen' data, and then
  pivot_longer(-Serial, names_to = "var", values_to = "hours") %>% # transform them to a 'long' format using the names of the variables and the values that go with them, leave the 'Serial' variable as it is, and then
  separate(var, c("variable", "day"), "_")                         # separate the "var" variable into components so that we have type of screen time and the days on which it happened in separate variables
                                                                   # save it in a new dataframe called screen_long

# Recode the values in the `screen_long` variable
screen2 <- screen_long %>%                                         # take the 'screen_long' data, and then
  mutate(variable = dplyr::recode(variable,                        # make a new variable and use the recode function from the dplyr package
                                  "Watch" = "Watching TV",         # with four levels, recoding old labels to new ones
                                  "Comp" = "Playing Video Games",
                                  "Comph" = "Using Computers",
                                  "Smart" = "Using Smartphone"),
         day = dplyr::recode(day,                                  # do this for the day variables as well
                             "wk" = "Weekday",
                             "we" = "Weekend"))
                                                                   # save it to an object called screen2

# Join wb_tot and screen_2 by participant, group by the variables "variable", "day" and "hours"
# and then calculate a "mean_wellbeing" variable for each of the grouped levels
dat_means <- inner_join(wb_tot, screen2, "Serial") %>%
  group_by(variable, day, hours) %>%
  summarise(mean_wellbeing = mean(tot_wellbeing))

# 4.4: Visualise your dat_means table
ggplot(dat_means, aes(x = hours, y = mean_wellbeing,)) +
  geom_line() +
  geom_point() +
  theme_bw()

ggplot(dat_means, aes(x = hours, y = mean_wellbeing, linetype = day)) +
  geom_line() +
  geom_point() +
  theme_bw()

ggplot(dat_means, aes(hours, mean_wellbeing, linetype = day)) + # plot 'hours' on the x-axis, 'mean_wellbeing' on the y-axis and use a different type of line for the levels of 'day'
  geom_line() + # add a line
  geom_point() + # add point data
  facet_wrap(~variable, nrow = 2) + # plot separate plots for each level of 'variable'
  theme_bw() # use the 'black and white' theme

# Step 5: Calculating mean hours per day for smartphone use, for each participant-----------------
smarttot <- screen2 %>% # use 'screen2'
  filter(variable == "Using Smartphone") %>% # filter out the observations for 'Using Smartphone'
  group_by(Serial) %>% # group together each participant
  summarise(hours_per_day = mean(hours)) #summarise the mean hours calling it 'hours_per_day'

smart_wb <- smarttot %>% # take the smarttot data, and then
  filter(hours_per_day > 1) %>% # collect hours of day observations that are greater than one, and then
  inner_join(wb_tot, "Serial") %>% # join that with the wb_tot data by participant, and then
  inner_join(pinfo, "Serial") %>% # join that dataset with the pinfo dataset by participant, and then
  mutate(sex = as.factor(sex)) # change the sex variable so that it is a factor

# save it all in a dataframe called smart_wb

str(smart_wb)

# Step 6: More visualisation ---------

# Further grouping of data
smart_wb_gen <- smart_wb %>% # take the smart_wb data, and then
  group_by(hours_per_day, sex) %>% # group by the different levels of hours of the day and by sex, and then
  summarise(mean_wellbeing = mean(tot_wellbeing)) # calculate a mean score of the total well-being scores within those groups, calling that mean_wellbeing.
# save it in a dataframe called smart_wb_gen

# Visualise...
ggplot(smart_wb_gen, aes(hours_per_day, mean_wellbeing, color = sex)) +
  geom_point() +
  geom_smooth(method = "lm") +
  scale_color_discrete(name = "Sex", labels = c("Girls", "Boys"))+
  scale_x_continuous(name = "Total hours smartphone use") +
  scale_y_continuous(name = "Mean well-being score") +
  theme_bw()

# Step 7: The regression model  ------------------------------------------------------------------

# Running the regression lm(y ~ x1 + x2 + x1:x2, data) 
mod <- lm(tot_wellbeing ~ hours_per_day + sex + hours_per_day:sex, smart_wb)

# Call and save the summary of your model as "mod_summary"; then have a look at it.
mod_summary <- summary(mod)
mod_summary

# Check that the sex variable is treatment or dummy coded
contrasts(smart_wb$sex)

# Copy the sex variable, and give it an indicative name
smart_wb <- mutate(smart_wb, sexSum = sex)

# Set the deviation coding (we'll label it Sum here for easy variable naming)
contrasts(smart_wb$sexSum) <- contr.sum(2)

# Look at the output for the sum coded sex variable
contrasts(smart_wb$sexSum)

# Run the regression model again, using the sumcoded sex model and compare outputs
mod_S <- lm(tot_wellbeing ~ hours_per_day + sexSum + hours_per_day:sexSum, smart_wb)
mod_S_summary <- summary(mod_S)

# Compare the two model summary outputs
mod_summary
mod_S_summary

# Step 8: Checking assumptions  ------------------------------------------------------------------

# Normality:
# QQ-plot to check the residuals are normally distributed
qqPlot(mod$residuals)       

# Homoscedasticity:
par(mfrow=c(2,2))             # 4 charts in 1 panel
plot(mod)                     # this may take a few seconds to run

# Multi-collinearity:
vif(mod)                      # Check for multi-collinearity
