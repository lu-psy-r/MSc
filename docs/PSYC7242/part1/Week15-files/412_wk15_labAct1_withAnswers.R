# Lab activity 1: Visual dominance

# Research question: Do English speakers use 'visual' adjectives more frequently than
# adjectives more strongly associated with other sensory modalities?

#### Step 1: Set up
# Clear the environment
rm(list=ls())

# Load libraries
library(tidyverse)
library(broom)
library(MASS)
library(pscl)

# Read in the data
lyn <- read_csv('lynott_connell_2009_modality.csv')
ELP <- read_csv('ELP_full_length_frequency.csv')

# Have a look at the data
head(lyn)
head(ELP)
  
#### Step 2: A bit of data wrangling

# Combine the data from the two data files and select the relevant variables
both <- left_join(x = lyn, y = ELP, by = 'Word') %>% 
	dplyr::select(Word, DominantModality:Smell, Log10Freq)

# Note the use of dplyr:: to avoid a naming conflict with the select() function from the MASS
# library.

# Get positive integeres (i.e., raw values):
both <- mutate(both, Freq = 10 ^ Log10Freq)

#### Step 3: Visualise the data
ggplot(both, aes(x = Sight, y = Freq)) +
  geom_point() +
  geom_smooth(method = "lm", se = TRUE) +
  theme_bw() +
  ylim(c(0, 20000))

ggplot(both, aes(x = Touch, y = Freq)) +
  geom_point() +
  geom_smooth(method = "lm", se = TRUE) +
  theme_bw()  +
  ylim(c(0, 20000))  

ggplot(both, aes(x = Sound, y = Freq)) +
  geom_point() +
  geom_smooth(method = "lm", se = TRUE) +
  theme_bw() +
  ylim(c(0, 20000))

ggplot(both, aes(x = Taste, y = Freq)) +
  geom_point() +
  geom_smooth(method = "lm", se = TRUE) +
  theme_bw() +
  ylim(c(0, 20000))

ggplot(both, aes(x = Smell, y = Freq)) +
  geom_point() +
  geom_smooth(method = "lm", se = TRUE) +
  theme_bw() +
  ylim(c(0, 20000))

#### Step 4: The regression model
# Fit Poisson regression with continuous predictors
freqMod <- glm(Freq ~ Sight + Taste + Smell + Sound + Touch,
               data = both,
               family = poisson)

summary(freqMod)

#### Step 5: Overdispersion
# Fit negative binomial regression
freqMod_nb <- glm.nb(Freq ~ Sight + Taste + Smell + Sound + Touch,
	data = both)
summary(freqMod_nb)

# See whether negative binomial regression is warranted.
odTest(freqMod_nb)


