# Homework 7                                              Data Programming in R
# Due by 11:59 PM on Mon Oct 14              Business Analytics Graduate Program
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

# This homework is the continuation of Homework 6. You will use scale and theme
# functions to adjust the plots created in Homework 6. 
# Execute the following code to load and clean the data AB_NYC_2019.csv in the 
# way similar to Homework 6. Then complete the exercises below:

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
df<-df[complete.cases(df), ]
df<-df[seq(1,nrow(df),10), ] 
  
###############################################################################
# 1. Starting from the commands below, make the following changes to the plot:
#    (a). Include "fill" and "color" in qplot to fill the bars with red and color
#         their borders with black. 
#    (b). Use scale_x_log10 (keep binwidth=0.1 in qplot) to show x-axis in log 
#         scale and change the labels of x-axis to dollar. You will have to delete
#         log="x" in qplot first.
#    (c). Use scale_y_continuous to change the breaks of y-axis 0,100,200,300,
#         400, 500 and 600.
#    (d). Make the plot title "Prices of Listings in Airbnb", the x-axis 
#         title "Price", and the y-axis title "Frequency".
#    (e). Use bold font in the plot title and place the title in the middle 
#         of the top (using "hjust").
#    (f). Remove all x gridlines (the vertical lines), both major and minor grids.
# Use the default value for any attribute of the plot not specified above.  
# When you finish, store the plot as variable p1 and save it as a 6in by 4in
# png file (dot per inch=600) called "p1.png". You can compare your 
# picture with the correct one in "p1_sol.png".


library(ggplot2)
library(scales)
qplot(price, data = df, geom = "histogram",binwidth=0.1,log="x")

a <- qplot(price, data = df, geom = "histogram",binwidth=0.1,log="x",
      fill = I("red"),
      color = I("black"))
a

b <- qplot(price, data = df, geom = "histogram",binwidth=0.1,
                fill = I("red"),
                color = I("black")) + 
        scale_x_log10(name = "Price", label = dollar)
b

c <- b+scale_y_continuous(name = "Frequency", breaks = 100*(0:6))
c

d <- c+ggtitle("Prices of Listings in Airbnb")
d

e <- d + theme(plot.title = element_text(face = "bold",hjust=0.5))
e

f <- e + theme(panel.grid.major.x = element_blank())
f <- f + theme(panel.grid.minor.x = element_blank())
f
 
ggsave(filename = "p1.png", plot = f, width = 6, height = 4,
       dpi = 600)


###############################################################################
# 2. Starting from the commands below, make the following changes to the plot:
#    (a). Use scale_x_log10 to show x-axis in log scale and make the 
#         x-axis title "Price". Then change the labels of x-axis to 
#         dollar and set the limits of x-axis to c(10,1000). You will
#         have to delete log="xy" in qplot first. Ingore the warning 
#         message caused by these changes.
#    (b). Use scale_y_log10 to show y-axis in log scale and make the 
#         y-axis title "Number of Reviews". 
#    (c). Put the titles of both axises in bold font.
#    (d). Use font size 5 in the texts (the labels of ticks) of both axises.
#    (e). Use scale_color_gradient to change the title of the legend for color 
#         to "Available Days" and set the color of the lowest value "Green" and 
#         and the color of the highest value "Red".
#    (f). Use scale_size to change the title of the legend for size 
#         to "Minimum Nights".
#    (g). Use theme(legend.title=element_text(...)) and theme(legend.text=element_text(...)) 
#         to change the font size of the titles and texts in all legends to 8.
# Use the default value for any attribute of the plot not specified above.  
# When you finish, store the plot as variable p2 and save it as a 6in by 4in
# png file (dot per inch=600) called "p2.png". You can compare your 
# picture with the correct one in "p2_sol.png".


library(ggplot2)
library(scales)
qplot(price, number_of_reviews, data = df, geom = "point", log="xy",
         facets = neighbourhood_group ~ room_type, 
         color=availability_365,size=minimum_nights)

a2 <- qplot(price, number_of_reviews, data = df, geom = "point",
            facets = neighbourhood_group ~ room_type, 
            color=availability_365,size=minimum_nights) +
      scale_x_log10(name = "Price", label = dollar, limits = c(10,1000))
a2

b2 <- a2 + scale_y_log10(name = "Number of Reviews")
b2

c2 <- b2 + theme(axis.title.y  = element_text(face = "bold"))
c2 <- c2 + theme(axis.title.x  = element_text(face = "bold"))
c2

d2 <- c2+ theme(axis.text = element_text(size = 5))
d2

e2 <- d2+scale_color_gradient(name = "Available Days", low = "green", high = "red")
e2

f2 <- e2+scale_size(name = "Minimum Nights")
f2

g2 <- f2 + theme(legend.title = element_text(size = 8))
g2 <- g2 + theme(legend.text = element_text(size = 8))
g2

ggsave(filename = "p2.png", plot = g2, width = 6, height = 4,
       dpi = 600) 

