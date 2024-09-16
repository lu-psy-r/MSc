# PSCY401 Workbook Week 4
# Answers

# The materials in this workbook share some material with Glasgow University Psychology
# Department Teaching in R website:
# https://psyteachr.github.io/quant-fun-v2

# ########################################################################
# Part 1: Revision for last week

# ####################################
# Task 1: Your data from the paper in Psychological Science

# 1. Your take-home task was to produce some graphs of the data set downloaded from a
# paper in Psychological Science. Show your graphs and R script to the rest of your group.


# ########################################################################
# Part 2: Load in the Vocabulary Scores Data and Produce Graphs

# ####################################
# Task 2: Load in the Data

# 2.  Remember to clear out R first:

rm(list=ls())

# The data set on the Shipley and Gent vocabulary scores is now updated with the data
# from your group, so it now contains four years of PSYC401 students' data. I've omitted
# Age as this might impact anonymity of the data. Download the data from the week 4 moodle folder:
# "PSYC401-shipley-scores-anonymous-17_22.csv" and read the data into
# an object in R studio called "vdat" (for vocabulary data).

# ANSWER:
vdat <- read.csv("PSYC401-shipley-scores-anonymous-17_22.csv"); View(vdat)

# 3. As a reminder, when we want to look at a particular variable (a column) in an object in
# R studio, we refer to it using the $ notation. So, for the object "vdat" and the variable
# "academic_year"you would refer to it as vdat$academic_year?. 
# For this data set, we need to change academic year to be a nominal (factor) variable.
# Why does academic year have to be nominal and not interval/ratio:

vdat$academic_year <- as.factor(vdat$academic_year)

# View the data.

# ANSWER:
# It has to be nominal because we do not have a hypothesis about the order of years of groups being
# important to the data. So we want each year to be treated independently in our
# analysis.

# 4. Make sure the tidyverse library is loaded. Select all the variables apart from
# Dyslexia_diagnosis and Age and save as a new object called "summaryvdat".
# We will omit these variables because they are not complete for the dataset.

# ANSWER:
library(tidyverse)
summaryvdat <- select(.data = vdat, subject_ID, english_status, Gender, Shipley_Voc_Score, Gent_1_score, Gent_2_score, academic_year)

# 5. Arrange the data according to Gent_2_score, from highest to lowest.
# Save this as a new object called "summaryvdat_sort"

# ANSWER:
summaryvdat_sort <- arrange(.data = summaryvdat, desc(Gent_2_score))
View(summaryvdat_sort)

# ####################################
# Task 3: Draw Graphs of the Vocabulary Data

# 6. Draw graphs of the following relations:
# * English status and academic year
# * Gender and academic year
# * Vocabulary score and academic year

# ANSWER:
ggplot(summaryvdat, aes(x = academic_year, fill = english_status)) + geom_bar(position = "dodge")
ggplot(summaryvdat, aes(x = academic_year, fill = Gender)) + geom_bar(position = "dodge")
ggplot(summaryvdat, aes(x = academic_year, y = Gent_1_score)) + geom_boxplot()

# 7. Save your script file.

# ########################################################################
# Part 3: Grouping data in R studio

# ####################################
# Task 4: Loading and joining data in R studio 

# 8. Now, let's clear out R-studio before we get started again:
rm(list=ls())

# 9. Go to the data files from week 2 and load them into Rstudio again
# ("ahicesd.csv", and "participantinfo.csv").
# Remember these data come from this study:
# Woodworth, R.J., O'Brien-Malone, A., Diamond, M.R. and Schuz, B. (2018). Data from, "Web-based Positive Psychology Interventions: A Reexamination of Effectiveness". Journal of Open Psychology Data, 6(1).
# Remind yourself of the aim of the study and the variables that are in the data set (see end of this
# script file for repeat description on the study).

# ANSWER:
dat <- read.csv("ahicesd.csv")
pinfo <- read.csv("participantinfo.csv")

# 10. Next, load and join the ahicesd.csv and participantinfo.csv data in R studio.
# Call the joined data set "all_dat"
# (see week 2 workbook for reminders about this)

# ANSWER:
all_dat <- inner_join(x = dat, y = pinfo, by = c('id', 'intervention'))

# ####################################
# Task 5: Selecting and manipulating data

# 11. We're not interested in the individual questionnaire items. So, let's select all
# the variables we want to keep (omitting the individual questionnaire items),
# and save this to an object called summary_all_dat (again see week 2 workbook for reminder)

# ANSWER:
summary_all_dat <- select(.data = all_dat, ahiTotal, cesdTotal, sex, age, educ, income, occasion, intervention)

# 12. Next, we will add another variable to the data. We use the function mutate() for this.
# Let's scale the ahiTotal and cesdTotal values and add them to the summary_all_dat set.

summary_all_dat_scale <- mutate(.data = summary_all_dat, ahiTotalscale = scale(ahiTotal), cesdTotalscale = scale(cesdTotal))

# What are the minimum and maximum values of the new variable ahiTotalscale?
# (hint: use the arrange() function, or the min() and max() functions)
# What do these scale values mean? (reminder: they are Z scores).

# ANSWER:
min(summary_all_dat_scale$ahiTotalscale)
max(summary_all_dat_scale$ahiTotalscale)
# -2.87, 2.90 standard deviations from the mean.

# 13. The next way we will work with the data is to organise the observations into different groups.
# First of all, here is the function summarise(). This works by summarising the results of a data set
# according to a particular measure. So, instead of

mean(summary_all_dat_scale$ahiTotal)

# you can use this, which turns out to be a much more powerful way of looking at the data:

summarise(.data = summary_all_dat_scale, mean(ahiTotal))

# They should give the same results - check that they do.

# This function "summarise() is more powerful because you can look at several values
# at the same time, e.g.:

summarise(.data = summary_all_dat_scale, mean(ahiTotal), sd(ahiTotal), mean(cesdTotal), sd(cesdTotal))

# What is the result of this command?

# ANSWER: 
# mean(ahiTotal) sd(ahiTotal) mean(cesdTotal) sd(cesdTotal)
# 1       72.78831     14.20058         13.1381      11.68654

# 14. But now let's think about what kind of patterns we'd like to investigate in the data.
# There are four interventions conducted in this study. Let's look at each of these interventions
# and their effect of ahiTotal and cesdTotal. We can look at subgroups of data either by using
# the filter() function, or by using the function group_by(). The advantage of group_by()
# is that we can look at several groups at the same time, rather than dividing up the data
# file into pieces. Let's organise by the different interventions.

summary_all_dat_scale_intervention <- group_by(.data = summary_all_dat_scale, intervention)

# this command takes the data summary_all_dat_scale, and then groups it according to the
# four interventions in the data. We can't yet see any difference in
# summary_all_dat_scale_intervention but it's in there, lurking, just waiting.
# Now, we can look at the means for each intervention using the summary function
# again. Run the summary function on summarydata_scale_intervention. What happens?

# ANSWER: 
summarise(.data = summary_all_dat_scale_intervention, mean(ahiTotal))

# get means per condition.  
#   intervention mean(ahiTotal)
#          <int>            <dbl>
# 1            1             71.8
# 2            2             71.8
# 3            3             72.0
# 4            4             75.4

# 15. You can also group by several factors at the same time. We can group by
# intervention and get means and standard deviations, but that is not going to give us
# a huge amount of insight into how the interventions affect the happiness measure
# because we are combining the mean of ahiTotal across all occasions of testing,
# including testing before the intervention has been applied.

# So, let's group by intervention and occasion of testing:

summary_all_dat_intocc <- group_by(.data = summary_all_dat_scale, intervention, occasion)

# Now produce the means and standard deviations of the happiness score (ahiTotal)
# for each intervention at each testing occasion. 

# ANSWER:
summarise(.data = summary_all_dat_intocc, mean(ahiTotal), sd(ahiTotal))

# 16. This doesn't print all the lines out, so you can make a new object
# (e.g., called sum_output) and view that, or you can filter out some of the lines
# so we only look at the first and second occasion of testing.

sum_output <- summarise(.data = summary_all_dat_intocc, mean(ahiTotal), sd(ahiTotal))
View(sum_output)

# ########################################################################
# Part 4: Graphing groups

# ####################################
# Task 6: Graph some groups

# 17. Draw a scatter plot of ahiTotal and cesdTotal values for the whole data
# set (hint: use the "ggplot()" function with geom_point() ).
# Make it a bit more beautiful using the labs() addition.

# ANSWER:
ggplot(summary_all_dat, aes(x = ahiTotal, y = cesdTotal)) + geom_point() + labs(title = "Happiness and Depression Scores", x = "Happiness Score", y = "Depression Score")

# 18. Now redraw the plot, but colour the points according to whether they are first,
# second, third, etc occasion of testing. Add in col = "occasion" into the aes() function, 
# so that this part looks like this: 
# "aes(x = ahiTotal, y = cesdTotal, col = occasion)"

# ANSWER:
ggplot(summary_all_dat, aes(x = ahiTotal, y = cesdTotal, col = occasion)) + geom_point() + labs(title = "Happiness and Depression Scores", x = "Happiness Score", y = "Depression Score")

# ########################################################################
# Part 5: Working out whether nominal data is random or structured.
# Repeating the analyses from Lecture week4 part3

# ####################################
# Task 7:  Chi-squared and Cramer's V

# 19. Let's now have a look at running Chi-squared and Cramer's V tests in R. download the
# titanic.csv data from the moodle week 4 folder. Read it into an object called "titanic". View
# the data. It should correspond to the data in the overhead slides.

# ANSWER:
titanic <- read.csv("titanic.csv")

# 20. Make a bar graph to count the numbers of survived and died by class.

# ANSWER:
ggplot(titanic, aes(x = class, fill = survival)) + geom_bar( position = 'dodge')

# 21. Now let's see if there is a significant relation between class and survival using Chi-squared: 

chisq.test(x = titanic$class, y = titanic$survival)

# The results give the chi-squared value, the number of degrees of freedom,
# and the p-value. P = 2.2e-16 means p = .0000000000000022. That's highly significant.
# That means the observations are divided across the categories in a way that is very unlikely
# to be due to chance (for this number (P = 2.2e-16), it means there's a 2 in a quadrillion chance
# that titanic survival was not related to class).
# In a report, you would write: Chi-squared(2, N= 1309) = 127.86, p < .001.

# 22. Now, let's compute Cramer's V. 
# First, we need to make sure we have the package lsr:

install.packages("lsr")
library(lsr)

# Then run the test:
cramersV(x = titanic$class, y = titanic$survival)

# 23. Your next task is to run some Chi-squared and Cramer's V tests on some
# of the other nominal data. Open the data "PSYC401-shipley-scores-anonymous-17_22.csv"
# again. Investigate the association between gender and year (are there different distributions
# of males and females in each of our masters' year cohorts)
# using Chi-squared and Cramer's V. Is it significant? 

# ANSWER:
vdat <- read.csv("PSYC401-shipley-scores-anonymous-17_22.csv"); View(vdat)
vdat$academic_year <- as.factor(vdat$academic_year)

chisq.test( x = vdat$Gender, vdat$academic_year)
cramersV( x = vdat$Gender, vdat$academic_year)
# it isn't significant, X-squared = 9.47, df = 10, p-value = .488, but there is < 5 in the 
# "Other" gender category which gives us the error message "Chi-squared approximation may be incorrect".
# if we focus just on Male/Female data, say we are interested only in these larger categories:

vdatmf <- filter(.data = vdat, Gender == "Male" | Gender == "Female")
chisq.test( x = vdatmf$Gender, vdatmf$academic_year)
cramersV( x = vdatmf$Gender, vdatmf$academic_year)
# it still isn't significant, X-squared = 5.30, df = 5, p-value = .381

# 24. What about the association between english_status and Gender? 

# ANSWER:
chisq.test( x = vdat$Gender, vdat$english_status)
cramersV( x = vdat$Gender, vdat$english_status)

# not significant, X-squared = .27, df = 2, p-value = .530
# and just for Male/Female:
chisq.test( x = vdatmf$Gender, vdatmf$english_status)
cramersV( x = vdatmf$Gender, vdatmf$english_status)
# still not significant, X-squared = .000, df = 1, p-value = .983

# 25. What about the association between english_status and academic year?

# ANSWER:
chisq.test( x = vdat$english_status, vdat$academic_year)
cramersV( x = vdat$english_status, vdat$academic_year)

# not significant, X-squared = 2.37, df = 5, p-value = .797


# ########################################################################
# Part 6: More practice using Chi-squared and Cramer's V test

# ##############################
# Task 8: More Chi-squared and Cramer's V tests

# 26. Look at the "ahicesd.csv" and "participantinfo.csv" data sets from week 2 again.
# Which nominal measures could you look at an association between?
# Report the Chi-squared test and Cramer's V results for these associations.
# Are these associations significant? How do you interpret the significant associations?

# ANSWER: could have a go at occasion and intervention.
# this would tell you whether the participants are unevenly distributed across the occasions
# and interventions:
a <- group_by(.data = all_dat, occasion, intervention)

chisq.test( x = all_dat$occasion, all_dat$intervention)
cramersV( x = all_dat$occasion, all_dat$intervention)
# chi2(15, N = 992) = 9.78, p = .833
# Cramer's V = .06
# (how to find numbers in the table: nrow(a) )

# 27. Have a further browse of Psychological Science for data sets that you can
# download and begin to explore. Practise applying the data manipulation and graphing
# functions to these data sets.




# Description of Woodworth, R.J., O'Brien-Malone, A., Diamond, M.R. and Schuz, B. (2018). Data from, "Web-based Positive Psychology Interventions: A Reexamination of Effectiveness". Journal of Open Psychology Data, 6(1).

# In our study we attempted a partial replication of the study of Seligman, Steen,
# Park, and Peterson (2005) which had suggested that the web-based delivery of
# positive psychology exercises could, as the consequence of containing specific,
# powerful therapeutic ingredients, effect greater increases in happiness and greater
# reductions in depression than could a placebo control.
# Participants (n=295) were randomly allocated to one of four intervention groups
# referred to, in accordance with the terminology in Seligman et al. (2005) as
# 1: Using Signature Strengths; 2: Three Good Things; 3: Gratitude Visit; 4: Early Memories (placebo control).
# At the commencement of the study, participants provided basic demographic
# information (age, sex, education, income) in addition to completing a pretest
# on the Authentic Happiness Inventory (AHI) and the Center for Epidemiologic
# Studies-Depression (CES-D) scale. Participants were asked to complete
# intervention-related activities during the week following the pretest. Futher
# measurements were then made on the AHI and CESD immediately after the
# intervention period ('posttest') and then 1 month after the posttest (day 38),
# 3 months after the posttest (day 98), and 6 months after the posttest (day 189).
# Participants were not able to to complete a follow-up questionnaire prior to
# the time that it was due but might have completed at either at the time that
# it was due, or later. We recorded the date and time at which follow-up
# questionnaires were completed.
