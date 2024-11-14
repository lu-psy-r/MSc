# This is a r script version of the Week 1 practical workbook
# In an r script you begin a line with # to indicate that it is a comment
# and not intended for r to run this as a command.

# 3.	In the console part of the R window, next to the >, type 10 + 30. 
# Press return.

10 + 30

# It should give you the answer 40.
 
# Task 2: Using the console
# 
# 4.	In the console, type a <- 40 and press Return.

a <- 40
a

# 5.	Now type a. Press Return.
# It should give you the answer 40. "a" is called an object, think of it like a 
# bucket that you can keep a number, or some numbers, or actually all kinds of 
# stuff in.

# 6.	Now let’s look at a function. In the console, type sqrt(13). Press Return.

sqrt(13)

# sqrt is a function that takes the square root of whatever 
# is inside the brackets.

# 7.	Now find the square root of the object a by typing sqrt(a). Press return.

sqrt(a)

# ANSWER: 6.32

# Task 4: finding distributions

# 8.	Make a new object "b", and put this list of children's attachment scores 
# into it:

b <- c( 4, 1, 5, 3, 8, 2, 2, 6, 8, 5, 4, 1, 6, 5, 4, 5, 7, 9, 10, 1, 1, 3, 5, 4, 6, 4, 8, 6, 5, 5, 7, 8, 9, 8, 8, 2, 1, 4, 3, 2, 5, 1, 5, 6, 8, 6, 7, 2, 7)

# 9.	Check it works by typing b, press return. 

b

# 10.	Find the mean of these numbers by typing mean(b).

mean(b)

# ANSWER: 4.94

# 11.	Find the median of these numbers by typing median(b).

median(b)

# ANSWER: 5.00

# 12.	Find the standard deviation of these numbers by typing sd(b).

sd(b)

# ANSWER: 2.50

# 13.	Draw a histogram of these numbers by typing hist(b).

hist(b)

# Task 5: z scores

# 14.	Make a new object b_z and assign to it the z scores of the values from b:

b_z <- scale(b)

# 15.	Check that it worked by typing b_z.

b_z

# 16.	Draw a histogram of b_z by typing hist(b_z).

hist(b_z) 

# Part 2: Extra practice.

# Task 6: investigating distributions

# 17.	Let’s make three new objects, with the marks from three people's 
# university masters courses. They are called annie, saj, and carrie 
# and they took 10 courses each. We use the special notation c() to 
# indicate a list, each number in the list is separated by a comma. 
# Type the following into the console:
   
annie <- c( 55,95,85,65,65,85,65,95,65,75 )
saj <- c( 65,85,95,75,65,55,55,75,95,85 )
carrie <- c( 75,65,95,95,55,85,75,55,95,55 )

# 18.	Who has the highest average (mean) score for their course? (hint: use 
# the mean() function) (note you can include lists of commands separated by a ';', 
#r will process each command in sequence)

mean(annie); mean(saj); mean(carrie)

# ANSWER: They all have the same mean = 75.00.

# 19.	Who has the most variable scores for their course? (hint: use the 
# sd() function).

sd(annie); sd(saj); sd(carrie) 

# ANSWER: Annie has the least variable scores sd = 14.14, then Saj sd = 14.91, 
# then Carrie sd = 17.00. Carrie is most variable.

# 20.	What is the median score for each student? (hint: you can use the summary() 
# function, or the median() function). What does this mean about the distribution 
# of each students' scores? Use the function hist() to draw the distributions to 
# help you see.

hist(annie)
hist(saj)
hist(carrie)

median(annie); median(saj); median(carrie) 

# ANSWER: Annie median = 70.00; Saj and Carrie are both median = 75.00. 
# So, annie's scores are positive skewed – more lower values and a few 
# (very) high values. saj looks like a uniform (flat) distribution, and 
# carrie is different than normal distribution – maybe bimodal? In each 
# case it's very hard to tell from so few data points, and more data would make it clearer.

# Task 7: standardised scores: Z scores
# 
# 21.	Make a new object called "annie_z" and use the function scale to convert 
# annie’s scores to z-scores: in the console type annie_z <- scale(annie). 

annie_z <- scale(annie)

# 22.	You can have a look at the standardised scores of annie, by just typing 
# annie_z. To what did annie’s highest initial score of 95 convert to?

annie_z

#   ANSWER: 1.41

# 23.	What is the mean and standard deviation of annie_z's standardised scores?

mean(annie_z); sd(annie_z)

#   ANSWER: mean = 0, sd = 1. So that's good.

# 24.	Draw a histogram of annie's standardised scores, in the console 
# type hist(annie_z). What is the peak frequency value?

hist(annie_z)  

#   ANSWER: between -1 and -0.5.

# 25.	Bonus extra: If you want to find out the proportion of scores lower than 
# a particular score you can do it like this in R-studio: pnorm(x) where x 
# is the z-score you're interested in. What is the proportion of scores lower 
# than annie’s highest grade score?

pnorm(1.41)

#   ANSWER: pnorm(1.41) = 0.92, 92% of scores (in a population) are 
# lower than her highest score.

# Part 3: Extras
# If you've whizzed through the previous tasks, then you can move on to the 
# following activities to explore further the functionality of R studio.

# Task 8: Exploring operators. 
# So far, we’ve just looked at "+" as an operator. Go to this page:
# https://www.statmethods.net/management/operators.html

# 26.	 In the console, assign the object d to be 100 multiplied by 246.

d <- 100 * 246

# 27.	In the console, assign the object e to be 84 divided by 32.1.

e <- 84/32.1

# 28.	Assign the variable f to 8 to the power of 4 (in R this is called 
# exponentiation).

f <- 8^4

# 29.	What is the result of d added to e all divided by f

(d + e)/f

# ANSWER: 6.006498


# Task 9: Exploring functions
# So far, we've just looked at the square root function sqrt(). Go to this page:
#   https://www.statmethods.net/management/functions.html

# 30.	What is the result of abs(-5.3)? What does the "abs" function do?

abs(-5.3)

#   ANSWER: 5.3. It takes the sign away from the number.

# 31.	Using the seq() function, generate a sequence of numbers from 0 to 30 in 
# intervals of 3.

seq(0,30,3)

# 32.	Assign the sequence generated in 31 to a new object. Now compute the mean 
# of the sequence of numbers. (remember that objects can be a single number, 
# or a sequence of numbers (called an array or a vector) or anything you want to 
# put into it – remember, think of objects as buckets).

g <- seq(0,30,3) 
mean(g)

# ANSWER: mean = 15.00
