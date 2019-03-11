#This example comes from KJ HEaly's excellent book "Data Visualization", Ch 2 & 3

## Load Libraries
library(gapminder)
library(tidyverse)


## Tidy Data
## We are using the 'gapminder' dataserr
gapminder
gapminder<-gapminder
summary(gapminder) #to take a look at the data summary

# All we've done here is tell ggplot what dataset we are using 
p <- ggplot(data = gapminder)


# MAPPING STEP: This empty plot has no geoms, so when you look at it all you will see is the axes (aesthetics) you 
# have told it you plan on using 

# we want to plot gdp per capita on the x axis and lefe expectancy on the Y axis
p <- ggplot(data = gapminder,
            mapping = aes(x = gdpPercap,
                          y = lifeExp))
#lets take a look at it!
p #blank plot with some axes, yes? 


# GEOM STEP: add geom_point to your plot 'p' to see a scatterplot of Life Expectancy vs GDP'
p <- ggplot(data = gapminder,
            mapping = aes(x = gdpPercap,
                          y = lifeExp))
p + geom_point() 


## HOW ABOUT A DIFFERENT GEOM?
# Instead of the points, lets just plot the smoothed line that best fits the data
# 'Life Expectancy vs GDP, using a smoother.'
p <- ggplot(data = gapminder,
            mapping = aes(x = gdpPercap,
                          y=lifeExp))

p + geom_smooth()


# YOU CAN ADD MULTIPLE GEOMS: Life Expectancy vs GDP, showing both points and a GAM smoother.
p <- ggplot(data = gapminder,
            mapping = aes(x = gdpPercap,
                          y=lifeExp))
p + geom_point() + geom_smooth() 


# YOU CAN ADD MULTIPLE GEOMS.2:'Life Expectancy vs GDP, points and an ill-advised linear fit.'
p <- ggplot(data = gapminder,
            mapping = aes(x = gdpPercap,
                          y=lifeExp))
p + geom_point() + geom_smooth(method = "lm") 


# COORDINATES AND SCALES STEPS: 'Life Expectancy vs GDP scatterplot, with a GAM smoother and a log scale on the x-axis.'
p <- ggplot(data = gapminder,
            mapping = aes(x = gdpPercap,
                          y=lifeExp))
p + geom_point() +
  geom_smooth(method = "gam") +
  scale_x_log10()


#LABELS AND GUIDES STEPS: 'Life Expectancy vs GDP scatterplot, with a GAM smoother and a log scale on the x-axis, with better labels on the tick marks.'
p <- ggplot(data = gapminder, mapping = aes(x = gdpPercap, y=lifeExp))
p + geom_point() +
  geom_smooth(method = "gam") 

# MAke that line a linear instead of a loess smooth
p <- ggplot(data = gapminder, mapping = aes(x = gdpPercap, y=lifeExp))
p + geom_point() +
  geom_smooth(method = "lm") 

# (ugh....that's not a good idea)


# I WANT MY POINTS TO BE PURPLE!do this inside the geom for points
# 'Setting the color attribute of the points directly.'
p <- ggplot(data = gapminder,
            mapping = aes(x = gdpPercap,
                          y = lifeExp))
p + geom_point(color = "purple") +
  geom_smooth(method = "loess") +
  scale_x_log10()

# I WANT MY LINE TO BE ORANGE! do this inside the geom for the smoother
p <- ggplot(data = gapminder,
            mapping = aes(x = gdpPercap,
                          y = lifeExp))
p + geom_point(color="purple") +
  geom_smooth(color = "orange") +
  scale_x_log10()


# NEXT STEP - MODIFY THE AXES
# How about we make them a log scale?
p <- ggplot(data = gapminder, mapping = aes(x = gdpPercap, y=lifeExp))
p + geom_point() +
  geom_smooth(method = "gam") +
  scale_x_log10()




# Now lets change the text of the axes and add some titles and subtitles
# 'A more polished plot of Life Expectancy vs GDP.'
p <- ggplot(data = gapminder, mapping = aes(x = gdpPercap, y=lifeExp))
p + geom_point(alpha = 0.3) + geom_smooth(method = "gam") +
  scale_x_log10(labels = scales::dollar) +
  labs(x = "GDP Per Capita", y = "Life Expectancy in Years",
       title = "Economic Growth and Life Expectancy",
       subtitle = "Data points are country-years",
       caption = "Source: Gapminder.")


# ALL THE CONTINETNS ARE THE SAME COLOR. How about we make each continent a different color 
# to see if there are continent-level patterns?
#'Mapping the continent variable to the color aesthetic2.
p <- ggplot(data = gapminder,
            mapping = aes(x = gdpPercap,
                          y = lifeExp,
                          color = continent)) #this is how we do it: add  "color = continent"
p + geom_point() +
  scale_x_log10()


# do the same but add the lines
#'Mapping the continent variable to the color aesthetic2.
p <- ggplot(data = gapminder,
            mapping = aes(x = gdpPercap,
                          y = lifeExp,
                          color = continent))
p + geom_point() +
  geom_smooth(method = "loess") +
  scale_x_log10()


# These are a mess - lets put each continent on its own "panel" (i.e., "FACET")

p <- ggplot(data = gapminder,
            mapping = aes(x = gdpPercap,
                          y = lifeExp,
                          color = continent))
p + geom_point() +
  geom_smooth(method = "loess") +
  scale_x_log10()+
  facet_wrap(~ continent)   #this is what you add to put each one on a facet


# zoinks, just realized that we were doing it with all years. Lets just look at 1997

# filter the data so we are only looking at the data for 1997
#save that as a new dataframe called gapminder97, then plot
gapminder97<-filter(gapminder, year==1997)
p <- ggplot(data = gapminder97,
            mapping = aes(x = gdpPercap,
                          y = lifeExp,
                          color = continent))
p + geom_point() +
  scale_x_log10()+
  facet_wrap(~continent) 


#Try using different themes
# theme_classic()+
# theme_dark()+
# theme_void()+
gapminder97<-filter(gapminder, year==1997)
p <- ggplot(data = gapminder97,
            mapping = aes(x = gdpPercap,
                          y = lifeExp,
                          color = continent))
p + geom_point() +
  scale_x_log10()+
  theme_classic()+
  facet_wrap(~continent) 


# How about we try a histogram of life expectancy now?
p <- ggplot(data = gapminder,
            mapping = aes(x = lifeExp))
p + geom_histogram() 
  
# OK, different binwidth
p <- ggplot(data = gapminder,
            mapping = aes(x = lifeExp))
p + geom_histogram(binwidth=5) 
