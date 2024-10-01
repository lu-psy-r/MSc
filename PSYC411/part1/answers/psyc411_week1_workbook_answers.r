# # # # # # # # # # # # # # PSCY411 Workbook #############
########## Week 1
# 
# In your group, work through this workbook, note any problems and questions you have, 
# and come prepared to the online practical class to go through the tasks and ask your questions.
# 
# If you've done statistics using R-studio before then the first and second part will be just
# revision for you. In which case, the third part is where you can focus your work.
# #
# The first part of this workbook reproduces what you saw in the week 1 part 3 lecture.
# The second part gives you some more exercises in using R studio for finding means, 
# standard deviations, z scores, and drawing histograms.
#                                         
# The third part provides some more extended tasks you can do to practise exploring what R
# -studio can do and develop your skills further. If you are new to R-studio then parts 1
# and 2 cover what you need to know, and this third part contains more optional exercises.


#################Part 1: Repeat the steps from lecture 1 part 3
#######Task 1: Start R-studio

# 1.	Open a browser and navigate to: https://psy-rstudio.lancaster.ac.uk
# 
# 2.	If you are connecting from home, remember that you first of all have to connect to the 
# University network - information on how to do that here: https://portal.lancaster.ac.uk/ask/vpn/
# 
# 3.	In the “console” part of the R window, next to the >, type
10 + 30
#  Press return.
# It should give you the answer 40.

######Task 2: Using the console

# 4.	In the console, type
a <- 40
# and press Return.

# 5.	Now type
a
# Press Return.
# It should give you the answer 40. “a” is called an object, think of it like a bucket that you can keep a number, or some numbers, or actually all kinds of stuff in.

# 6.	Now let’s look at a function. In the console, type
sqrt(13)
# Press Return.
# ”sqrt” is a function that takes the square root of whatever is inside the brackets.

# 7.	Now find the square root of the object a by typing
sqrt(a)
# Press return.

# ANSWER: 3.6, 6.324555 


########Task 4: finding distributions
# 8.	Make a new object “b”, and put this list of children’s attachment scores into it:
b <- c( 4, 1, 5, 3, 8, 2, 2, 6, 8, 5, 4, 1, 6, 5, 4, 5, 7, 9, 10, 1, 1, 3, 5, 4, 6, 4, 8, 6, 5, 5, 7, 8, 9, 8, 8, 2, 1, 4, 3, 2, 5, 1, 5, 6, 8, 6, 7, 2, 7)

# 9.	Check it works by typing b, press return. 

# 10.	Find the mean of these numbers by typing
mean(b)

# 11.	Find the median of these numbers by typing
median(b)

# 12.	Find the standard deviation of these numbers by typing
sd(b)

# 13.	Draw a histogram of these numbers by typing
hist(b)

# Answer: mean 4.9, median 5, sd 2.5.


#########Task 5: z scores
# 14.	Make a new object b_z and assign to it the z scores of the values from b:
b_z <- scale(b)

# 15.	Check that it worked by typing
b_z

# 16.	Draw a histogram of b_z by typing
hist(b_z)


##############Part 2: Extra practise. ###############
########Task 6: investigating distributions

# 17.	Let’s make three new objects, with the marks from three people’s university masters courses. They are called annie, saj, and carrie and they took 10 courses each. We use the special notation “c()” to indicate a list, each number in the list is separated by a comma. Type the following into the console:
annie <- c( 55,95,85,65,65,85,65,95,65,75 )
saj <- c( 65,85,95,75,65,55,55,75,95,85 )
carrie <- c( 75,65,95,95,55,85,75,55,95,55 )

# 18.	Who has the highest average (mean) score for their course? (hint: use the mean() function)
mean(annie); mean(saj); mean(carrie)
# ANSWER: They all have the same mean = 75.

# 19.	Who has the most variable scores for their course? (hint: use the sd() function).
sd(annie); sd(saj); sd(carrie)
# ANSWER: Annie has the least variable scores sd = 14.14214, then saj sd = 14.90712, then carrie sd = 16.99673. Carrie is most variable.

# 20.	What is the median score for each student? (hint: you can use the summary() function, or the median() function). What does this mean about the distribution of each students’ scores? Use the function hist() to draw the distributions to help you see.
median(annie); median(saj); median(carrie)
# ANSWER: median(annie); median = 70; median(saj) and median(carrie) are both median = 75. So, annie’s scores are positive skewed – more lower values and a few (very) high values. saj looks like a uniform (flat) distribution, and carrie is different than normal distribution – maybe bimodal? In each case it’s very hard to tell from so few data points, and more data would make it clearer.

#######Task 7: standardised scores: Z scores

# 21.	Make a new object called “annie_z” and use the function “scale” to convert annie’s scores to z-scores: in the console type
annie_z <- scale(annie)

# 22.	You can have a look at the standardised scores of annie, by just typing
annie_z
# To what did annie’s highest initial score of 95 convert to?

# ANSWER: 1.4142136

# 23.	What is the mean and standard deviation of annie_z’s standardised scores?
mean(annie_z); sd(annie_z)
# ANSWER: mean = 0, sd = 1. So that’s good.

# 24.	Draw a histogram of annie’s standardised scores, in the console type
hist(annie_z)
# What is the peak frequency value?
 
# ANSWER: between -1 and -0.5.

# 25.	Bonus extra: If you want to find out the proportion of scores lower than a particular score you can do it like this in R-studio: pnorm(x) where x is the z-score you’re interested in. What is the proportion of scores lower than annie’s highest grade score?
pnorm(1.4142136)
# ANSWER: pnorm(1.4142136) = 0.9213504, 92% of scores (in a population) are lower than her highest score.



##############Part 3: Extending knowledge
# If you’ve whizzed through the previous tasks, then you can move on to the following activities to explore further the functionality of R studio.

# Task 8: Exploring operators. 
# So far, we’ve just looked at “+” as an operator. Go to this page: https://www.statmethods.net/management/operators.html
# 26.	 In the console, assign the object d to be 100 multiplied by 246.
# 27.	In the console, assign the object e to be 84 divided by 32.1.
# 28.	Assign the variable f to 8 to the power of 4 (in R this is called exponentiation).
# 29.	What is the result of d added to e all divided by f
d <- 100 * 246; e <- 84/32.1; f <- 8^4 (or f <- 8**4); (d+e)/f 
# ANSWER:  6.006498

########Task 9: Exploring functions
# So far, we’ve just looked at the square root function sqrt(). Go to this page:
# https://www.statmethods.net/management/functions.html

# 30.	What is the result of abs(-5.3)? What does the “abs” function do?
abs(-5.3)
# ANSWER: 5.3. It takes the sign away from the number.

# 31.	Using the seq() function, generate a sequence of numbers from 0 to 30 in intervals of 3.
seq(0,30,3) 

# 32.	Assign the sequence generated in 31 to a new object. Now compute the mean of the sequence of numbers. (remember that objects can be a single number, or a sequence of numbers (called an array or a vector) or anything you want to put into it – remember, think of objects as buckets).
g <- seq(0,30,3); mean(g)
# ANSWER: answer is mean = 15.

########Task 10: Exploring others' data
# Have a look at this article: Scullin, M. K., Gao, C., & Fillmore, P. (2021). Bedtime music, 
# involuntary musical imagery, and sleep. Psychological Science, 32(7), 985-997. 
# https://journals.sagepub.com/doi/10.1177/0956797621989724
# 
# Abstract
# Many people listen to music for hours every day, often near bedtime. 
# We investigated whether music listening affects sleep, focusing on a 
# rarely explored mechanism: involuntary musical imagery (earworms). In 
# Study 1 (N = 199, mean age = 35.9 years), individuals who frequently 
# listen to music reported persistent nighttime earworms, which were 
# associated with worse sleep quality. In Study 2 (N = 50, mean age = 21.2 years), 
# we randomly assigned each participant to listen to lyrical or instrumental-only 
# versions of popular songs before bed in a laboratory, discovering that 
# instrumental music increased the incidence of nighttime earworms and worsened 
# polysomnography-measured sleep quality. In both studies, earworms were 
# experienced during awakenings, suggesting that the sleeping brain continues 
# to process musical melodies. Study 3 substantiated this possibility by showing 
# a significant increase in frontal slow oscillation activity, a marker of 
# sleep-dependent memory consolidation. Thus, some types of music can disrupt 
# nighttime sleep by inducing long-lasting earworms that are perpetuated by spontaneous 
# memory-reactivation processes.
# 
# The data from the study is available on this website: https://osf.io/7tfqz/
# The data we will look at is from the first study, the data set called 
# "Earworm_MTurk_OSF.sav" on the osf site. These data are saved in spss format, 
# which is not great for R-studio. We can still read it in, though, using a function called spss.get()
# 
# 33.	Browse the paper to see what it is about. Focus on Study 1. 
# 
# 34.	From the website https://osf.io/7tfqz/ download the data file: "Earworm_MTurk_OSF.sav", 
# and also download the codebook file: "Earworm_MTurk_Codebook.xlsx". 
# The codebook tells you what each of the measures are in the data file.
# 
# 35.	Load the data into R-studio: in the bottom right panel of R-studio, click on Upload, 
# and browse to the Earworm_MTurk_OSF.sav file. It should then appear in the list of files 
# in that bottom right panel.
# 
# 36.	That step means we can access the file, but it isn’t yet loaded into R-studio. 
# # So, next load the data file into R-studio so we can work on it. You might have noticed 
# that the data file is in SPSS format (that’s what the .sav ending to the file means). 
# But, we can still load that in to R-studio. 
# To do that first, load the library “Hmisc”: 

library(Hmisc)

# 37.	Then, use the function spss.get(): 
dat <- spss.get("Earworm_MTurk_OSF.sav")

# 38.	You should have made a new data set in R-studio called "dat".

# 39.	Next, we can have a look at the data. Here are a few questions to get you going:
  
# a)	How many male, how many female participants?
#ANSWER: summary(dat$Gender)
 # 112 male, 87 female

# b)	How many people never have earworms in the middle of the night?
# ANSWER: summary(dat$Earworms.MiddleOfTheNight)
# ANSWER: 97

# c)	For the Stanford Sleepiness Scale, how many participants felt “Somewhat foggy, let down”?
# ANSWER: summary(dat$StanfordSleepinessScale)
# ANSWER: 17.
# 
# d)	What was the mean, SD and range of age of the participants? Does your calculation of mean age correspond to that given in the paper?
# ANSWER: library(tidyverse)
# ANSWER: summarise(dat, mean(Age), sd(Age), min(Age), max(Age))
#  ANSWER: mean = 35.9, sd = 10.9, range 20-73.
# 
#  e)	Can you work out the mean age of the male and female participants separately?
#  ANSWER: library(tidyverse); dat %>% group_by(Gender) %>% summarise(mean(Age))
# Gender `mean(Age)`
# 1 M             34.3
# 2 F             38.1
# 
# f)	Explore the data, see if you can remember tasks for separating different subgroups, graphing relations, comparing groups.
# 
# ANSWER: e.g., dat %>% ggplot( aes(x = PSQI.TST, y = PSQI.SOL)) + geom_point()
