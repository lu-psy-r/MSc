


############################################################################################################


# In Week 7, we aim to develop skills in visualizing and testing the associations between variables in
# psychological data

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

# -- I will be explicit about when we:
# -- revise -- where you have started to do things and maybe can use some 
# practice to strengthen skills;
# -- introduce -- where you are doing things that are new;
# -- extend -- where you can do things that will stretch you -- where you might 



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
library("tidyverse")



############################################################################################################
############################################################################################################


# -- In this how-to guide, we use data from a 2020 study of the response of adults from a UK national
# sample to written health information:

# study-one-general-participants.csv



############################################################################################################
## Part 2: Load data #######################################################################################


# -- Task 3 -- Read in the data file we will be using: 
# study-one-general-participants.csv

# -- We use the read_csv() function to read the data file into R
study.one <- read_csv("study-one-general-participants.csv")  


# -- Task 4 -- Inspect the data file
# -- hint: Task 4 -- Use the summary() or head() functions to take a look
head(study.one)
summary(study.one)

# -- head() will give you the top few rows of any dataset you have read into R
# -- head(...) is a function, and you put the name of the dataset inside the brackets to
# view it
head(study.one)

# -- summary() will give you either descriptive statistics for variable columns classified as numeric
# or will tell you that columns in the dataset are not numeric
# -- summary() is also a function and, again, you put the name of the dataset inside the brackets to
# view it
summary(study.one)


# -- Q.1. -- What is the mean of 'mean.acc'?
# -- A.1. -- 0.8163  

# -- Q.2. -- What class is the variable 'study'?
# -- A.2. -- character  

# -- Q.3. -- Does the summary indicate if any variable has missing values (NAs)?
# -- Q.3. -- No


# -- Task 5 -- Change the class or type of the variable 'study' to factors
# -- hint: Task 5 -- You can use the as.factor() function you have used before
study.one$study <- as.factor(study.one$study)


# -- Q.4. -- After you have done this, what information does summary() give you about the variable
# 'study'?
summary(study.one)
# -- A.4. -- We can see the number 169 beside the word 'studyone': this tells us that there are 169
# observations, in the column, each one is a value: the word or character string 'studyone'.



############################################################################################################
## Part 3: Use histograms to examine the distributions of variables ########################################


# -- revise: consolidate what you know --


# -- Task 6 -- Draw histograms to examine the distributions of variables
# -- hint: Task 6 -- Use ggplot() with geom_histogram()

# -- The first time we do this, we take things step-by-step
# -- Here's an example: run the line of code and see the result in the Plots window in R-Studio
ggplot(data = study.one, aes(x = mean.acc)) + geom_histogram()

# These are the steps:
# -- 1 -- ggplot(...) -- you tell R you want to make a plot using the ggplot() function
# -- 2 -- ggplot(data = study.one ...) -- you tell R you want to make a plot with the 'study.one' data
# -- 3 -- ggplot(..., aes(x = mean.acc)) -- you tell R that you want to make a plot with the variable 'mean.acc'
# -- 3 -- here, you specify the aesthetic mapping, x = mean.acc
# -- 4 -- ggplot(...) + geom_histogram() -- you tell R you want to plot values of 'mean.acc' as a histogram


# -- Q.5. -- Did you get a message in black or red in the Console window in R-Studio: what does it say?
# -- A.5. -- `stat_bin()` using `bins = 30`. Pick better value with `binwidth`.

# -- Q.6. -- What does 'binwidth' refer to?
# -- hint: Q.6. -- You need to do a search online (e.g., using Google) with the keywords:
# "ggplot reference geom_histogram"
# -- A.6. If your search gets you to this page:
# https://ggplot2.tidyverse.org/reference/geom_histogram.html  
# -- you will see first a technical definition "The width of the bins. Can be specified as a numeric value ..."
# -- and then you will see examples of the use of the term e.g.
ggplot(diamonds, aes(carat)) + geom_histogram(binwidth = 0.01)
# -- If you run the example code, it will produce a plot. Do it.


# -- It is a very good idea to get get some experience doing searches online for information about working
# with data analysis tasks
# -- You will find that there is a lot of useful information, written in different ways for people
# with different levels of expertise


# -- Here, we are interested in working with 'binwidth' in geom_histogram()
# -- The example gives us a hint at what we can do: we can change the appearance
# of the bars in the histogram
# -- The bars in the histogram represent how often we observe, in a dataset, a 
# grouping of similar values in a variable
# -- Larger (wider) bins count more different values as similar
# -- So increasing binwidth will give you fewer wider bars in a histogram. 
# Check it out


# -- extend: make some new moves --


# # -- Task 7 -- Experiment with changing the binwidth
# # -- hint: Task 7 -- Use geom_histogram(binwidth = ...) like you can see 
# in the ggplot() reference example
# # -- hint: Task 7 -- Note that binwidth needs to take into account the 
# scale of the x variable
# -- It won't work for 'mean.acc' if you make binwidth = 100
# -- The number will need to be something between 0 and 1 (the min and 
# max for mean.acc)
# -- Try a few different numbers
ggplot(data = study.one, aes(x = mean.acc)) + geom_histogram()

ggplot(data = study.one, aes(x = mean.acc)) + geom_histogram(binwidth = 0.1)
ggplot(data = study.one, aes(x = mean.acc)) + geom_histogram(binwidth = 0.2)
ggplot(data = study.one, aes(x = mean.acc)) + geom_histogram(binwidth = 0.5)


# -- Q.7. -- What happens as you change the binwidth from, say, 0.1 to 0.2?
# -- A.7. -- You can see that with larger binwidth numbers, fewer bars are shown, and the bars are wider 
# and taller: because they are including more observations



############################################################################################################
## Part 4: Edit your plots to make them look good ##########################################################


# -- extend: make some new moves --


# -- Task 8 -- Edit the appearance of the plot step-by-step
# -- hint: Task 8 -- ggplot() code does not all have to be on the 
# same line

# -- If we break the plot code into steps, it will make it easier to read,
# and it will make it easier to add edits e.g.
ggplot(data = study.one, aes(x = mean.acc)) + 
  geom_histogram()
# -- If you run the selection of both lines, you get the code to work

# -- We are going to edit:
# -- 1 -- the appearance of the bars using binwidth
# -- 2 -- the colour of the background using theme_bw()
# -- 3 -- the appearance of the labels using labs()
# -- as follows

# -- 1 -- the appearance of the bars using binwidth
ggplot(data = study.one, aes(x = mean.acc)) + 
  geom_histogram(binwidth = 0.2)

# -- 2 -- the colour of the background using theme_bw()
ggplot(data = study.one, aes(x = mean.acc)) + 
  geom_histogram(binwidth = 0.2) +
  theme_bw()

# -- 3 -- the appearance of the labels using labs()
ggplot(data = study.one, aes(x = mean.acc)) + 
  geom_histogram(binwidth = 0.2) +
  theme_bw() +
  labs(x = "mean accuracy", y = "frequency count")


# -- Notice how each line -- except the last one -- ends in a +
# -- What we are doing is telling R we want this + this + this ...
# -- Each line then adds an extra step


# -- introduce: learn to handle errors and warnings --


# -- You can break this code by not adding a + at the end of each bit (except the last line)
# -- Try it:
ggplot(data = study.one, aes(x = mean.acc))
  geom_histogram(binwidth = 0.2) +
  theme_bw() +
  labs(x = "mean accuracy", y = "frequency")


# -- Q.8. -- You will get an error message in the console window, orange and
# grey, if you omit a + like in the example
# -- what is the error message?
# -- A.8. --   
#     Error: Cannot add ggproto objects together. Did you forget to add this object to a ggplot object?
#     Run `rlang::last_error()` to see where the error occurred.  
  
  
# -- R will give you hints -- often in red -- in warnings or error messages 
# about what has gone wrong
# -- This can be a bit frightening but usually you can fix a problem by:
# -- 1 -- trial and error -- try changing things to see what happens
# -- 2 -- copying the error message into an online search: usually, that will 
# get you to a blog or discussion that is helpful  

  
# -- Q.9. -- Paste the error message into Google: click on one of the results 
# -- do you see any useful information?
# -- A.9. -- An explanation of the problem is shown e.g.    
# https://community.rstudio.com/t/could-anybody-help-me-cannot-add-ggproto-objects-together/11271  
 
    
    
############################################################################################################
  
    
# -- Error messages and warning messages --
  
# -- Error messages and warning messages can be a bit alarming at first
# -- R gives you a warning message e.g. on binwidth if you made a choice 
# but R wants you to know other choices are possible
# -- R gives you an error message e.g. about adding objects to a ggplot 
# object if something in the code does not work or a choice you make in the 
# code does not work

# -- You will learn to use in the information in these messages
# -- They can be frustrating because, early in your skill development, 
# it can be difficult to know how to fix the problem
# -- You can almost always fix a problem through (1.) trial and error or 
# (2.) copying the message into an online search and following the advice you 
# find

# -- If you think about it, the 'you can almost always fix a problem' 
# statement is amazing
# -- The R community has many millions of people in it and many of us 
# are doing different and complex things
# -- Yet the huge value of the community means that *for every problem 
# you encounter, someone else has already met that
# problem, solved it, and posted a blog online about how to fix it*

  
  
############################################################################################################
## Part 5: Now draw scatterplots to examine associations between variables #################################
  
  
# -- revision: make sure you are confident about doing these things --
  
  
# -- You have seen these code moves before, in previous classes: we are 
# strengthening skills by practising coding in different contexts


# -- Task 9 -- Create a scatterplot to examine the association between some 
# variables
# -- hint: Task 9 -- We are working with geom_point() and you need x and y 
# aesthetic mappings
ggplot(data = study.one, aes(x = mean.self, y = mean.acc)) + 
    geom_point()
  
# -- This plot shows:
# -- the possible association between x-axis variable 'mean.self' and y-axis 
# variable 'mean.acc'

# -- The plot code moves through the following steps:  
# -- 1 -- ggplot(...) -- make a plot
# -- 2 -- ggplot(data = study.one, ...) -- with the 'study.one' dataset
# -- 3 -- ggplot(...aes(x = mean.self, y = mean.acc)) -- using two aesthetic mappings:
# -- x = mean.self -- map 'meann.self' values to x-axis (horizontal, left to right) positions
# -- y = mean.acc -- map 'meann.acc' values to y-axis (vertical, bottom to top) positions
# -- 4 -- geom_point() -- show the mappings as points    
  
  
# -- Task 10 -- Now do scatterplots with any pair of numeric variables you like  
# -- hint: Task 10 -- Remember what we saw with summary() not every variable consists of numbers  
  
ggplot(data = study.one, aes(y = mean.self, x = mean.acc)) +
    geom_point()  

ggplot(data = study.one, aes(x = AGE, y = mean.self)) +
  geom_point()  
  
ggplot(data = study.one, aes(x = SHIPLEY, y = mean.self)) +
  geom_point()  

ggplot(data = study.one, aes(x = HLVA, y = mean.self)) +
  geom_point()  



############################################################################################################
## Part 6: Edit the scatterplots to make them look good ####################################################


# -- extend: make some new moves --


# -- Task 11 -- Edit the appearance of the plot step-by-step


# -- We are going to edit:
# -- 1 -- the appearance of the points using alpha and size
# -- 2 -- the colour of the background using theme_bw()
# -- 3 -- the appearance of the labels using labs()
# -- as follows

# -- 1 -- the appearance of the points using alpha and size
ggplot(data = study.one, aes(x = HLVA, y = mean.self)) +
  geom_point(alpha = 0.5, size = 2) 

# -- 2 -- the colour of the background using theme_bw()
ggplot(data = study.one, aes(x = HLVA, y = mean.self)) +
  geom_point(alpha = 0.5, size = 2)  +
  theme_bw()

# -- 3 -- the appearance of the labels using labs()
ggplot(data = study.one, aes(x = HLVA, y = mean.self)) +
  geom_point(alpha = 0.5, size = 2)  +
  theme_bw() +
  labs(x = "HLVA", y = "mean self rated accuracy")
  

# -- The arguments alpha and size can change the appearance of most geometric 
# objects (geoms) in ggplot:
# -- in the code example, here, we vary the alpha number to change how opaque or 
# transparent the points are
# -- we vary the size number to vary the size of the points


# -- Task 12 -- Now you experiment: edit the appearance of the plot by changing 
# alpha and size -- what about colour?
# -- hint: Task 12 -- Check out the ggplot reference for scatterplots

# -- Q.10. -- Can you find the ggplot reference page?
# -- hint: Q.10 -- Do a search with the keywords "ggplot reference geom_point"
# -- A.10. -- It is here: 
# https://ggplot2.tidyverse.org/reference/geom_point.html

# -- Q.11. -- Can you change the colour of the points to a colour you like?
# -- hint: Q.11. -- Useful information on colour can be found here:
# https://r-graphics.org/recipe-colors-setting
# http://www.cookbook-r.com/Graphs/Colors_(ggplot2)/
# -- A.10. -- Here is how you do it: 
ggplot(data = study.one, aes(x = HLVA, y = mean.self)) +
  geom_point(alpha = 0.5, size = 2, colour = "hotpink")  +
  theme_bw() +
  labs(x = "HLVA", y = "mean self rated accuracy")


# -- Now you: experiment!

  

############################################################################################################
## Part 7: Use correlation to to answer the research questions #############################################


# -- extend: make some new moves --


# -- One of our research questions is:
# 2. Can people accurately evaluate whether they correctly understand written 
# health information?

# -- We can answer this question by examining whether mean self-rated accuracy 
# of understanding correlates with mean accuracy of understanding
# -- The logic is that if we can accurately rate our own understanding (from bad 
# to good) then that rating should be associated -- should be correlated with 
# -- how accurately we can actually respond to questions that test that 
# understanding


# -- Task 13 -- Examine the correlation between mean self-rated accuracy 
# ('mean.self') and mean accuracy ('mean.acc')
# -- hint: Task 13 -- We use cor.test()
cor.test(study.one$mean.acc, study.one$mean.self, method = "pearson",  alternative = "two.sided")

# -- Q.3. -- What is r, the correlation coefficient?
# -- A.3. -- r = 0.4863771
# -- Q.4. -- Is the correlation significant?
# -- A.4. -- r is significant
# -- Q.5. -- What are the values for t and p for the significance test for the correlation?
# -- A.5. -- t = 7.1936, p = 2.026e-11

# -- Q.6. -- What do you conclude, given the correlation results?
# -- hint: Q.6 -- Review the scatterplot you drew earlier to examine the shape 
# of the association between these variables
# -- A.6. -- mean.acc and mean.self are positively correlated suggesting that as 
# mean.acc scores increase so also do mean.self scores



############################################################################################################


