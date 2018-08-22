library(ggplot2)

###############################################################################################

# loading cleaned Titanic dataset from exercise 03_02, if dataset is already loaded comment out
titanic <-
  as_tibble(read.csv(file = "03_02_titanic/titanic_clean.csv", header = TRUE, sep = ","))

# renaming variables to match names found in Datacamp's Titanic dataset
titanic <- titanic %>%
  rename(
    Pclass = pclass,
    Sex = sex,
    Age = age,
    Survived = survived
  )

###############################################################################################

# code that will run on Datacamp tutorial

# 1 - Check the structure of titanic
str(titanic)

# 2 - Use ggplot() for the first instruction
ggplot(titanic, aes(x = Pclass, fill = Sex)) +
  geom_bar(position = "dodge")

# 3 - Plot 2, add facet_grid() layer
ggplot(titanic, aes(x = Pclass, fill = Sex)) +
  geom_bar(position = "dodge") +
  facet_grid(. ~ Survived)

# 4 - Define an object for position jitterdodge, to use below
posn.jd <- position_jitterdodge(0.5, 0, 0.6)

# 5 - Plot 3, but use the position object from instruction 4
ggplot(titanic, aes(x = Pclass, y = Age, color = Sex)) +
  geom_point(size = 3,
             alpha = 0.5,
             position = posn.jd) +
  facet_grid(. ~ Survived)