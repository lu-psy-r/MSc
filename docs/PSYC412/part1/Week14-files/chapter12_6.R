# Statistics for Linguists: An Introduction Using R

# --------------------------------------------------------
# 12.6. Analyzing gesture perception: Hassemer & Winter (2016)
# 12.6.1. Exploring the dataset:

# Load data and check:

ges <- read_csv('hassemer_winter_2016_gesture.csv')
ges

# Tabulate distribution of participants over conditions:

table(ges$pinkie_curl)

# Tabulate overall responses:

table(ges$choice)

# Proportion of choices:

table(ges$choice) / sum(table(ges$choice))

# Another way to compute proportions:

prop.table(table(ges$choice))

# Tabulate response choice against pinkie curl condition:

xtab <- table(ges$pinkie_curl, ges$choice)
xtab

# Row-wise proportions:

xtab / rowSums(xtab)

# Another way to compute row-wise proportions:

round(prop.table(xtab, margin = 1), digits = 2)


# 12.6.2. Logistic regression analysis:

# The following yields an error...

ges_mdl <- glm(choice ~ pinkie_curl, data = ges)	# error

# ...because the glm() doesn't know which GLM t run.

# Let's supply the  family argument:

ges_mdl <- glm(choice ~ pinkie_curl,
               data = ges, family = 'binomial')	# error

# The 'choice' column is a character but needs to be factor.
# Convert it to factor:

ges <- mutate(ges, choice = factor(choice))

# Check:

class(ges$choice)

# Check order of levels:

levels(ges$choice)

# Fit the logistic regression model:

ges_mdl <- glm(choice ~ pinkie_curl, data = ges,
               family = 'binomial')

# Interpret coefficients:

tidy(ges_mdl)

# Create tibble for predict():

ges_preds <- tibble(pinkie_curl = 1:9)

# Get predicted log odds:

predict(ges_mdl, ges_preds)

# Or probabilities:

plogis(predict(ges_mdl, ges_preds))

# Alternative way to get probabilities:

predict(ges_mdl, ges_preds, type = 'response')

# Extract predictions and compute 95% confidence interval:

ges_preds <- as_tibble(predict(ges_mdl,
                               ges_preds,
                               se.fit = TRUE)[1:2]) %>%
  mutate(prob = plogis(fit),
         LB = plogis(fit - 1.96 * se.fit),
         UB = plogis(fit + 1.96 * se.fit)) %>%
  bind_cols(ges_preds)

# Make a plot of these predictions:

ges_preds %>% ggplot(aes(x = pinkie_curl, y = prob)) +
  geom_point(size = 3) +
  geom_errorbar(aes(ymin = LB, ymax = UB), width = 0.5) +
  scale_x_continuous(breaks = 1:9) +
  xlab('Pinkie curl') +
  ylab('p(y = Shape)') +
  theme_minimal()




