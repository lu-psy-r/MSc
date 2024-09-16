# PSCY401 Workbook Week 2
# Answers

# ###############################################
# Part 1: Reproduce the week2 p3 lecture material

# ##########
# Task 2: Opening a data file
# 10.	Reopen your script file psyc401_week2.r in R studio.
# 11.	It’s always a good idea to refresh and clear out R studio
# when you start a new session, so add this line to the beginning of
# your R studio file:

rm(list=ls())

# 12.	Now we are going to open a new data file. Download the file
# "PSYC401-shipley-scores-anonymous-17_18.csv" from moodle PSYC401 site,
# from the Practical Week2 folder.
# Each row is one person's data, and each column is a measure taken from the person.
# Columns are separated by commas, which is what the "csv" refers to.

# 13.	In R studio, we open csv files using a function called read.csv().
# Type this command in the script file and then run it:

dat <- read.csv("PSYC401-shipley-scores-anonymous-17_18.csv")

# Remember the dat <- notation, which means we put the data into an object called "dat"

# 14.	If all went well, we can then look at the data, using the function "View":

View(dat)

# 15.	Next, we just focus on two variables from the data: subject_ID which
# is the participants' anonymised number, and Gent_1_score, which is the participants'
# score on the Gent vocabulary test, the first time they had a go (that's what the
# 1 stands for). We do this using the command select.
# The command select is in a library called “tidyverse”. We need to first load 
# this library. In the script file type: library(tidyverse) and run it.

library(tidyverse)
summarydat <- select(.data = dat, subject_ID, Gent_1_score)

# 16.	Finally, let’s just have a quick look at these data.

hist(summarydat$Gent_1_score)

# 17.	This will draw a histogram of the Gent vocabulary scores.
# "summarydat$Gent_1_score" means that we look at the Gent_1_score
# values from the summarydat data – the "$" indicates that this is
# one of the measures from the data.
# What kind of pattern does the histogram show?

# ANSWER: normal distribution, slight negative skew possibly.

# #################################################################
# Part 2: Revision from last week

# 18.	Save your R script. Now, without looking at your notes, make
# a new object called "iknow", and assign this list of numbers to it
# (hint, use the iknow <- c(number1, number2, …) notation): 
# 126  76  98 124  91  88  99 115  80 113  90  92  97 134 110  92  92  87 135 115

iknow <- c(126, 76, 98, 124, 91, 88, 99, 115, 80, 113, 90, 92, 97, 134, 110, 92, 92, 87, 135, 115)

# 19.	 Remember to type these commands in the R script window. Next,
# get R-studio to give you the mean and standard deviation of this list of numbers.

mean(iknow) # ANSWER:  mean = 102.70
sd(iknow) # ANSWER: sd = 17.60

# 20.	Draw a histogram of the iknow data. 

hist(iknow) 


# #################################################################
# Part 3: More practice at opening files and manipulating data

# ##################################
# Task 3: Loading data into R-studio

# 21.	Go to moodle PSYC401 week2, and download the data file called
# "ahicesd.csv" to your directory "PSYC401/week2" or PSYC401_files/week2 or whatever you've called it. 
# Now do the same for "participantinfo.csv".
# These data come from this study: Woodworth, R.J., O'Brien-Malone, A., Diamond, M.R.
# and Schuez, B. (2018). Data from, "Web-based Positive Psychology Interventions: A Reexamination
# of Effectiveness". Journal of Open Psychology Data, 6(1).

# A brief description of the study is as follows: 
# In our study we attempted a partial replication of the study of Seligman, Steen, Park, and Peterson (2005) which had suggested that the web-based delivery of positive psychology exercises could, as the consequence of containing specific, powerful therapeutic ingredients, effect greater increases in happiness and greater reductions in depression than could a placebo control.
# Participants (n=295) were randomly allocated to one of four intervention groups referred to, in accordance with the terminology in Seligman et al. (2005) as 1: Using Signature Strengths; 2: Three Good Things; 3: Gratitude Visit; 4: Early Memories (placebo control).
# At the commencement of the study, participants provided basic demongraphic information (age, sex, education, income) in addition to completing a pretest on the Authentic Happiness Inventory (AHI) and the Center for Epidemiologic Studies-Depression (CES-D) scale. Participants were asked to complete intervention-related activities during the week following the pretest. Futher measurements were then made on the AHI and CESD immediately after the intervention period ('posttest') and then 1 month after the posttest (day 38), 3 months after the posttest (day 98), and 6 months after the posttest (day 189). Participants were not able to to complete a follow-up questionnaire prior to the time that it was due but might have completed at either at the time that it was due, or later. We recorded the date and time at which follow-up questionnaires were completed.

# 22.	Next, load the data into R-studio. The first file is data from
# participants' self-ratings of happiness and depression.
# The second contains demographic information about the participants. 

dat <- read.csv("ahicesd.csv")
pinfo <- read.csv("participantinfo.csv")

# This has made two new objects – one called "dat" which contains the experimental
# data, and one called "pinfo" which contains the demographic information.

# Task 4: Examining and manipulating data
# 23.	Let's have a look at the data now.

View(dat)

# 24.	The data show id which is the participant number,
# occasion which is whether this is the first (0), second (1), up to sixth (5)
# time they filled in the questionnaires,
# intervention is which intervention they took part in with respect to attempting
# to promote their mood,
# ahi01-ahi24 are the 24 items on the AHI happiness scale,
# cesd01-cesd20 are the 20 items on the CESD depression scale.
# Way over on the right are the total scores on the AHI and the CESD questionnaires.

# 25.	Now, view the pinfo data. How can you look at it?

View(pinfo)

# 26.	The View replaced the source panel, but the source is still there.
# Just above the View panel you should see a tab named "psyc401_week2.r",
# click on that to get your source panel back. It will be red if it is unsaved.
# Remember it’s a good idea to regularly save your source file so you don't lose work.

# 27.	Now, we are going to join together the two files.

all_dat <- inner_join(x = dat, y = pinfo, by = c('id', 'intervention'))

# Question: what does the c('id', 'intervention') bit mean?
# ANSWER: this means we match by two variables – id and intervention.
# We use the c() notation to indicate that this is a list of things.

# We’ve now made a new data set called "all_dat". The "x = dat" bit is the
# name of the first datafile we want to join, the "y = pinfo" is the name of
# the second datafile we want to join, the "by = 'id', 'intervention'" bit
# is the names of variables that the two datasets have in common.

# How would you join two data sets one called "data1" the other called "data2"
# together if they both have the variable "participantname" in common?

# ANSWER
inner_join(x = data1, y = data2, by = 'participantname')

# 28.	Now we just want to keep a few of the variables – we're not interested
# in the individual questionnaire items. So, let’s select the variables we want to keep:

summarydata <- select(.data = all_dat, ahiTotal, cesdTotal, sex, age, educ, income, occasion, intervention)

# Where "all_dat" is the name of the object to take data from, and "ahiTotal,
# cesdTotal, sex, age, educ, income, occasion, intervention" are all the variables
# we want to keep.

# 29.	Have a look at the summarydata in the View. How do you do that?

View(summarydata)

# ########################
# Task 4: Investigate data

# 30.	The next task is to have a closer look at the distributions of the data.
# Let’s focus on the age of participants. To investigate one column of data from a
# dataset, you have to refer to it using the "$" symbol. So, to investigate the "age"
# column from the "summarydata" dataset, you would look at summarydata$age. Draw a
# histogram (bar graph) of the distribution of age in the participant sample.

hist(summarydata$age) 

# 31.	Now, let's look at how the AHI and the CESD scores relate. To gain an
# impression of how two variables relate we can draw a scatter graph.

plot(summarydata$ahiTotal, summarydata$cesdTotal)

# What does the "$" do in this command? What relationship do you find between these two variables?

# ANSWER: $ refers to one column in the data – either $ahiTotal or $cesdTotal columns.
# Relation is negative – higher happiness indicates lower depression.


# 32.	Now make sure you save psyc401_week2.r that contains all these commands that
# you ran. Close Rstudio, and Open Rstudio and make sure its saved all your work.
# The list of commands is extremely useful for making science open and accessible to
# other researchers. It’s more and more common for psychology articles to make the R
# source files available so other researchers can reproduce the data manipulations and
# analyses used in the paper precisely.

# #################################################################
# Part 4: More (advanced) data manipulation

# 33.	For reading in more types of data, you can use commands other than ‘read.csv()’.
# Have a look at https://support.rstudio.com/hc/en-us/articles/218611977-Importing-Data-with-RStudio
# and have a go at loading in excel files or text files with various formats into R-studio.
# Note that using lots of different resources online is one of the points of using R-studio
# - everything is open and shared.
# It isn't cheating - it's what everyone who uses R-studio does, it's what I did when I was
# checking some of the commands in this module - so do use google (or baidu, or any search engine) 
# to explore other commands, and to get hints if you ever get stuck.

# 34.	What if the datafiles you wanted to combine together had different names
# for participants – in datafile "dataone" it’s called "id" and in "datatwo"
# it’s called "participant". Before using the function "inner_join" you’ll need
# to rename – have a look at the function "rename" to see how to do that
# (to look at a function, type '?functionname' in the console, or do an internet search).

# ANSWER:
rename(.data = datatwo, id = participant)

# 35.	In the data set from Woodworth et al., we might want to just look at the
# pretests. We can use a function called "filter" to pull out just some of the rows.

summarydata_occasion0 <- filter(.data = summarydata, occasion == 0)

# this just pulls out the first occasion of testing (the pretest).
# How would you pull out the second occasion of testing?

# ANSWER:
filter(.data = summarydata, occasion == 1)

# 36.	How would you pull out just those participants who had the first intervention
# from the summarydata data?

# ANSWER:
filter(.data = summarydata, intervention == 1)

# 37.	Back to the data set with just occasion == 0 selected. Now plot the relationship
# between the AHI and CESD scores at this pretest. What is the pattern now?

# ANSWER: still the same
plot(summarydata_occasion0$ahiTotal, summarydata_occasion0$cesdTotal)

# 38.	How about just the participants who had intervention 1. What is the relationship
# between their scores on the AHI and CESD in the first test?

# ANSWER: Can do this in two ways: 
summarydata_occasion0_intervention1 <- filter(.data = summarydata, occasion == 0 & intervention == 1)
# or:
summarydata_occasion0_intervention1 <- filter(.data = summarydata_occasion0, intervention == 1)
# then:
plot(summarydata_occasion0_intervention1$ahiTotal, summarydata_occasion0_intervention1$cesdTotal)

# relationship is still similar.

#########################
#### Part 5: Different ways in which data are stored: long and wide data format

# When we look at other people’s data sets there are two generic ways in which they can be presented. 
# The first is called “wide format”, and this is when several measures are presented on a single row 
# in the data. This is the format of the data in the vocabulary scores: psyc401-shipley-scores-anonymous-17_18.csv, 
# where there are three vocabulary tests each in different columns. The other format is called 
# “long format”, and this is where each observation is on a different line – and if there is more 
# than one observation from the same subject then that subject has multiple lines in the data.
# There are some functions in the tidyverse library that helps us convert from wide to long 
# and long to wide. This part practises these conversions.

################
####Task 5: Wide to long format conversion
# 39.	Let’s go back to the psyc401-shipley-scores-anonymous-17_18.csv data. This should still be in the object called "dat". If it’s not, then load the data again into dat, using the read.csv() function.

dat <- read.csv("psyc401-shipley-scores-anonymous-17_18.csv")

# 40.	Make sure the library(tidyverse) is loaded, if not, run the command 

library(tidyverse)

# 41.	The aim here is to convert the data so that each Gent vocabulary score is on a separate line, we use 
# the pivot_longer function for this. First we specify what the new object should be (datlong), then we say 
# where the old data is (dat), then we make a new variable to keep the names of the tests (names_to = “test”), 
# then we make a new variable to keep the scores from the tests (values_to = “vocab”), then we specify the 
# list of old variables to combine into the new scores variable (c(“Gent_1_score”, “Gent_2_score”) ) – 
# remember lists are written as c(). So, run this command:  

datlong <- pivot_longer(dat, names_to = "test", values_to = "vocab", cols = c("Gent_1_score", "Gent_2_score")) 

# 42.	Have a look at the new object datlong that results: 
View(datlong)       

# This function pivot_longer has taken as input the data in dat, it has created a new variable 
# called "test" which reports whether it is the Gent_1_score or the Gent_2_score that is 
# the measurement, and a new variable called "vocab" where the actual scores are listed. 
# Then, the following list of variables let’s the function pivot_longer know which variables 
# from the object dat we are converting (or adjusting (pivoting) to long format). It also includes all the other variables, 
# but unconverted. 
# How many rows of data are there now corresponding to data from subject_ID number 1?

# ANSWER: 2.

# 43.	Let’s tidy things up so we only have subject_ID, and the Gent vocabulary scores by using select: 

datlongsummary <- select(datlong, subject_ID, test, vocab)

#########################
##### Task 6: Long to wide format conversion

# 44. Now, we will have a go at converting from long to wide format. Let’s start with the datlongsummary 
# object. We will convert this so that Gent_1_score and Gent_2_score are listed alongside each other 
# – one row per person. The  command for this is the reverse of pivot_longer, called pivot_wider. 
# Run this command: 

datwide <- pivot_wider(datlongsummary, names_from = "test", values_from = "vocab")

# This command takes the data from datlongsummary and puts the different measures reported in 
# the variable test into different columns again, filling in the values from the variable vocab.
