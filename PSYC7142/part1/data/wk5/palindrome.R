# make a function that returns whether a string of letters is a palindrome (1) or not (0)
palindrome <- function(x){
m=0; 

n = as.integer(nchar(x)/2)

for(i in 1:n){ 
#  print(i);
#  print(substr(x,i,i));
#  print(substr(x,nchar(x)-i+1,nchar(x)-i+1));
  if(substr(x,i,i) == substr(x,nchar(x)-i+1,nchar(x)-i+1)) m=m+1 
}

ifelse(m==n,1,0)
}

# test if it works by loading int the papatsou data from week 4, and applying it 
# to the word1 variable:
dat <- read_csv("papatsou_cleaneddata.csv")
# make a new variable in the dataset called pally, and fill it with NAs:
dat$pally <- "NA"
# now for each letter string in the variable word1 (i.e., each row of data), 
# fill dat$pally as to whether it is a palindrome or not:
for( j in 1:length(dat$word1)){
  dat$pally[j] <- palindrome(dat$word1[j])
}
dat$pally <- as.numeric(dat$pally)

# your task is to take the de Zubicaray data, and add a new variable called pally,
# and then see whether being a palindrome or not has an influence on the processing of the word
# by adding pally into the multiple regression analysis from de Zubicaray.

# if you manage to do that, send me an email and tell me what you found!!
