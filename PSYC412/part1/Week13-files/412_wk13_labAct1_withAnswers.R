# PSYC402: Week 14 - Lab activities

# Our research question: Do professors' beauty score and age predict how
# students evaluate their teaching?

# Step 1: Set-up ------------------------------------------------------------------
#
# Empty R environment
rm(list=ls())                            

# Load relevant libraries
library(broom)
library(car)
library(lsr)
library(tidyverse)


beauty <- read_csv("beauty.csv")    
head(beauty)

# Step 2: Descriptive statistics and distributions ------------------------------------------

descriptives <- beauty %>% 
  summarise(mean_age = mean(age, na.rm = TRUE),
            sd_age = sd(age, na.rm = TRUE),
            min_age = min(age, na.rm = TRUE),
            max_age = max(age, na.rm = TRUE),
            mean_eval = mean(eval, na.rm = TRUE),
            sd_eval = sd(eval, na.rm = TRUE),
            min_eval = min(eval, na.rm = TRUE),
            max_eval = max(eval, na.rm = TRUE),
            mean_beauty = mean(beauty, na.rm = TRUE),
            sd_beauty = sd(beauty, na.rm = TRUE),
            min_beauty = min(beauty, na.rm = TRUE),
            max_beauty = max(beauty, na.rm = TRUE))
            
# historgrams
ggplot(data = beauty, aes(beauty)) + geom_histogram()

ggplot(data = beauty, aes(eval)) + geom_histogram()

ggplot(data = beauty, aes(age)) + geom_histogram()

# Step 3: Center and standardise ------------------------------------------

beauty_z <- beauty %>%
  mutate(age_z = (age - mean(age, na.rm = TRUE)) / sd(age),
         beauty_z = (beauty - mean(beauty, na.rm = TRUE)) / sd(beauty))

# Step 4: Scatterplots ----------------------------------------------------

ggplot(beauty, aes(x = beauty, y = age)) +
  geom_point() +
  geom_smooth(method = "lm", se = TRUE) +
  theme_bw()

ggplot(beauty, aes(x = beauty, y = eval)) +
  geom_point() +
  geom_smooth(method = "lm", se = TRUE) +
  theme_bw()

ggplot(beauty, aes(x = age, y = eval)) +
  geom_point() +
  geom_smooth(method = "lm", se = TRUE) +
  theme_bw()

ggplot(beauty_z, aes(x = beauty_z, y = age_z)) +
  geom_point() +
  geom_smooth(method = "lm", se = TRUE) +
  theme_bw()

ggplot(beauty_z, aes(x = beauty_z, y = eval)) +
  geom_point() +
  geom_smooth(method = "lm", se = TRUE) +
  theme_bw()

ggplot(beauty_z, aes(x = age_z, y = eval)) +
  geom_point() +
  geom_smooth(method = "lm", se = TRUE) +
  theme_bw()

# Intercorrelations
beauty_matrix <- beauty_z %>%
  select(eval, age_z, beauty_z) %>% # only keep relevant variables
  as.data.frame() # tell R it is a specific type of data frame (needed for the correlate() function)

pairs(beauty_matrix) # make multiple scatterplots in one go

intercor_results <- correlate(x = beauty_matrix, # our data
                              test = TRUE, # compute p-values
                              corr.method = "pearson", # run a spearman test 
                              p.adjust.method = "bonferroni") # use the bonferroni correction
intercor_results

# Step 5: The regression model  ------------------------------------------------------------------

# A model without an interaction term

mod <- lm(eval ~ age_z + beauty_z, data = beauty_z)

mod_summary <- summary(mod)
mod_summary


# Model that includes an interaction term for the two predictors.

mod_int <- lm(eval ~ age_z + beauty_z + age_z:beauty_z, data = beauty_z)
mod_int_summary <- summary(mod_int)
mod_int_summary

# Interpretation of coefficients in a multiple regression can be facilitated by 'added variable' plots
avPlots(mod_int)

# Creating a scatterplot with our outcome variable on the y-axis and the significant
# predictor on the x-axis and then plotting our third variable (age) using different colours
# gives some information. Do you see how high age scores (light blue + 2 SD) seem
# to be more frequent in the bottom left corner?

ggplot(data = beauty_z, aes(x = beauty_z, y = eval, colour = age_z)) +
  geom_point() +
  geom_smooth(method = "lm", se = TRUE, colour = 'black') +
  theme_bw() +
  labs(x = "Beauty score", y = "Teaching evaluation score")


# But it might be more useful to plot different regression lines for different
# values of age. We can do this be transforming age into a categorical variable
# for plotting purposes. The code below creates three categories, based on eye-balling
# the histogram for age:
# - youngest (40 and younger)
# - average (between 41 and 53)
# - oldest (54 and older).

beauty_z_ageCat <- beauty_z %>%
  mutate(ageCat = cut(
    age,
    breaks = c(0, 40, 54, Inf),
    labels = c("youngest","average","oldest")
    )
  )

ggplot(data = beauty_z_ageCat, aes(x = beauty_z, y = eval, colour = ageCat)) +
  geom_point() +
  geom_smooth(method = "lm", se = TRUE) +
  theme_bw() +
  labs(x = "Beauty score", y = "Teaching evaluation score")

# The line the oldest participants seems much steeper than for the other two groups,
# suggesting that the interaction between age and beauty is mostly driven by older
# participants who have received more extreme beauty scores. 

# Step 6: Checking assumptions  ------------------------------------------------------------------

# Normality:
qqPlot(mod_int$residuals)       

# Homoscedasticity:
par(mfrow=c(2,2))                 # 4 charts in 1 panel
plot(mod_int)                     # this may take a few seconds to run

# Multicollinearity:
vif(mod_int)                      # Check for multi-collinearity
