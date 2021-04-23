# QAnon #SaveOurChildren Study
# Rachel Moran

# load libraries
library(tidyverse)
library(dplyr)

# read in original data
saveourchildren <- read.csv("CT - saveourchildren.csv")
childlivesmatter <- read.csv("CT - childlivesmatter.csv")
savethechildren <- read.csv("CT - savethechildren.csv")
endchildtrafficking <- read.csv("CT - endchildtrafficking.csv")

# add tags to each data frame as identifiers of original data frame
saveourchildren <- saveourchildren %>% 
  mutate(tag = "SOC")

childlivesmatter <- childlivesmatter %>% 
  mutate(tag = "CLM")

savethechildren <- savethechildren %>% 
  mutate(tag = "STC")

endchildtrafficking <- endchildtrafficking %>% 
  mutate(tag = "ECT")

# combine the four data frames into one
fulldata <- rbind(savethechildren, saveourchildren, childlivesmatter, 
                  endchildtrafficking)

# select which columns are necessary (check google doc for more details)
data <- fulldata %>% 
  select(tag, User.Name, Created, Followers.at.Posting, Likes, Comments,
         Total.Interactions, Description, Image.Text, URL, Photo) 

# remove the duplicated posts across tags
# note: only one of the tags is kept, I haven't figured out how to note both 
# tags on duplicated posts yet
data <- distinct(data, URL, .keep_all = TRUE)

write.csv(data,"instagram data.csv", row.names = TRUE)

# ------------------------ followers vs. x plots ------------------------------
# edit data frame to remove rows with N/A listed for followers at posting then
# add a row with the values as a number (currently reading as a string)
follow_data <- data %>% 
  filter(Followers.at.Posting != "N/A") %>% 
  mutate(Followers = as.numeric(Followers.at.Posting))

# 
likes_vs_followers <- ggplot(follow_data, aes(x= Followers, y= Likes)) + 
  geom_point() + xlim(0,1250000)

plot(likes_vs_followers)



# Find Frequent Posters in data
freq_posters <- count(data, User.Name, sort = TRUE)
freq_posters <- freq_posters %>% filter(n > 1)
