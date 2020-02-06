# Homework 9                                              Data Programming in R
# Due by 11:59 PM on Tue Nov 5              Business Analytics Graduate Program
# via GitHub                                  MSCI:6060 Fall 2019 (Full-Time)

###############################################################################
#                                                                             #
#                               INSTRUCTIONS                                  #
#                                                                             #
###############################################################################

# This homework corresponds to Module 8 and 9. Please refer to the
# corresponding materials and ICE (with solutions) posted on ICON.
# Please also follow all of the guidelines given on prior homeworks,
# referring to them if necessary.

###############################################################################
#                                                                             #
#                                EXERCISES                                    #
#                                                                             #
###############################################################################

# Clear workspace

rm(list = ls())

###############################################################################

# 1. clinton-street-social-club.csv contains the customer reviews on yelp for  
# the restaurant Clinton Street Social Club. The following codes read this 
# file into a data frame called df. Complete the following tasks:

library(readr)
df<-read_csv("clinton-street-social-club.csv") 

 
# 1.(a) Save the row indices of the reviews containing
# the substring "price" (case insensitive) in a vector called row_ids.
# Use row_ids to extract the rows of df where the reviews containing
# "price" (case insensitive) and save them in a data frame called df_price.

row_ids <- grep("price", tolower(df$reviews), fixed = TRUE)
df_price <- df[row_ids, ]
df_price
 




# 1.(b) Calculate the mean number of characters in the reviews. Save the 
# result in mean_chars.
# [Hint: Base your calculation on *all* characters, including spaces and
# punctuation. Do not round the mean, and do not use any kind of loop to
# complete this task.]

  
mean_chars <- mean(nchar(df_price$reviews))



# 1.(c) Split df$reviews by the period "." and save the results in mylist.

mylist <- strsplit(df$reviews, ".", fixed = TRUE)

# 1.(d) Flatten mylist and save the results in myvec.

myvec <- unlist(mylist)

###############################################################################

# 2. The following code read in the data file invoice.csv.
# Create a single for loop to calculate the total price in this invoice. 
# (You will use the loop to add price*quantity from each row.)
# Save the result in a variable called total. You must use nrow(...) 
# to define the range of the loop index. Do not manually count the number 
# of rows. 

df_invoice<-read_csv("invoice.csv")

n <- nrow(df_invoice)
total <- 0
for(i in 1:n) {
  total <- total + df_invoice$quantity[i] * df_invoice$`unit price`[i]
}
print(total)



###############################################################################

# 3. The following two vectors, years and months, contain year 2017 to 2020
# and all months, respectively. Write a nested (double) for loop to create
# a character vector called yearmonth, which contains all possible strings
# of the form "Month-Year" based on vectors years and months. 
# For example, "Jan-2017" and "May-2020" will be two elements in yearmonth. 
# There should be 4*12=48 elements in yearmonth.
# Use years as the range for the outer loop and months for the inner loop. 
# [Hint: The ouput vector yearmonth can be initialized with the command 
# "yearmonth <-character()" or "yearmonth <-c()". You can add a new element 
# to yearmonth using c() in some way.]

years<-2017:2020
months<-c("Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec")
yearmonth <- c()

for(year in years) {
                for(month in months) {
yearmonth <- c(yearmonth, paste(month, year, sep = "-"))
                           }
}
yearmonth

 
###############################################################################

# 4. The data file dnc_complaint_numbers_IA_2019-10-29.csv includes 
# information on Do Not Call (DNC) and robocall complaints reported to the 
# Federal Trade Commission. The data set contains information reported 
# by consumers, including the telephone number originating the unwanted call.
# The following codes read this file into a data frame called df_DNC. 
# Complete the following:

library(readr)
df_DNC<-read_csv("dnc_complaint_numbers_IA_2019-10-29.csv")
head(df_DNC)

# 4(a) Convert column "Company_Phone_Number" to a character column.


df_DNC$Company_Phone_Number <- as.character(df_DNC$Company_Phone_Number)
class(df_DNC$Company_Phone_Number)



# 4(b) Use string processing functions and for-loop to convert the
# format of phone numbers in "Company_Phone_Number" to (XXX) XXX-XXXX. 
# Note that there is a single white space after the area code. Save 
# the phone numbers in a character vector called new_number. 
# The following code will initialize new_number as a character vector 
# with the same length as "Company_Phone_Number". Save each phone
# number from "Company_Phone_Number" in the new format in the same
# position in vector new_number.

new_number<-character(nrow(df_DNC))




area_code <- as.character()
second <- as.character()
third <- as.character()


n <- nrow(df_DNC)
for(i in 1:n) {
  area_code[i] <- substr(df_DNC$Company_Phone_Number[i], 1,3)
  second[i] <- substr(df_DNC$Company_Phone_Number[i], 4,6)
  third[i] <- substr(df_DNC$Company_Phone_Number[i], 7,10)
  new_number[i] <- paste("(",area_code[i], ")", " ", second[i], "-", third[i], sep = "")
}
print(new_number)

new_number

library(dplyr)

df_DNC$Company_Phone_Number <- new_number





# Hint: Use index i in the for loop as a row ID. As i goes over each 
# row, extract the three pieces of the phone number in
# df_DNC$Company_Phone_Number[i] and paste the three pieces back  
# togther in a different way. Then, assign the number in the new 
# format to new_number[i].



