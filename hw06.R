# Homework 6                                              Data Programming in R
# Due by 11:59 PM on Mon Oct 7              Business Analytics Graduate Program
# via GitHub                                    MSCI:6060 Fall 2019 (Full-Time)

###############################################################################
#                                                                             #
#                               INSTRUCTIONS                                  #
#                                                                             #
###############################################################################

# This homework corresponds to Module 5. Please refer to the
# corresponding materials and ICE (with solutions) posted on ICON.

# Please follow all of the guidelines given on prior homeworks,
# referring to them if necessary. Here are a few important reminders:
#
#   --> Please include the required library(...) commands in your script.
#
#   --> For this assignment, be sure to use qplot(...) instead of
#   plot(...).
#
#   --> Please do not upload any graphics to GitHub. Just upload your
#   script.
#
#   --> While we used "log" in our module examples, in general only use
#   "log" when you have a good reason to do so (e.g., correcting the
#   shape of a skewed histogram). 

###############################################################################
#                                                                             #
#                                EXERCISES                                    #
#                                                                             #
###############################################################################

# Clear workspace

rm(list = ls())

###############################################################################

# The data file "AB_NYC_2019.csv" contains the information of some listings
# in Airbnb in NYC for 2019. The meaning of each column can be found in 
# "AB_NYC_2019_description.txt".
#
# Execute the following code to load the data AB_NYC_2019.csv in the way
# similar to (but slightly different from) the solution of the previous homework. 
# Then complete the exercises below:

library(readr)
library(dplyr)
df<-read_csv("AB_NYC_2019.csv")
df$id<-NULL
df$name<-NULL
df$host_id<-NULL
df$host_name<-NULL
df$neighbourhood<-NULL
df$calculated_host_listings_count<-NULL
df$reviews_per_month<-NULL
df$latitude<-NULL
df$longitude<-NULL
df$neighbourhood_group <- factor(df$neighbourhood_group)
df$room_type <- factor(df$room_type)
df$last_review <- as.Date(df$last_review, format="%y-%m-%d")
df<-filter(df, price >0)
df <- df[complete.cases(df), ]

###############################################################################
# Part 1. Create the following graphics using ggplot2 and scales. 
# You can choose the style (color, font size, background, title, and axis 
# labels, etc.) of graphics freely. As long as your graphics satisfy the basic 
# requirements (e.g. the type of graphics and the columns being used), you will 
# not lose points.

# 1.(a) Create a histogram based on price. You can choose the style of graphic. 
# If you decide to use a logarithmic scale, it is recommended
# to use a small binwidth (e.g. 0.1).

library(ggplot2)

a <- qplot(price,         
      data = df,          
      geom = "histogram",
      binwidth = 0.1,
      log = "x")
a

# 1.(b) Create a bar chart based on neighbourhood_group. You can choose the
# style of graphic.

b <- qplot(neighbourhood_group, data=df, geom = "bar", 
           fill = I("Orange"),
           color = I("red"))

b

# 1.(c) Create a scatter plot based on price (x-axis) and 
# number_of_reviews (y-axis). You can choose the style of graphics. 
# If you decide to use a logarithmic scale in both x axis and y axis,
# set log="xy".

c <- qplot(price, number_of_reviews, data = df, geom = "point", log = "xy",
           color = I("Red"))

c

# 1.(d) Create a heatmap based neighbourhood_group (x-axis) and 
# room_type (y-axis) columns of data. (Do not use three or more 
# columns to build this graphic.) You can choose the columns.

d <- qplot(neighbourhood_group, room_type, data = df, geom = "bin2d")

d


# 1.(e) Create boxplots of price on a log scale against room_type. 
# You can choose the style of graphics

e <- qplot(room_type, price, data = df, geom = "boxplot", log = "y")

e

# 1.(f) Use faceting to create a graphic involving separated bar charts 
# based on room_type for each neighbourhood_group. 
# You can choose the style of graphics

f <- qplot(room_type, data = df, geom = "bar",
           facets = . ~ neighbourhood_group)
f

###############################################################################

# 1 (g). Create a graphic involving four or more columns of data. You can
# choose all features of the graphic freely. 

g <- qplot(neighbourhood_group, price, data = df, geom = "point",
           log = "y",
           shape = room_type,
           color = minimum_nights)
g
