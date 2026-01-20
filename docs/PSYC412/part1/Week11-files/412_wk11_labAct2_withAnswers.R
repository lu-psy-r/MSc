# PSYC412: Week 11 - Lab activity 2

# Step 1: Background and set up -------------------------------------------

# Empty R environment
rm(list=ls())                            

# Load relevant libraries
library(broom)
library(car)
library(tidyverse)

# Read in the data
acoustics <- read_csv("voice_acoustics.csv")
ratings <- read_csv("voice_ratings.csv")

# Have a look at the data
acoustics
ratings

# QUESTION 1: How are the acoustics data and the ratings data organised (wide or long)? Are both data files 'tidy'? 
#
# ANSWER: Recall the difference between wide and long data. In wide data, each row represents an individual
# case, with observations for that case in separate columns; in long data, each row represents a single
# observation, and the observations are grouped together into cases based on the value of a variable (for these
# data, the VoiceID variable). The acoustics data file is tidy and in the long format. The ratings data is in
# the wide format.


# Step 2: Restructuring the ratings data ----------------------------------

# We are going to need to do some data-wrangling before we do any analysis! Specifically, we need the change
# the ratings data to the long format.
#
# TASK: Use the pivot_longer() function to restructure the ratings data from wide to long and store the resulting table
# as 'ratings_tidy'.

ratings_tidy <- pivot_longer(
  data = ratings, # the data you want to restructure
  cols = P1:P28, # columns you want to apply th above to
  names_to = "participant", # variable name that captures whatever is across the columns you are restructuring, in this case P1 to P28 for the 28 different participants)
  values_to = "rating") # variable name that captures whatever is in the cells (in this case numbers for ratings)


# Step 3: Calculate mean trustworthiness rating for each voice ------------

# TASK: Now that we’ve gotten the ratings data into a tidy format, the next step is to calculate the mean rating
# for each voice. Remember that each voice is identified by the VoiceID variable. Store the resulting table in
# a variable named ratings_mean.
#
# HINT: Use group_by() and summarise(). Are you using the tidy data? Also, remember that if there are any
# missing values (NAs) then na.rm = TRUE would help.

ratings_mean <- ratings_tidy %>% 
  group_by(VoiceID) %>% 
  summarise(mean_rating = mean(rating))


# Step 4: Join the data together -----------------------------------------

# Ok, before we get ahead of ourselves, in order to perform the regression analysis we need to combine the data
# from ratings_mean (the mean ratings) with acoustics (the pitch and dispersion ratings). Also, as we said, we
# only want to analyse male voices today.
#
# TASK: Join the two tables and keep only the data for the male voices, call the resulting table 'joined'.
#
# HINT: Use the inner_join() function (making use of the variable that is common across both tables) to join. Use 
# the filter() to only keep male voices. Remember that the Boolean operator for exactly equal is ==.

joined <- ratings_mean %>%
  inner_join(acoustics, "VoiceID") %>% 
  filter(sex == "M")

# Step 5: Spreading the data ----------------------------------------------

# Ok so we are starting to get an understanding of our data and we want to start thinking about the regression.
# However, the regression would be easier to work with if Pitch and Dispersion were in separate columns. This
# can be achieved using the spread() function. It is a bit like the reverse of gather(). It takes the data and
# you tell it which values you want spread and by which column (though in the order of data, column, value).
# Run the code below to do this.

joined_wide <- joined %>%
  pivot_wider(
    names_from = measures, # name of the categorical column to spread
    values_from = value) # name of the data to spread

# QUESTION 2: Why do we not need to specify within the `pivot_wider()` function which data to use?

# ANSWER: Because we use the function in a pipe. The data to be used is specified before the %>% sign.
# For more info on pipes see here: https://r4ds.had.co.nz/pipes.html?q=pipes#pipes

# Step 6: Visualising the data --------------------------------------------

# As always, it is a good idea to visualise your data.
#
# TASK: Now that we have all the variables in one place, make two scatterplots, one of mean trustworthiness
# rating with dispersion and one for mean trustworthiness rating and pitch.
#
# HINT: For this you'll need the ggplot() function together with geom_point() and geom_smooth(). Make
# sure to give your axes some sensible labels.

ggplot(joined_wide, aes(x = Dispersion, y = mean_rating)) +
  geom_point() +
  geom_smooth(method = "lm") +
  theme_bw() +
  labs (y = "Mean Trustworthiness Rating")

ggplot(joined_wide, aes(x = Pitch, y = mean_rating)) +
  geom_point() +
  geom_smooth(method = "lm") +
  theme_bw() +
  labs (y = "Mean Trustworthiness Rating")

# QUESTION 3: According to the scatterplot, how would you decribe the relationships between trustworthiness
# and dispersion and trustworthiness and pitch in terms of direction and strength? Which one of the two 
# seems stronger?
#
# ANSWER: According to the scatterplot, there appears to be a positive relationship between both pitch and
# trustworthiness and dispersion and trustworthiness, but the relationship with pitch seems stronger (because
# the data point fall slightly closer to the line of best fit).


# Step 7: Conducting and interpreting simple regression -----------------------

# With all the variables in place, we're ready now to start building the regression models.
#
# TASK: Use the lm() function to run the following two regression models and use the summary() function to
# look at the output of each model:
# 1. Run the simple linear regression of predicting trustworthiness mean ratings from Pitch, and store the model in mod_pitch.
# 2. Run the simple linear regression of predicting trustworthiness mean ratings from Dispersion, and store the model in mod_disp.
#
# HINT: lm(dv ~ iv, data = my_data)

mod_disp <- lm(mean_rating ~ Dispersion, joined_wide)
mod_disp_sum <- summary(mod_disp)
  
mod_pitch <- lm(mean_rating ~ Pitch, joined_wide)
mod_pitch_sum <- summary(mod_pitch)

# QUESTION 4: What do you conclude from the output of these models? Which model is significant? Which predictors
# are significant? How much variance does each model describe?
#
# ANSWER: Overall, the Pitch only model is significant (F(1,30) = 14.83, p < .001) and describes 30.9% of the variance.
# In contrast, the Dispersion only model is not actually significant (F(1,30) = 1.98, p = .17) meaning that it 
# is not actually any use as a model. This is backed up by it only explaining 3.1% of the variance.


# Step 8: Conducting and interpreting multiple regression -----------------

# Now let's look at both predictors in the same model. Before we do this, it is sensible to center and standardise
# the predictors.
#
# TASK: Look at the code below. Can you follow how the predictors are first centered (_c) and then standardised (_z)?
# Here I do this by hand because I think it makes it clearer, even though there are functions that do this in
# one step. If you want to know more, type ?scale() in the console window and read the help on that function.
# Now run the code.

joined_wide <- mutate(joined_wide,
                      Dispersion_c = Dispersion - mean(Dispersion),
                      Dispersion_z = Dispersion_c / sd(Dispersion_c),
                      Pitch_c = Pitch - mean(Pitch),
                      Pitch_z = Pitch_c / sd(Pitch_c))

# TASK: Now use the centered and standardised data for the multiple regression. Use the lm() function to run
# a model for predicting trustworthiness mean ratings from Pitch and Dispersion, and store the model in
# mod_pitchdisp_z. Use the summary() function to look at the output.
#
# HINT: lm(dv ~ iv1 + iv2, data = my_data)

mod_pitchdisp_z <- lm(mean_rating ~ Pitch_z + Dispersion_z, joined_wide)
mod_pitchdisp_z_sum <- summary(mod_pitchdisp_z)

# QUESTION 5: What do you conclude from the output of this model? Is the overall model significant? Which predictors
# are significant? How much variance does the model describe? Which model would you say is best for predicting
# ratings of trustworthiness, the Pitch only, the Dispersion only or the Pitch+Dispersion model?
#
# ANSWER: Looking at the multiple linear regression model which contains both pitch and dispersion we can see
# that it is a useful model ((F(2,29) = 7.81, p = .002) explaining 30.5% of the variance). However only pitch 
# is a significant predictor in this model (beta = 0.41, p = .001), whereas dispersion is not
# (beta  = 0.11, p = .361) and the multiple regression model actually describes less variance than
# the pitch alone model. There is an argument to be made that the pitch only model is the best
# model in the current analysis (describes more variance and is more parsimonious than the pitchdisp model).


# Step 9: Checking assumptions --------------------------------------------

# Now that we've established which model best fits the data, let's check whether it meets the assumptions of
# linearity, normality and homoscedasticity. 
#
# HINT: crPlots() to check linearity
#       qqPlot() and shapiro.test() to check normality of the residuals
#       residualPlot() and nvcTest() to check homoscedasticity of the residuals
#
# QUESTION 6: What do you conclude from the graphs and output? Should we also check for collinearity?
#
# ANSWER: The component+residual plot suggest that the relationship is linear, while the qq-plot and the 
# result from the Shapiro Wilk test (not significant) suggest that the residuals are normally distributed. The
# residuals are also homoscedastic, judging from the residual plot and the output of the non-constant variance
# test (not significant).

crPlots(mod_pitch)

qqPlot(mod_pitch$residuals) 
shapiro.test(mod_pitch$residuals)

residualPlot(mod_pitch)
ncvTest(mod_pitch)


# Step 10: Writing up the results -----------------------------------------

# TASK: Write up the results follow APA guidelines.
#
# HINT: The Purdue writing lab website (https://owl.purdue.edu/owl/research_and_citation/apa6_style/apa_formatting_and_style_guide/statistics_in_apa.html)
# is helpful for guidance on punctuating statistics. The APA Style 7th Edition Numbers and Statistics Guide (https://apastyle.apa.org/instructional-aids/numbers-statistics-guide.pdf) is also useful.
#
# ANSWER: Three regression models were fitted with mean rating for voice trustworthiness as outcome
# variable. The predictor variables were pitch only, dispersion only, or both pitch and dispersion.
# Using overall model significance and adjusted R-squared as a guide, it was concluded that the pitch only
# model best fitted the data. The pitch only model significantly predicted trustworthiness (F(1, 30) = 14.83,
# p < .001, Adjusted R2 = 0.31), accounting for 31% of the variance. Pitch was a significant
# positive predictor (β = 0.02, p < 0.001); when pitch increased, trustworthiness also increased (see also Figure X).
# The results for the dispersion only and the pitch and dispersion models can be seen in Table X.
