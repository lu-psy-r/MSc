


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
study.two.gen <- read_csv("study-two-general-participants.csv")
# -- hint: Task 3 -- When you read the data file in, give the data object you create a clear name 
# e.g. study.two.gen


# -- Task 4 -- Inspect the data file
# -- hint: Task 4 -- Use the summary() or head() functions to take a look
head(study.two.gen)
summary(study.two.gen)


# -- Q.1. -- What is the median of 'AGE'?
# -- A.1. -- 32.50  

# -- Q.2. -- What class is the variable 'ETHNICITY'?
# -- A.2. -- character  

# -- Q.3. -- Does the summary indicate if any variable has missing values (NAs)?
# -- Q.3. -- No


# -- Task 5 -- Change the class or type of the variable 'ETHNICITY' to factor
# -- hint: Task 5 -- You can use the as.factor() function you have used before
study.two.gen$ETHNICITY <- as.factor(study.two.gen$ETHNICITY)


# -- Q.4. -- After you have done this, what information does summary() give you 
# about the variable 'ETHNICITY'?
summary(study.two.gen)
# -- A.4. -- We can see that ETHNICITY lists observations (following UK Office National Statistics ethnicity grouping)
# Asian: 15
# Black: 5
# Mixed: 7
# White: 145



############################################################################################################
## Part 3: Use histograms to examine the distributions of variables ########################################


# -- Task 6 -- Draw histograms to examine the distributions of variables
# -- hint: Task 6 -- Use ggplot() with geom_histogram()

# -- The first time we do this, we take things step-by-step
# -- Here's an example: run the line of code and see the result in the Plots window in R-Studio
ggplot(data = study.two.gen, aes(x = mean.acc)) + geom_histogram()

# These are the steps:
# -- 1 -- ggplot(...) -- you tell R you want to make a plot using the ggplot() 
# function
# -- 2 -- ggplot(data = study.two.gen ...) -- you tell R you want to make a plot 
# with the 'study.two.gen' data
# -- 3 -- ggplot(..., aes(x = mean.acc)) -- you tell R that you want to make a 
# plot with the variable 'mean.acc'
# -- 3 -- here, you specify the aesthetic mapping, x = mean.acc
# -- 4 -- ggplot(...) + geom_histogram() -- you tell R you want to plot values 
# of 'mean.acc' as a histogram


# -- Q.5. -- Did you get a message in black or red in the Console window in R-Studio: 
# what does it say?
# -- A.5. -- `stat_bin()` using `bins = 30`. Pick better value with `binwidth`.

# -- Q.6. -- Draw two different histograms to examine the distributions of two 
# different variables: SHIPLEY and HLVA
ggplot(data = study.two.gen, aes(x = SHIPLEY)) + geom_histogram()
ggplot(data = study.two.gen, aes(x = HLVA)) + geom_histogram()

# -- Q.7. -- Now re-do both plots: can you change the binwidth in geom_histogram() to make the bars wider?
# -- hint: Q.7. -- If you are going to change binwidth the number you use needs to be a number larger than   
# the minimum and smaller than the maximum for the variable
# -- Here, we care about what minimum or maximum values the variable could
# have -- not about the observed minimium-maximum values in our sample data
# -- Shipley score can vary 0-40
# -- HLVA score can vary 0-16
# -- Remember, min and max values are given for each numeric variable in summary()
ggplot(data = study.two.gen, aes(x = SHIPLEY)) + geom_histogram(binwidth = 2)
ggplot(data = study.two.gen, aes(x = HLVA)) + geom_histogram(binwidth = 2)


# -- Remember: this move is discussed in the how-to .R
# -- We adjust binwidth typically to improve the appearance of the plot
# -- This is a bit subjective so try different numbers and see how you feel about the changes in appearance
# -- We want histograms that show us enough detail about the frequency of occurrence of groupings (bins) of
# values for each variable
# -- But we do not want histograms that show us so much detail it is difficult to see the pattern for the 
# distribution


# -- Q.8 -- How would you describe the distributions -- in a sentence -- of the distributions of the
# SHIPLEY and HLVA variable values for our sample?
# -- A.8. -- The SHIPLEY values lie between about 25 and 40, and are skewed towards high scores. The HLVA
# values lie between 4 and about 14, and peak in the middle (near 8 to 10)



############################################################################################################
## Part 4: Edit your plots to make them look good ##########################################################


# -- Task 8 -- Edit the appearance of a histogram plot for *one numeric variable* 
# -- hint: Task 8 -- ggplot() code does not all have to be on the same line
# -- hint: Task 8 -- you can create a new plot for each edit so you can see what difference your edits make


# -- Q.9. -- Edit the appearance of the bars using binwidth
ggplot(data = study.two.gen, aes(x = HLVA)) + 
  geom_histogram(binwidth = 2)

# -- Q.10. -- Edit the colour of the background using theme_bw()
ggplot(data = study.two.gen, aes(x = HLVA)) + 
  geom_histogram(binwidth = 2) +
  theme_bw()

# -- Q.11. -- Edit the appearance of the labels using labs()
ggplot(data = study.two.gen, aes(x = HLVA)) + 
  geom_histogram(binwidth = 2) +
  theme_bw() +
  labs(x = "HLVA", y = "count")

# -- Q.12. -- Edit the appearance of the bars by changing the fill in aes()
# -- hint: Q12 -- To figure out how to do this, you will need to first look at 
# the ggplot reference information online -- do a search with the keywords 
# "ggplot reference geom_histogram" and then come back to this
# -- hint: Q12 -- The example code in the reference information is always a good 
# place to find ideas you can use
# -- hint: Q12 -- You can ask for fill to be a specific colour e.g. "red" (use quotes)
ggplot(data = study.two.gen, aes(x = HLVA, fill = "red")) + 
  geom_histogram(binwidth = 2) +
  theme_bw() +
  labs(x = "HLVA", y = "count")


# -- Notice how, if you are doing edits in steps, one line at a time, each line in your code -- except the last one 
# -- ends in a +
# -- What we are doing is telling R we want this + this + this ...
# -- Each line then adds an extra step
# -- You can break this code by not adding a + at the end of each bit (except the last line)

# -- Notice that how to break the code, and how to figure out how to fix the break, are discussed in the how-to .R



############################################################################################################
## Part 5: Now draw scatterplots to examine associations between variables #################################


# -- Task 9 -- Create a scatterplot to examine the association between some 
# variables e.g. 'HLVA' and 'mean.acc'
# -- hint: Task 9 -- We are working with geom_point() and you need x and y 
# aesthetic mappings
ggplot(data = study.two.gen, aes(x = HLVA, y = mean.acc)) +
  geom_point()

# -- This plot shows:
# -- the possible association between x-axis variable 'HLVA' and y-axis variable
# 'mean.acc'

# -- The plot code moves through the following steps:  
# -- 1 -- ggplot(...) -- make a plot
# -- 2 -- ggplot(data = study.two.gen, ...) -- with the 'study.two.gen' dataset
# -- 3 -- ggplot(...aes(x = HLVA, y = mean.acc)) -- using two aesthetic mappings:
# -- x = HLVA -- map 'HLVA' values to x-axis (horizontal, left to right) positions
# -- y = mean.acc -- map 'meann.acc' values to y-axis (vertical, bottom to top) positions
# -- 4 -- geom_point() -- show the mappings as points    


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

ggplot(data = study.two.gen, aes(x = mean.self, y = mean.acc)) +
  geom_point()  

ggplot(data = study.two.gen, aes(x = AGE, y = mean.acc)) +
  geom_point() 

ggplot(data = study.two.gen, aes(x = SHIPLEY, y = mean.acc)) +
  geom_point()  

ggplot(data = study.two.gen, aes(x = HLVA, y = mean.acc)) +
  geom_point() 

ggplot(data = study.two.gen, aes(x = FACTOR3, y = mean.acc)) +
  geom_point() 

ggplot(data = study.two.gen, aes(x = QRITOTAL, y = mean.acc)) +
  geom_point() 

# -- Q.13. -- What is the shape (direction) of the association between 'mean.self' 
# and 'mean.acc'?
# -- A.13. -- Increase in 'mean.self' is associated with increase in 'mean.acc'  
  
# -- Q.14. -- What is the shape (direction) of the association between 'AGE' 
# and 'mean.acc'?
# -- A.14. -- There is no clear association between 'AGE' and 'mean.acc'
  
# -- Q.15. -- What is the shape (direction) of the association between 'SHIPLEY' 
# and 'mean.acc'?
# -- A.15. -- Increase in 'SHIPLEY' is associated with increase in 'mean.acc'
  
# -- Q.16. -- What is the shape (direction) of the association between 'HLVA' 
# and 'mean.acc'?
# -- A.16. -- Increase in 'HLVA' is associated with increase in 'mean.acc'
  
# -- Q.17. -- What is the shape (direction) of the association between 'FACTOR3' 
# and 'mean.acc'?
# -- A.17. -- Increase in 'FACTOR3' is associated with increase in 'mean.acc'

# -- Q.18. -- What is the shape (direction) of the association between 'QRITOTAL' 
# and 'mean.acc'?
# -- A.18. -- Increase in 'QRITOTAL' is associated with increase in 'mean.acc'



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
ggplot(data = study.two.gen, aes(x = HLVA, y = mean.acc)) +
  geom_point(alpha = 0.5, size = 2, colour = "red") 

# -- Q.20. -- Edit the colour of the background using theme_bw()
ggplot(data = study.two.gen, aes(x = HLVA, y = mean.acc)) +
  geom_point(alpha = 0.5, size = 2, colour = "red")   +
  theme_bw()

# -- Q.21. -- Edit the appearance of the labels using labs()
ggplot(data = study.two.gen, aes(x = HLVA, y = mean.acc)) +
  geom_point(alpha = 0.5, size = 2, colour = "red")   +
  theme_bw() +
  labs(x = "HLVA", y = "mean accuracy")

# -- Q.22. -- Can you find the ggplot reference page?
# -- hint: Q.22 -- Do a search with the keywords "ggplot reference geom_point"
# -- A.22. -- It is here: 
# https://ggplot2.tidyverse.org/reference/geom_point.html


# -- Now you: experiment!



############################################################################################################
## Part 7: Use correlation to to answer the research questions #############################################


# -- Task 13 -- Examine the correlation between mean accuracy (mean.acc) and some numeric predictor variables
# -- hint: Task 13 -- We use cor.test()
cor.test(study.two.gen$HLVA, study.two.gen$mean.acc, method = "pearson",  alternative = "two.sided")


# -- Q.23. -- What is r (given as 'cor' in the output) for the correlation between 'HLVA' and 'mean.acc'?
cor.test(study.two.gen$HLVA, study.two.gen$mean.acc, method = "pearson",  alternative = "two.sided")
# -- A.23. -- r = 0.5000559 

# -- Q.24. -- Is the correlation significant?
# -- A.24. -- r is significant

# -- Q.25. -- What are the values for t and p for the significance test for the correlation?
# -- A.25. -- t = 7.5288, p = 2.866e-12

# -- Q.26. -- What do you conclude, given the correlation results?
# -- hint: Q.16 -- Maybe draw a scatterplot to examine the shape of the association
# -- A.26. -- HLVA and mean.acc are positively correlated suggesting that as HLVA scores increase so also do
# mean.acc scores

# -- Q.27. -- What is r (given as 'cor' in the output) for the correlation between 'mean.self' and 'mean.acc'?
cor.test(study.two.gen$mean.self, study.two.gen$mean.acc, method = "pearson",  alternative = "two.sided")
# -- A.27. -- r = 0.5460792 

# -- Q.28. -- Is the correlation between 'AGE' and 'mean.acc' significant?
cor.test(study.two.gen$AGE, study.two.gen$mean.acc, method = "pearson",  alternative = "two.sided")
# -- A.28. -- r is not significant

# -- Q.29. -- What are the values for t and p for the significance test for the correlation between 'QRITOTAL'
# and 'mean.acc'?
cor.test(study.two.gen$QRITOTAL, study.two.gen$mean.acc, method = "pearson",  alternative = "two.sided")
# -- A.29. -- t = 6.4711, p = 9.993e-10

# -- Q.30. -- What do you conclude, given the correlation results, about the association between 'SHIPLEY'
# and 'mean.acc'?
cor.test(study.two.gen$SHIPLEY, study.two.gen$mean.acc, method = "pearson",  alternative = "two.sided")
# -- A.30. -- 'SHIPLEY' and 'mean.acc' are positively correlated suggesting that as HLVA scores increase so also do
# mean.acc scores



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
p.QRITOTAL <- ggplot(data = study.two.gen, aes(x = QRITOTAL, y = mean.acc)) +
  geom_point() 
#
p.SHIPLEY <- ggplot(data = study.two.gen, aes(x = SHIPLEY, y = mean.acc)) +
  geom_point()  

# -- second put them together
p.QRITOTAL  + p.SHIPLEY



############################################################################################################


