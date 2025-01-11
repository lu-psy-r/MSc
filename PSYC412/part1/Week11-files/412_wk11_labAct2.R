# PSYC412: Week 11 - Lab activity 2

# Step 1: Background and set up -------------------------------------------

# Empty R environment
# ADD CODE HERE

# Load relevant libraries
# ADD CODE HERE

# In this lab, we are setting out to test whether a linear combination of pitch and dispersion will predict
# perceived vocal trustworthiness in male voices (see '402_wk12_overview.pdf' document for more info).
#
# We'll be working with two data files:
# voice_acoustics.csv - shows the VoiceID, the sex of the voice, and the pitch and dispersion values
# voice_ratings.csv - shows the VoiceID and the ratings of each voice by 28 participants on a scale of
# 1 to 9 where 9 was extremely trustworthy and 1 was extremely untrustworthy.
# 
# TASK: Read in both files (using the read_csv() function), have a look at the layout of the data and
# familiarise yourself with it. The ratings data is rather messy and in a different layout to the acoustics but
# can you tell what is what?

# Read in the data
# ADD CODE HERE

# Have a look at the data
# ADD CODE HERE

# QUESTION 1: How are the acoustics data and the ratings data organised (wide or long)? Are both data files 'tidy'? 


# Step 2: Restructuring the ratings data ----------------------------------

# We are going to need to do some data-wrangling before we do any analysis! Specifically, we need the change
# the ratings data to the long format.
#
# TASK: Use the `pivot_longer()` function to restructure the ratings data from wide to long and store the resulting table
# as 'ratings_tidy'.

# ADD CODE HERE


# Step 3: Calculate mean trustworthiness rating for each voice ------------

# TASK: Now that we’ve gotten the ratings data into a tidy format, the next step is to calculate the mean rating
# for each voice. Remember that each voice is identified by the VoiceID variable. Store the resulting table in
# a variable named ratings_mean.
#
# HINT: Use group_by() and summarise(). Are you using the tidy data? Also, remember that if there are any
# missing values (NAs) then na.rm = TRUE would help.

# ADD CODE HERE


# Step 4: Join the data together -----------------------------------------

# Ok, before we get ahead of ourselves, in order to perform the regression analysis we need to combine the data
# from ratings_mean (the mean ratings) with acoustics (the pitch and dispersion ratings). Also, as we said, we
# only want to analyse male voices today.
#
# TASK: Join the two tables and keep only the data for the male voices, call the resulting table 'joined'.
#
# HINT: Use the inner_join() function (making use of the variable that is common across both tables) to join. Use 
# the filter() to only keep male voices. Remember that the Boolean operator for exactly equal is ==.

# ADD CODE HERE


# Step 5: Spreading the data ----------------------------------------------

# Ok so we are starting to get an understanding of our data and we want to start thinking about the regression.
# However, the regression would be easier to work with if Pitch and Dispersion were in separate columns. This
# can be achieved using the pivot_wider() function. It the reverse of pivot_longer(). It takes the data and
# you tell it which values you want spread and by which column (though in the order of data, column, value).
# Run the code below to do this.

joined_wide <- joined %>%
  pivot_wider(
    names_from = measures, # name of the categorical column to spread
    values_from = value) # name of the data to spread 

# QUESTION 2: Why do we **not** need to specify within the `pivot_wider()` function which data to use?


# Step 6: Visualising the data --------------------------------------------

# As always, it is a good idea to visualise your data.
#
# TASK: Now that we have all the variables in one place, make two scatterplots, one of mean trustworthiness
# rating with dispersion and one for mean trustworthiness rating and pitch.
#
# HINT: For this you'll need the ggplot() function together with geom_point() and geom_smooth(). Make
# sure to give your axes some sensible labels.

# ADD CODE HERE

# QUESTION 3: Looking at the scatterplots, how would you describe the relationships between trustworthiness
# and dispersion and trustworthiness and pitch in terms of direction and strength? Which one of the two 
# seems stronger?


# Step 7: Conducting and interpreting simple regression -----------------------

# With all the variables in place and having gained a better understanding of our 
# data by inspecting the scatterplots, we're ready now to start building two simple linear regression models:
# 1. Predicting trustworthiness mean ratings from Pitch
# 2. Predicting trustworthiness mean ratings from Dispersion

# TASK: Use the `lm()` function to run the following two regression models and use the `summary()` function
# to look at the output of each model. Store the first model in a table called 'mod_pitch' and store the second model in 'mod_disp'.

# HINT: lm(dv ~ iv, data = my_data)

# ADD CODE HERE

# QUESTION 4: What do you conclude from the output of these models? Which model is significant? Which predictors
# are significant? How much variance does each model describe?


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

# ADD CODE HERE

# QUESTION 5: What do you conclude from the output of this model? Is the overall model significant? Which predictors
# are significant? How much variance does the model describe? Which model would you say is best for predicting
# ratings of trustworthiness, the Pitch only, the Dispersion only or the Pitch+Dispersion model?


# Step 9: Checking assumptions --------------------------------------------

# Now that we've established which model best fits the data, let's check whether it meets the assumptions of
# linearity, normality and homoscedasticity. 
#
# HINT: crPlots() to check linearity
#       qqPlot() and shapiro.test() to check normality of the residuals
#       residualPlot() and nvcTest() to check homoscedasticity of the residuals

# ADD CODE HERE

#
# QUESTION 6: What do you conclude from the graphs and output? Should we also check for collinearity?


# Step 10: Writing up the results -----------------------------------------

# TASK: Write up the results follow APA guidelines.
#
# HINT: The Purdue writing lab website (https://owl.purdue.edu/owl/research_and_citation/apa6_style/apa_formatting_and_style_guide/statistics_in_apa.html)
# is helpful for guidance on punctuating statistics. The APA Style 7th Edition Numbers and Statistics Guide (https://apastyle.apa.org/instructional-aids/numbers-statistics-guide.pdf) is also useful.
