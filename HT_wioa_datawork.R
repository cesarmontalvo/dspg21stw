#Haleigh Tomlin
#exploring WIOA data
#6/16/21

#install.packages("tidyverse")
library(tidyverse)

#importing the data
d <- read.csv("PY2019Q4.csv")

#occupational codes
length(unique(d$PIRL1610))
unique(d$PIRL1610)

#d[d$PIRL1610 == 536021,]) seems like a lot of NAs
sum(is.na(d$PIRL1610) == FALSE)
#okay, so there are 247,888 observations that have occupational codes.  out of 20 million observations!

#using the wioa data dictionary 
  #data in four quarters,

dim(d) #21203183  308
length(unique(d$PIRL100)) #12896358

#with codes:
d_codes <- d[is.na(d$PIRL610) == FALSE,]

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


#d <- d %>% select() %>% mutate()

head(d)
