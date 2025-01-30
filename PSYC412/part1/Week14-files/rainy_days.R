rainy_days <- tibble(city = rep(c("Barcelona", "Glasgow"), each = 500),
                     days_of_rain = c(rbinom(500, 365, 55/365),
                                      rbinom(500, 365, 170/365))) 

rainy_days %>%
  ggplot(aes(days_of_rain)) +
  geom_histogram() +
  facet_wrap(~ city)

rainy_days %>%
  group_by(city) %>%
  summarise(sd = sd(days_of_rain))

# Add Amsterdam (132) and Brussels (199)

rainy_days <- tibble(city = rep(c("Barcelona", "Glasgow", "Amsterdam", "Brussels"), each = 500),
                     days_of_rain = c(rbinom(500, 365, 55/365),
                                      rbinom(500, 365, 170/365),
                                      rbinom(500, 365, 132/365),
                                      rbinom(500, 365, 199/365)))
levels(rainy_days$city)
rainy_days$city <- factor(rainy_days$city, level = c("Barcelona", "Amsterdam", "Glasgow", "Brussels"))

rainy_days %>%
  ggplot(aes(days_of_rain)) +
  geom_histogram() +
  facet_wrap(~ city)

rainy_days %>%
  group_by(city) %>%
  summarise(sd = sd(days_of_rain))
