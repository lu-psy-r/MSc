# # PSCY401 Workbook Week 3
# # Answers

# ###############################################
# Part 1: Revision from last week

# #########################
# Task 1: Describe and load the data set you found for your take-home task

# 1.	Your take-home task was to download a data set that accompanied a paper
# published in Psychological Science. Describe this data set to the rest of your group.

# 2.	Load your data set into Rstudio (use read.csv(), or one of the other read functions
# from the last part of the Practical week2 workbook).

# 3.	View the data set, and then make a new data set from this data set, by selecting
# just two variables (remember you might need to first install the library tidyverse):
install.packages("tidyverse")
library(tidyverse)

# ANSWER:
dat <- read.csv("dataset.csv")
dataset2 <- select(.data = dat, variable1, variable2)

# 4.	Is it appropriate to draw a histogram or a scatter plot of the two variables?
# If so, draw it. If not, why not? 

# 5.	Make sure these commands are in the source window, save them as a new R file,
# e.g., "mypsychscidata.r"


# ###################################################
# Part 2: Reproduce the Lecture week3 part3 analyses

# ###################################################
# Task 2: Load in the data, draw a histogram, find means and standard deviations

# 6. Create a new r script, called psyc401_week3.r, and clear out R studio ready for a new script:

rm(list=ls())

# (we might need to load the library we are going to need):

library(tidyverse)
install.packages("tidyverse")

# 7. Download the data files on the vocabulary tests: in moodle week 3 folder:
# PSYC401-shipley-scores-anonymous-17_18.csv

# 8. Load the data into an object called "dat" using read.csv(), 
# what command line do you use?
# (remember to set the working directory)

# ANSWER:
dat <- read.csv("PSYC401-shipley-scores-anonymous-17_18.csv")

# 9. View the data. What command do you use?

# ANSWER:
View(dat)

# 10. We can make a histogram of the first time people took the Gent vocabulary test:

hist(dat$Gent_1_score)

# 11. And a histogram of the second time people took the Gent test, what command line do you use?

# ANSWER:
hist(dat$Gent_2_score)

# 12. We can find out means and standard deviations. 
# We will use the mean() and the sd() functions. However, we need to tell R studio
# what to do with the missing values (called NA in the View), to do that we have to add an
# extra bit to the command: 

mean(dat$Gent_1_score, na.rm=TRUE)

# This tells R studio to remove the NA values before computing the mean. What happens if you don't 
# add na.rm=TRUE ?

# ANSWER: it gives a NA response - it doesn't compute the mean
  
# What What is the mean and standard deviation of Gent_1_score and Gent_2_score?

# ANSWER:
mean(dat$Gent_1_score, na.rm=TRUE)
sd(dat$Gent_1_score, na.rm=TRUE)
mean(dat$Gent_2_score, na.rm=TRUE)
sd(dat$Gent_2_score, na.rm=TRUE)
# Gent_1_score mean = 57.45, sd = 15.96; Gent_2_score mean = 57.10, sd = 18.72

# ###########################################
# Task 3: Use ggplot to draw some histograms:

# 13. Now we are going to use another way of making graphs. This is more flexible than the "hist" function
# Here is how to make a histogram of the Gent vocabulary scores:

ggplot(dat, aes(x = Gent_1_score) ) + geom_histogram(fill="blue") + labs(title="Gent Vocabulary Test 1", x = "Vocabulary Score", y = "Frequency")

# 14. And for the second Gent test:
ggplot(dat, aes(x = Gent_2_score) ) + geom_histogram(fill="red") + labs(title="Gent Vocabulary Test 2", x = "Vocabulary Score", y = "Frequency")

# Breaking it down:
ggplot( dat, aes(x = Gent_1_score) )
# this calls the plotting function ggplot
# we specify the data set we will use (dat)
# and we set the data for the plot- in this case we say that the x value (so that's what
# will be along the x-axis in the graph) is the Gent_1_score. We put this inside aes(), 
# which stands for "aesthetic".
+ geom_histogram(fill="blue" ) 
# This adds a graph of type histogram and colours it blue
+ labs(title="Gent Vocabulary Test", x = "Vocabulary Score", y = "Frequency") 
# This adds labels to the graph: title, the x-axis label and the y-axis label


# ##########################################
# Part 3: Practise manipulating data

# #####################
# Task 4: Practise manipulating data

# 15.	 Let's keep only some of the variables from the dataset dat - let's remove Gender_code, and Dyslexia_diagnosis.
# Keep the other variables using select() and load this into summarydata
summarydata <- select(.data = dat, subject_ID, Age, english_status, Gender, Shipley_Voc_Score, Gent_1_score, Gent_2_score, academic_year)

# 16.	Next we will have a bit more of a wander around the data to get a feel for it.
# We will first use the function arrange(), which changes the order of observations (rows):

arrange(.data = summarydata, Shipley_Voc_Score)

# What is the lowest score of a participant on the Shipley Vocabulary questionnaire?
# (You may like to make a new object, which is the result of the arrange function,
#  then look at it in View).

# ANSWER: 10

# 17.	If you want to order from highest to lowest, you have to use the desc() function:

arrange(.data = summarydata, desc(Shipley_Voc_Score))

# What is the highest value on the Shipley Vocabulary Test? How many participants have this
# highest score?

# ANSWER: 38, 2 participants

# 18.	Next we will use the filter() function. This includes or excludes certain
# observations (rows). Let's just include the participants with English as a first
# language and put this into a new object, called summarydata_enl:

summarydata_enl <- filter(.data = summarydata, english_status == 'native')

# What are the mean and SD values of the Shipley Vocabulary test for the native speakers?

# ANSWER: 32.14 (3.25)
mean(summarydata_enl$Shipley_Voc_Score)
sd(summarydata_enl$Shipley_Voc_Score)

# 19.	Make another variable with the z-scores of the Shipley Vocabulary test
# (see week 1 workbook). What are the maximum and minimum z-scores?

# ANSWER:
zshipley <- scale(summarydata$Shipley_Voc_Score)
# But ideally, can add this variable to summarydata:
summarydata$zshipley <- scale(summarydata$Shipley_Voc_Score) 
# Min: -2.46, max = 1.43

# 20.	Remember to save your script file.

# ##########################################
# Part 4: Graphing data

# #####################
# Task 5: graphing data using histograms

# 21.	Previously we used plot to draw a scatter plot, and hist to draw a
# histogram. Now, we're going to use ggplot which can draw all kinds of graphs,
# with a great deal more flexibility. We are going to represent the data to
# reflect the following relations:
# - English status and gender
# - Age and vocabulary score
# - Gender and vocabulary score
# - Academic year and vocabulary score
# - Academic year and age
# - English status and vocabulary score
# - English status and age

# But first, let's repeat reproducing the histogram from the overhead slides to
# look at the distribution of variables:
ggplot(summarydata, aes(x = Gent_1_score)) + geom_histogram(fill="blue") + labs(title="Gent Vocabulary Test 1", x = "Vocabulary Score", y = "Frequency")

# 22.	Now draw a histogram with Shipley_Voc_Score as the variable and colour it orange.
# Remember to change the title to something appropriate.

# ANSWER:
ggplot(summarydata, aes(x = summarydata$Shipley_Voc_Score)) + geom_histogram(fill="orange") + labs(title="Shipley Vocabulary Test", x = "Vocabulary Score", y = "Frequency")

# ggplot(summarydata, aes(x = Shipley_Voc_Score, fill=Gender )) + geom_histogram(bins = 10) + labs(title="Shipley Vocabulary Test", x = "Vocabulary Score", y = "Frequency")


# #####################
# Task 6: graphing data using bar graphs

# 23.	Next let's look at English status and gender. What types of variable are these?
# Nominal? Ordinal? Interval/ratio?

# ANSWER: both nominal. So we can only count them.

# 24.	We will draw a bar graph of the counts. We use geom_bar() for this:
# - First try this:
ggplot(summarydata, aes(x = Gender)) + geom_bar()
# - This just draws counts of Gender
# - Now let's draw Gender and English Status together:

ggplot(summarydata, aes(x = Gender, fill = english_status)) + geom_bar(position = "dodge")

# Note 1: We use position dodge so that it puts the bars next to each other (what happens if
# you leave out "position = dodge", ?)
# Note 2: We use fill = english_status so that it fills the different bars with
# different colours according to different english statuses.
# What is the general pattern of counts? Are there proportional differences by
# English status according to gender?


# ANSWER: proportionally more males who are native English. But we don't know if it's significant

# #####################
# Task 7: graphing data using scatterplot

# 25.	Next we'll look at Age and Shipley Vocabulary Score. What types of data are these?

# ANSWER: interval/ratio, so we can scatter plot them.

# 26.	We will draw a point plot of these values:

ggplot(summarydata, aes(x= Age, y = Shipley_Voc_Score)) + geom_point()

# We can add '+ labs(title = "Age by Shipley Vocabulary Score", x = "Age", y = "Shipley Vocabulary Score")'
# to tidy up presentation a bit.

gplot(summarydata, aes(x= Age, y = Shipley_Voc_Score)) + geom_point() + labs(title = "Age by Shipley Vocabulary Score", x = "Age", y = "Shipley Vocabulary Score")

# - What is the relation between age and Shipley Vocabulary score?

# ANSWER: looks positive.

# #####################
# Task 8: Draw and interpret a box plot

# 27.	Next on the list of relations to check is gender and vocabulary score. Let's look
# at Gent_1_score against Gender. What type of variables are these?

# ANSWER: one ratio, one nominal, so need a box plot.

# 28.	We will draw a box plot (you could draw a bar graph, but box plots tend to be
# preferred for these combinations of variables - use a bar graph for counts):

ggplot(summarydata, aes(x= Gender, y = Gent_1_score)) + geom_boxplot()

# - Again we can tidy this up by adding labels:

ggplot(summarydata, aes(x= Gender, y = Gent_1_score)) + geom_boxplot() + labs(title = "Vocabulary Score by Gender", x = "Gender", y = "Gent Vocabulary Score Test 1")

# 29.	Interpreting box plots: The horizontal line indicates the median. The box
# indicates where 50% of the data lie. The lines indicate an estimate of the range
# of the data (minimum and maximum values). The dots indicate outliers. A large box
# indicates larger standard deviation. If the boxes don't overlap much then this
# indicates there may be a difference between the groups.
# - Are there differences in Vocabulary according to gender?

# ANSWER: maybe females slightly lower than males:

# 30.	Now for the other relations: 
# - Academic year and vocabulary score
# - Academic year and age
# - English status and vocabulary score
# - English status and age

# At the moment, R is interpreting Academic year as a number. We need to turn it into a
# nominal variable (called a "factor" in R studio):

summarydata$academic_year <- as.factor(summarydata$academic_year)

# Draw a graph for each of these relations.

# ANSWER: these are categorical against ratio variables, so all box plots:
ggplot(summarydata, aes(x = academic_year, y = Gent_1_score) ) + geom_boxplot()
ggplot(summarydata, aes(x = academic_year, y = Age) ) + geom_boxplot()
ggplot(summarydata, aes(x = english_status, y = Gent_1_score) ) + geom_boxplot()
ggplot(summarydata, aes(x = english_status, y = Age) ) + geom_boxplot()

ggplot(summarydata, aes(x = Age, fill = english_status) ) + geom_histogram()


# 31.	Save your R script.

# ##########################################
# Part 5: More practise manipulating data

# 32. For finding minimum and maximum values, we have used the "arrange()" function.
# However, if you were designing R, what would you call the function that could just
# print the minimum values for you. See if your intuitions are right (if you have them),
# and/or search (on the internet) for the R function that finds the minimum or maximum
# values. What is the R command for finding the minimum and maximum values of the
# Shipley Vocabulary scores?

# ANSWER:
min(summarydata$Shipley_Voc_Score); max(summarydata $Shipley_Voc_Score)

# 33. An important part of using R-studio is that people share their code, their tutorials,
# and help one another out in troubleshooting. Searching for commands and how to use them on
# search engines is absolutely fine, and supplementing your learning with others' tutorials is
# also what the community does.
# Glasgow University psychology department has made some of their course materials available
# and so for more practise in using the different data manipulation functions, you could have a look at
# https://psyteachr.github.io/msc-conv/data-wrangling-1.html
# Ignore the part about making a new R markdown document, use instead an R script.
# Just go straight to clear out the environment rm(list=ls()) then load the 
# libraries tidyverse() and babynames() where the babynames()
# library contains the database on babies' names that you can explore in the example (you'll
# need to install.packages("babynames") first). And then begin at Section "4.4: Activity 2: Look at the data".

# ##########################################
# Part 6: Take home exercise

# For the data that you downloaded from the Psychological Science paper for your take
# home exercise last week, construct some graphs to show relations between variables. 
# Reminder:
# Use geom_bar() for bar graphs of counts
# Use geom_box() for box plots showing means
# Use geom_point() to show relations between two or more variables
# Use geom_hist() to show distributions of one or more variables
