


############################################################################################################


# In Week 7, we aim to develop skills in visualizing and testing the associations 
# between variables in psychological data

# We do this to learn how to answer research questions like:

# 1. What person attributes predict success in understanding?
# 2. Can people accurately evaluate whether they correctly understand written 
# health information?

# These kinds of research questions can be answered using methods like correlation 
# and linear models

# When we do these analyses, we will need to think about how we report the results:  
# -- we usually need to report the correlation, size and direction of r;
# -- we usually need to decide, is the correlation significant?

# We will consolidate and extend learning on data visualization:
# -- Use histograms to examine the distributions of variables;
# -- Learn to edit the histograms
# -- Use scatterplots to examine the relationships we may observe or predict
# -- Learn to edit the scatterplots

# The idea is that as we work, we will develop skills in producing appealing plots 
# for professional audiences  


# We will take things step-by-step


# -- I work through the parts, tasks and questions with similar data in:
# 401-associations-how-to.R
# -- If you are unsure how to do something, check that out and then come back here



############################################################################################################


# -- A note about terms --

# -- I will put dataset names in quotes like this: 
#   'study-one-general-participants.csv'
# -- I will put variable (data column) names in quotes like this: 'variable' 
# -- And I will put value or other data object (e.g. cell value) names in quotes 
# like this: 'studyone'

# -- This is to help you distinguish between the ordinary use of words like variable
# from the special use of these words when they are parts of datasets.


# -- A note about coding --

# -- I will structure the code in the practical work a bit differently from what 
# you have done until now when making plots  
# -- The reason for this change is because it will help you to keep clear what 
# you are doing, you increase the complexity and power of the plots


# We will take things step-by-step

# -- I will split .R scripts by parts, tasks and questions:  
# -- different parts for different phases of the analysis workflow;
# -- different tasks for different steps in each phase;
# -- different questions to examine different ideas or coding steps



############################################################################################################
## Part 1: Set-up ##########################################################################################


# -- Task 1 -- Run this code to empty the R environment
rm(list=ls())                            


# -- Task 2 -- Run this code to load relevant libraries
library("patchwork")
library("tidyverse")



############################################################################################################
############################################################################################################


# -- In this how-to guide, we use data from *a second* 2020 study of the response
# of adults from a UK national sample to written health information

# study-two-general-participants.csv

  

############################################################################################################
## Part 2: Load data #######################################################################################


# -- Task 3 -- Read in the first data file we will be using: 
# study-two-general-participants.csv
# -- hint: Task 3 -- Use the read_csv() function to read the data file into R
# -- hint: Task 3 -- When you read the data file in, give the data object you create a clear name 
# e.g. study.two.gen


# <-- enter your answer here -->


# -- Task 4 -- Inspect the data file
# -- hint: Task 4 -- Use the summary() or head() functions to take a look


# <-- enter your answer here -->


# -- Q.1. -- What is the median of 'AGE'?

# <-- enter your answer here -->


# -- Q.2. -- What class is the variable 'ETHNICITY'?

# <-- enter your answer here --> 


# -- Q.3. -- Does the summary indicate if any variable has missing values (NAs)?

# <-- enter your answer here -->


# -- Task 5 -- Change the class or type of the variable 'ETHNICITY' to factor
# -- hint: Task 5 -- You can use the as.factor() function you have used before

# <-- enter your answer here -->


# -- Q.4. -- After you have done this, what information does summary() give you 
# about the variable 'ETHNICITY'?

# <-- enter your answer here -->



############################################################################################################
## Part 3: Use histograms to examine the distributions of variables ########################################


# -- Task 6 -- Draw histograms to examine the distributions of variables
# -- hint: Task 6 -- Use ggplot() with geom_histogram()

# -- The first time we do this, we take things step-by-step
# -- Here's an example: run the line of code and see the result in the Plots window in R-Studio
ggplot(data = study.two.gen, aes(x = mean.acc)) + geom_histogram()


# -- Q.5. -- Did you get a message in black or red in the Console window in R-Studio: 
# what does it say?

# <-- enter your answer here -->


# -- Q.6. -- Draw two different histograms to examine the distributions of two 
# different variables: SHIPLEY and HLVA

# <-- enter your answer here -->


# -- Q.7. -- Now re-do both plots: can you change the binwidth in geom_histogram() to make the bars wider?
# -- hint: Q.7. -- If you are going to change binwidth the number you use needs to be a number larger than   
# the minimum and smaller than the maximum for the variable
# -- Here, we care about what minimum or maximum values the variable could
# have -- not about the observed minimium-maximum values in our sample data
# -- Shipley score can vary 0-40
# -- HLVA score can vary 0-16
# -- Remember, min and max values are given for each numeric variable in summary()

# <-- enter your answer here -->


# -- Q.8 -- How would you describe the distributions -- in a sentence -- of the distributions of the
# SHIPLEY and HLVA variable values for our sample?

# <-- enter your answer here -->



############################################################################################################
## Part 4: Edit your plots to make them look good ##########################################################


# -- Task 8 -- Edit the appearance of a histogram plot for *one numeric variable* 
# -- hint: Task 8 -- ggplot() code does not all have to be on the same line
# -- hint: Task 8 -- you can create a new plot for each edit so you can see what difference your edits make


# -- Q.9. -- Edit the appearance of the bars using binwidth

# <-- enter your answer here -->


# -- Q.10. -- Edit the colour of the background using theme_bw()

# <-- enter your answer here -->


# -- Q.11. -- Edit the appearance of the labels using labs()

# <-- enter your answer here -->


# -- Q.12. -- Edit the appearance of the bars by changing the fill in aes()
# -- hint: Q12 -- To figure out how to do this, you will need to first look at 
# the ggplot reference information online -- do a search with the keywords 
# "ggplot reference geom_histogram" and then come back to this
# -- hint: Q12 -- The example code in the reference information is always a good 
# place to find ideas you can use
# -- hint: Q12 -- You can ask for fill to be a specific colour e.g. "red" (use quotes)

# <-- enter your answer here -->



############################################################################################################
## Part 5: Now draw scatterplots to examine associations between variables #################################


# -- Task 9 -- Create a scatterplot to examine the association between some 
# variables e.g. 'HLVA' and 'mean.acc'
# -- hint: Task 9 -- We are working with geom_point() and you need x and y 
# aesthetic mappings

# <-- enter your answer here -->


# -- Task 10 -- Now do scatterplots with *every* numeric predictor variable in 
# the 'study.two.gen' dataset 
# -- hint: Task 10 -- You always want to use as the y-axis variable the 
# outcome 'mean.acc' so: y = mean.acc
# -- hint: Task 10 -- Then you can use each numeric predictor variable 
# as the x-axis variable e.g. x = mean.self

# -- hint: Task 10 -- Remember what we saw with summary(): not every variable 
# consists of numbers  
# -- hint: Task 10 -- If the summary() does not show you a mean for a variable, 
# R does not think that variable is numeric

# -- hint: Task 10 -- It can be hard to decide what an association looks like: 


# <-- enter your answer here -->


# -- Q.13. -- What is the shape (direction) of the association between 'mean.self' 
# and 'mean.acc'?

# <-- enter your answer here -->


# -- Q.14. -- What is the shape (direction) of the association between 'AGE' 
# and 'mean.acc'?

# <-- enter your answer here -->


# -- Q.15. -- What is the shape (direction) of the association between 'SHIPLEY' 
# and 'mean.acc'?

# <-- enter your answer here -->


# -- Q.16. -- What is the shape (direction) of the association between 'HLVA' 
# and 'mean.acc'?

# <-- enter your answer here -->


# -- Q.17. -- What is the shape (direction) of the association between 'FACTOR3' 
# and 'mean.acc'?

# <-- enter your answer here -->


# -- Q.18. -- What is the shape (direction) of the association between 'QRITOTAL' 
# and 'mean.acc'?

# <-- enter your answer here -->



############################################################################################################
## Part 6: Edit the scatterplots to make them look good ####################################################


# -- Task 11 -- Edit the appearance of one plot step-by-step


# -- We are going to edit:
# -- 1 -- the appearance of the points using alpha, size and colour
# -- 2 -- the colour of the background using theme_bw()
# -- 3 -- the appearance of the labels using labs()
# -- as follows


# -- Q.19. -- Change the appearance of the points using alpha, size and colour
# -- hint: Q.19. -- Just like with geom_histogram() there is ggplot reference 
# information for the geom you need here
# -- find some example code and come back here if you are unsure what to do

# <-- enter your answer here -->


# -- Q.20. -- Edit the colour of the background using theme_bw()

# <-- enter your answer here -->


# -- Q.21. -- Edit the appearance of the labels using labs()

# <-- enter your answer here -->


# -- Q.22. -- Can you find the ggplot reference page?
# -- hint: Q.22 -- Do a search with the keywords "ggplot reference geom_point"

# <-- enter your answer here -->


# -- Now you: experiment!



############################################################################################################
## Part 7: Use correlation to to answer the research questions #############################################


# -- Task 13 -- Examine the correlation between mean accuracy (mean.acc) and some numeric predictor variables
# -- hint: Task 13 -- We use cor.test()

# <-- enter your answer here -->


# -- Q.23. -- What is r (given as 'cor' in the output) for the correlation between 'HLVA' and 'mean.acc'?

# <-- enter your answer here -->


# -- Q.24. -- Is the correlation significant?

# <-- enter your answer here -->


# -- Q.25. -- What are the values for t and p for the significance test for the correlation?

# <-- enter your answer here -->


# -- Q.26. -- What do you conclude, given the correlation results?
# -- hint: Q.16 -- Maybe draw a scatterplot to examine the shape of the association

# <-- enter your answer here -->


# -- Q.27. -- What is r (given as 'cor' in the output) for the correlation between 'mean.self' and 'mean.acc'?

# <-- enter your answer here -->


# -- Q.28. -- Is the correlation between 'AGE' and 'mean.acc' significant?

# <-- enter your answer here -->


# -- Q.29. -- What are the values for t and p for the significance test for the correlation between 'QRITOTAL'
# and 'mean.acc'?

# <-- enter your answer here -->


# -- Q.30. -- What do you conclude, given the correlation results, about the association between 'SHIPLEY'
# and 'mean.acc'?

# <-- enter your answer here -->



############################################################################################################
## Part 8: Optional extensions #############################################################################


# -- Task 14 -- One of the convenient and powerful things about R plotting code 
# is that you can create a series
# of plots and put them together in a grid of plots for east comparison: we do that here
# -- hint: Task 14 -- We will use the patchwork library: check it out
# https://patchwork.data-imaginist.com/articles/patchwork.html

# -- hint: Task 14 -- Here's an example  

# -- first create two plots: give them both names
p.AGE <- ggplot(data = study.two.gen, aes(x = AGE, y = mean.acc)) +
  geom_point() 
#
p.SHIPLEY <- ggplot(data = study.two.gen, aes(x = SHIPLEY, y = mean.acc)) +
  geom_point()  

# -- second put them together
p.AGE  + p.SHIPLEY


# -- Option 1 -- Now you try it: create two plots, using 'QRITOTAL' and 'SHIPLEY' 
# as predictors
# and 'mean.acc' as the outcome, then make a grid to present them side by side

# <-- enter your answer here -->



############################################################################################################


