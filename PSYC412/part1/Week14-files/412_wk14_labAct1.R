# PSYC402: Week 15 - Lab activities

# Our research question: Is gesture perception associated with different aspects of
# hand shape?

# Step 1: Set-up ----------------------------------------------------------

# Empty R environment
rm(list=ls())                            

# Load relevant libraries
library(tidyverse)
library(broom)

# TASK: Read in the data file; call it "ges". Have
# a look at the data file.
# HINT: Use the read_csv() and head() functions.




# Step 2: Descriptive statistics ------------------------------------------
# As part of the pre-lab activities, you've already familiarised yourself with the dataset
# by looking at:
# - how participants were distributed across the pinkie curl conditions;
# - which response option was chosen more frequently in total and across pinkie curl conditions;
# - proportions of response options across pinkie curl conditions
#
# TASK: Please remind yourself of these stages if necessary by revisiting the chaper12_6.R script.


# Step 3: Data wrangling --------------------------------------------------
# For logistic regression, the outcome variable needs to either be coded as 0 or 1,
# or it needs to be coded as a factor.
#
# TASK: Write the code to convert the outcome variable to a factor
# HINT: Use mutate() and factor()



# As with linear regression, centering your predictor makes it easier to interpret
# the output of a logistic regression.

# TASK: Write the code to center the pinkie curl predictor



# Step 4: Fit the regression model ----------------------------------------
# Now let's re-fit choice (height vs. shape) as a function of pinkie curl,
# but using the centered variable.

# TASK: Write the code to fit the model
# HINT: Use the glm() function and remember you need to specify the 'family' argument.



# TASK: Write the code to check coefficients.
# HINT: Use the tidy() function.



# QUESTION: How does the coefficient table differ from the model fitted earlier where
# you used the pinkie curl precictor before you centered it?
# ANSWER: 
#
# QUESTION: How should you now (using the model with the centered pinkie curl predictor)
# interpret the intercept?
# ANSWER: 

# The average pinkie curl is step 5 on the 9 step continuum. From our previous
# analysis (pre-lab activity), we know that the predicted log odds of 'shape'
# at that step was 0.38 and the probability was 0.59.
# So if we extract the intercept from the coefficient table of the model using the
# centered predictor, we should get those values.

# Extracting the estimate for the intercept and storing it in an object called intercept:

intercept_logOdds <- tidy(ges_mdl_c)$estimate[1]

# Getting the predicted probability by applying the logistic:

intercept_prob <- plogis(intercept_logOdds)

intercept_logOdds
intercept_prob

# The values are roughly the same! 


# Step 5: Incorporating a second predictor --------------------------------
# In addition to the 'pinkie curl', the extent to which the index finger is curved
# may also affect gesture perception. This is quantified in the 'index_curve' variable.

# Before we fit the model, we need to center both predictors.

# TASK: Write the code to center both predictors


# TASK: Write the code to fit model with both pinkie curl and index curve
# HINT: Use glm() and don't forget to specify the 'family' argument


# TASK: Write the code to check coefficients
# HINT: Use tidy()



# QUESTION: How does the index_curve predictor affect the proportion of shape responses?
# ANSWER: 


# We can see this if we compare to descriptive proportions:
index_tab <- with(ges, table(index_curve, choice))
index_tab

# Check proportions:
prop.table(index_tab, 1)

# The "1" in here stands for row-wise proportions."2" would compute column-wise proportions.
