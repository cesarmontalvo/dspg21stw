#Haleigh Tomlin
#exploring WIOA data
#6/16/21

#install.packages("tidyverse")
library(tidyverse)
library(ggplot2)
options(scipen = 999)



#importing the data
d <- read.csv("PY2019Q4.csv")
head(d)


#using the wioa data dictionary 
#data in four quarters,


#PIRL100 = identifier
#PIRL3000 = State ID (state that submitted the data, but WIOA hides the state the participant is from it seems)
#County, Zip, DOB hidden in public use files
#PIRL201 = sex
#PIRL210-215 give binary responses to being in each race
#PIRL3023 gives a single response to race/ethnicity
#PIRL400 = employment status 
# employed, employed but received notice of termination, not in labor force, unemployed
#PIRL407 = Highest School Grade completed at program entry
#PIRL408 Highest educational level completed at program entry

#Section C.04 - training services ? pg 36
#PIRL1300 = received training
#binary yes no
#PIRL1301 = "Eligible Training Provider - Name
#PIRL1302 = Date entered Trainng
#** PIRL1303 = Type of training service
#01 = on the job
#02 = skill upgrading
#06 = occupational skills training
#08 = prerequisite training
#10 = youth occupational skills training
#12 = job readiness training in conjunction with other training

#PIRL1306 = Occupational Skills training #1
#PIRL1310 = Occupational Skills training #2 
#PIRL1316 = Occupational Skills training #3
#  -- does this mean that they got multiple trainings?
# -- is this why there are less unique IDs than there are rows

#PIRL1610 = Occupational Code (if applicable)
## "record the 8-digit occupational code that best describes the 
## participant's employment using the O*net version 4.0...."

#PIRL1800 = "Type of recognized Credential (WIOA)
## secondary school, AA or AS Diploma, BA or BS, Occupational Licensure
## Occupational Certificate, Occupational Certification, other, none

#PIRL3007 = WIOA measurable skill gains
## 1 = skill gained, 0 = no skill gain
#PIRL3015 = WIOA median earnings (quarter 2)? -- maybe decide on what to use and from which quarters. 
# find out what the quarters are

#PIRL3023 - race/ethnicity single response (hispanic, asian, black, native hawaiian/pacific islander, american
#indian or alaska native, white, multiple race)

d_smaller <- d %>% select(PIRL100, PIRL.3000, PIRL1610, PIRL1800, PIRL.3007, PIRL400, PIRL408, PIRL1300,
                          PIRL1301, PIRL1303, PIRL1306, PIRL1310, PIRL1316,
                          PIRL201, PIRL.3023)

d_smaller <- d_smaller %>% transmute(id = PIRL100,
                                     state = PIRL.3000,
                                     occup_code = PIRL1610,
                                     type_cred = PIRL1800,
                                     skill_gain_dummy = PIRL.3007,
                                     emp_status = PIRL400,
                                     edu_attain = PIRL408,
                                     training_dummy = PIRL1300,
                                     training_provider = PIRL1301,
                                     training_type = PIRL1303,
                                     skills_training1 = PIRL1306,
                                     skills_training2 = PIRL1310,
                                     skills_training3 = PIRL1316,
                                     sex = PIRL201,
                                     race = PIRL.3023)

#seeing how the occupational codes line up

View(d_smaller %>% select(occup_code, type_cred, training_dummy) %>% arrange(desc(occup_code)))
# ^^ okay, so the occupational codes do line up to the onet codes, but some of them do not give me
#search results while others do.

#d[d$PIRL1610 == 536021,]) seems like a lot of NAs
sum(is.na(d_smaller$occup_code) == FALSE)
#okay, so there are 247,888 observations that have occupational codes.  out of 20 million observations!

unique(d_smaller$training_type)

sum(is.na(d_smaller$training_type) == FALSE)
#there are 9 million observations that have values here!

training_type_bar <- ggplot(d_smaller, aes(training_type)) + geom_bar()

train <- d_smaller$training_type
train <- sort(train)
#names(train) <- c("none", "on the job", "skill upgrading", "entrepreneurial training", "ABE or ESL w other training",
#                  "customized training", "occupational skills training", "ABE or ESL not in conjunction w training",
#                  "prerequisite training", "registered apprenticeship", "youth occupational skills training",
#                  "non-occupational skills training", "job readiness training in conjunction w other training")

prop.table(table(train))
#most people have 0 training, and then a bit more have customized training.

