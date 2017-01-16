
#chapter 1 Datacamp - Intro to R
#DATATYPES
my_apples <- 5
my_banana <- 10
my_apples+my_banana

#numerics (4.5), integer(4), logical(T,F), character ('abc')
my_numeric <- 42
my_character <- "universe"
my_logical <- FALSE
class(my_numeric)
class(my_character)
class(my_logical)

#VECTOR
nv <- c(1,2,3)
class(nv)
boolean_vector <- c(TRUE, FALSE, TRUE)
class(boolean_vector)
poker_vector <- c(140, -50, 20, -120, 240)

# for assigning column names
names(poker_vector) <- c("Monday", "Tuesday", "Wednesday", "Thursday", "Friday")
poker_vector
days_vector <- c("Monday", "Tuesday", "Wednesday", "Thursday", "Friday")
poker_vector <- c(140, -50, 20, -120, 240)
names(poker_vector) <- days_vector
poker_vector


# maths operations on vetor
A_vector <- c(1, 2, 3)
B_vector <- c(4, 5, 6)
total_vector <- A_vector + B_vector
total_vector #summing the 2 vectors element by element
poker_vector <- c(140, -50, 20, -120, 240)
sum(poker_vector) #summing all the elements

#comparing vectors
poker_vector <- c(140, -50, 20, -120, 240)
roulette_vector <- c(-24, -50, 100, -350, 10)
poker_vector >roulette_vector

#accessing the elements of the vector
poker_vector <- c(140, -50, 20, -120, 240)
poker_vector[3] #elements start from 1
poker_vector[c(2,3,4)]
poker_vector[1:3]
mean(poker_vector)

#selection by comparison
# Poker and roulette winnings from Monday to Friday:
poker_vector <- c(140, -50, 20, -120, 240)
roulette_vector <- c(-24, -50, 100, -350, 10)
days_vector <- c("Monday", "Tuesday", "Wednesday", "Thursday", "Friday")
names(poker_vector) <- days_vector
names(roulette_vector) <- days_vector

# Which days did you make money on poker?
selection_vector <- poker_vector > 0

# Print out selection_vector
selection_vector

#MATRIX
matrix(1:9, byrow = TRUE, nrow = 3)
new_hope <- c(460.998, 314.4)
empire_strikes <- c(290.475, 247.900)
return_jedi <- c(309.306, 165.8)
box_office <- c(new_hope,empire_strikes,return_jedi)
star_wars_matrix <- matrix(box_office, nrow =  3, byrow=3)
star_wars_matrix

#adding column names in the matrix
region <- c("US", "non-US")
colnames(star_wars_matrix) <- region

#adding a row in the matrix
all_wars_matrix <- rbind(star_wars_matrix, star_wars_matrix2) # star_wars_matrix2 not created

#operation on matrix
colSums(star_wars_matrix)


#selection of a matrix element
# all_wars_matrix is available in your workspace
star_wars_matrix
# Select the non-US revenue for all movies
non_us_all <- star_wars_matrix[,2]
# Average non-US revenue
mean(non_us_all)
# Select the non-US revenue for first two movies
non_us_some <- star_wars_matrix[1:2,2]
# Average non-US revenue for first two movies
mean(non_us_some)
#Operation on matrix
star_wars_matrix/5


#FACTORS
gender <- c("male","female")
gender <- as.factor(gender)
class(gender)
gender
temperature_vector <- c("High", "Low", "High","Low", "Medium")
factor_temperature_vector <- factor(temperature_vector, order = TRUE, levels = c("Low", "Medium", "High"))

#Factor levels
survey_vector <- c("M", "F", "F", "M", "M")
factor_survey_vector <- factor(survey_vector) 
levels(factor_survey_vector) <- c("female", "male")

#summarizing a factor
summary(factor_survey_vector)

#ordered factor
speed_vector <- c("fast", "slow", "slow", "fast", "insane")
factor_speed_vector <- factor(speed_vector, ordered = TRUE, levels = c("slow", "fast", "insane"))
summary(factor_speed_vector)


speed_vector[2] >speed_vector[4]


#DATAFRAMES
mtcars
head(mtcars)
str(mtcars)

#Creating a dataframe
name <- c("Mercury", "Venus", "Earth", "Mars", "Jupiter", "Saturn", "Uranus", "Neptune")
type <- c("Terrestrial planet", "Terrestrial planet", "Terrestrial planet", 
          "Terrestrial planet", "Gas giant", "Gas giant", "Gas giant", "Gas giant")
diameter <- c(0.382, 0.949, 1, 0.532, 11.209, 9.449, 4.007, 3.883)
rotation <- c(58.64, -243.02, 1, 1.03, 0.41, 0.43, -0.72, 0.67)
rings <- c(FALSE, FALSE, FALSE, FALSE, TRUE, TRUE, TRUE, TRUE)
myframe<- data.frame(name,type,diameter,rotation,rings)
str(myframe)
myframe[4,]
myframe[1:4,3]
myframe[1,3]
myframe[1:5, "diameter"]
myframe[rings,]

#using function
subset(myframe,diameter<1)
ordered<-order(myframe$diameter)
myframe[ordered, ]


#LISTS

#review again

#---------------------------------------------------------------------------------------

#Intermdeiate R

#Relational operator
linkedin <- c(16, 9, 13, 5, 2, 17, 14)
facebook <- c(17, 7, 5, 16, 8, 13, 14)
linkedin >10
views <- matrix(c(linkedin,facebook),nrow = 2,byrow = T)
views==13
last <- tail(linkedin, 1)
last < 5 | last >10
x <- 5
y <- 7
(!(x < 4) & !(y > 12))

#Conditional statements
li <- 5
lo <- 10
if (li >= 15 & fb >= 15) {
  sms <- 2 * (li + fb)
} else if (li < 10 & fb < 10) {
  sms <- 0.5 * (li + fb)
} else {
  sms <- li + fb
}
sms

#loops

i <- 1
while (i<=10) {
    print (3*i)
    if(3*i %% 8 ==0) {
      break
    }
    i=i+1
}

primes <- c(2, 3, 5, 7, 11, 13)
# loop version 1
for (p in primes) {
  print(p)
}
# loop version 2
for (i in 1:length(primes)) {
  print(primes[i])
}

# define the double for loop
for (i in 1:nrow(ttt)) {
  for (j in 1:ncol(ttt)) {
    print(paste("On row", i, "and column", j, "the board contains", ttt[i,j]))
  }
}
# Add if statement with break
if (li > 16) {
  print("This is ridiculous, I'm outta here!")
  break
}

# Add if statement with next
if (li < 5) {
  print("This is too embarrassing!")
  next
}
print(li)
}

#loop example -  
#Can you write code that counts the number of r's that come before the first u in rquote?
rquote <- "r's internals are irrefutably intriguing"
chars <- strsplit(rquote,split = "")[[1]]
chars
count <- 0
for (char in chars) {
  if (char == 'r')
  {
    count <- count+1
  }
  if (char == 'u')
  break
}
count

#FUNCTIONS

#to know the arguments of a fucntion
args(sd)
args(strsplit)
help("sample")
args(sample)
args(read.table)

# Creating own functions
pow_two <- function(x, print_info = TRUE) {
    y <- x^2
    if (print_info) {
        print(paste(x,"to the power 2 equals", y))
    }
     return(y) 
    
}

#passing by valaue concept in R explained
triple <- function(x) {
  x <- 3*x
  x
}
a <- 5
triple(a)
a #the value of a will NOT get overwritten unless we explicitly assign

# Example of function using control strus and looping
linkedin <- c(16, 9, 13, 5, 2, 17, 14)
facebook <- c(17, 7, 5, 16, 8, 13, 14)

interpret <- function(num_views) {
    if(num_views >15){
    print('you are popular')
    return(num_views)} 
  else {
      print('try to be more popular')
      return(0)
}
}   

interpret_all <- function(views,return_sum =TRUE) {
  count <- 0  
  for (v in views) {
        count <- count+interpret(v)
  }
  if(return_sum) {
      return(count)
  }
  else return(NULL)
}

#other things
#search function in R
search() #current workspace
#require fucntion instead of library


#THE APPLY FAMILY

#LAPPlY - Outputs a list
args(lapply)
lapply(linkedin,triple)
unlist(lapply(linkedin,triple)) # triple's arguments can be specified after the comma
# Definition of split_low
pioneers <- c("GAUSS:1777", "BAYES:1702", "PASCAL:1623", "PEARSON:1857")
split <- strsplit(pioneers, split = ":")
split_low <- lapply(split, tolower)
# Transform: use anonymous function inside lapply
names <- lapply(split_low, function(x) { x[1] })
# Transform: use anonymous function inside lapply
years <- lapply(split_low, function(x) { x[2] })
lapply(list(1, "a", TRUE), str) #Read agian regarding returning NULL

#SAPPLY (simplify apply) - Returns an array

args(runif)

#VAPPLY
#check again

#R functions
linkedin <- list(16, 9, 13, 5, 2, 17, 14)
facebook <- list(17, 7, 5, 16, 8, 13, 14)
li_vec <- unlist(linkedin)
fb_vec <- unlist(facebook)
social_vec <- append(li_vec, fb_vec)
sort(social_vec, decreasing = TRUE)

#Regular expressions
#grep grepl sub gsub


#________________________________________________________________________________________
emails <- c("john.doe@ivyleague.edu", "education@world.gov", "dalai.lama@peace.org", 
            "invalid.edu", "quant@bigdatacollege.edu", "cookie.monster@sesame.tv")

# Use grepl() to match for "edu"
grepl("edu", emails)
# Use grep() to match for "edu", save result to hits
hits <- grep("edu", emails)
# Subset emails using hits
emails[hits]


#_______________________________________________________________________________________


#CLEANING DATA IN R

dim(mtcars)
head(mtcars)
names(mtcars)
str(mtcars)
summary(mtcars)

library(dplyr)
glimpse(mtcars)
library(tidyr)
separate(mtcars,mpg, c("old", "new") , sep =".")
## sales5 is pre-loaded
# Load stringr
library(stringr)
# Find columns of sales5 containing "dt": date_cols
date_cols <- str_detect(names(sales5), "dt")
# Load lubridate
library(lubridate)
# Coerce date columns into Date objects
sales5[, date_cols] <- lapply(sales5[, date_cols], ymd)
sales6 <- unite(sales5, venue_city_state, 
                venue_city, venue_state, sep = ", ")

#to convert column data to row data
mbta4 <- gather(mbta2, month, thou_riders, -mode)
str(mbta4)
#type conversion
mbta4$thou_riders <- as.numeric(mbta4$thou_riders)
#Converting key value pairs from gather to proper row data
mbta5 <- spread(mbta4, mode, thou_riders)
mbta6 <- separate(mbta5, month, c("year", "month"))

#imputing single incorrect values
i <- which(mbta6$Boat > 30)
i
mbta6$Boat[i] <- 4
ggplot(mbta_boat, aes(x = month, y = thou_riders, col = mode)) +  geom_point() + 
  scale_x_discrete(name = "Month", breaks = c(200701, 200801, 200901, 201001, 201101)) + 
  scale_y_continuous(name = "Avg Weekday Ridership (thousands)")

#-------------------------------------------------------------------------------

#Data manipulation in R dplyr
library(dplyr)
library(hflights)
head(hflights)
summary(hflights)
str(hflights)
tail(hflights)
#tbl data type
glimpse(hflights)
hflights

#SELECT, FILTER, ARRANGE, MUTATE, SUMMARIZE

select(hflights,ActualElapsedTime,AirTime, ArrDelay, DepDelay)
select(hflights, Year:AirTime)
select(hflights,-(Year:AirTime))
select(hflights, ends_with("Delay"))
select(hflights, UniqueCarrier, ends_with("Num"), starts_with("Cancel"))
select(hflights, contains("Tim"), contains("Del"))


g1 <- mutate(hflights, ActualGroundTime = ActualElapsedTime - AirTime)
g3 <- mutate(g2, AverageSpeed = Distance / AirTime * 60)
m2 <- mutate(hflights, TotalTaxi = TaxiIn + TaxiOut, 
             ActualGroundTime = ActualElapsedTime - AirTime,
             Diff = TotalTaxi - ActualGroundTime)

new<- dplyr::filter(hflights,hflights$Cancelled==1)
filter(hflights, UniqueCarrier %in% c("JetBlue", "Southwest", "Delta"))
filter(hflights, TaxiIn + TaxiOut > AirTime)

c1 <- filter(hflights, Dest == "JFK")
c2 <- mutate(c1, Date = paste(Year, Month, DayofMonth, sep = "-"))
select(c2, Date, DepTime, ArrTime, TailNum)
dtc <- filter(hflights, Cancelled == 1, !is.na(DepDelay))
arrange(dtc, UniqueCarrier, DepDelay)
arrange(hflights, UniqueCarrier, desc(DepDelay))
arrange(hflights, DepDelay + ArrDelay)

summarise(hflights, min_dist = min(Distance), max_dist = max(Distance))
summarise(filter(hflights, Diverted == 1), max_div = max(Distance))
temp2 <- filter(hflights, !is.na(TaxiIn), !is.na(TaxiOut))
summarise(temp2, max_taxi_diff = max(abs(TaxiIn - TaxiOut)))
summarise(hflights, 
          n_obs = n(), 
          n_carrier = n_distinct(UniqueCarrier), 
          n_dest = n_distinct(Dest))
summarise(aa, 
          n_flights = n(), 
          n_canc = sum(Cancelled == 1),
          avg_delay = mean(ArrDelay, na.rm = TRUE))

# Write the 'piped' version of the English sentences.
hflights %>%
  mutate(diff = TaxiOut - TaxiIn) %>%
  filter(!is.na(diff)) %>%
  summarise(avg = mean(diff))

hflights %>%
  mutate(RealTime = ActualElapsedTime + 100, mph = Distance / RealTime * 60) %>%
  filter(!is.na(mph), mph < 70) %>%
  summarise(n_less = n(), 
            n_dest = n_distinct(Dest), 
            min_dist = min(Distance), 
            max_dist = max(Distance))

hflights %>%
  filter(!is.na(DepTime), !is.na(ArrTime), DepTime > ArrTime) %>%
summarise(num = n())


hflights %>%
  group_by(UniqueCarrier) %>%
  summarise(time = mean(ArrDelay, na.rm = TRUE), count = n())%>%
  arrange (desc(time))

# Ordered overview of average arrival delays per carrier
hflights %>%
  filter(!is.na(ArrDelay), ArrDelay > 0) %>%
  group_by(UniqueCarrier) %>%
  summarise(avg = mean(ArrDelay)) %>%
  mutate(rank = rank(avg)) %>%
  arrange(rank)

# How many airplanes only flew to one destination?
hflights %>%
  group_by(TailNum) %>%
  summarise(ndest = n_distinct(Dest)) %>%
  filter(ndest == 1) %>%
  summarise(nplanes = n())

# Find the most visited destination for each carrier
hflights %>% 
  group_by(UniqueCarrier, Dest) %>%
  summarise(n = n()) %>%
  mutate(rank = rank(desc(n))) %>%
  filter(rank == 1)


my_db <- src_mysql(dbname = "dplyr", 
                   host = "courses.csrrinzqubik.us-east-1.rds.amazonaws.com", 
                   port = 3306, 
                   user = "student",
                   password = "datacamp")
nycflights <- tbl(my_db, "dplyr")
glimpse(nycflights)
nycflights %>%
  group_by(carrier) %>%
  summarise(n_flights = n(), avg_delay = mean(arr_delay)) %>%
  arrange(avg_delay)



#JOINING DATASETS USING DPLYR
bands2 <- left_join(bands, artists, by = c("first", "last"))
right_join()
inner_join()
full_join
# Find guitarists in bands dataset (don't change)
temp <- left_join(bands, artists, by = c("first", "last"))
temp <- filter(temp, instrument == "Guitar")
select(temp, first, last, band)
# Reproduce code above using pipes
bands %>% 
  left_join(artists, by = c("first", "last")) %>% 
  filter(instrument == "Guitar") %>% 
  select(first, last, band)

#setequal(goal, goal2)  - to compare 2 tables
semi_join() # its called as filtering join and helps have a quick look on what rows are matching
anti_join() #does opposite of semi_join

#combining rows
union()
intersect()
setdiff()

# for cases which exist in 1 table but not in both

# Select songs from live and greatest_hits
live_songs <- live %>% select(song)
greatest_songs <- greatest_hits %>% select(song)
# Return the songs that only exist in one dataset
all_songs <- live_songs %>% union(greatest_songs)
common_songs <- live_songs %>% intersect(greatest_songs)
all_songs %>% setdiff(common_songs)

#comparing datasets
setequal(tabel1, table2) #to compare 2 datasets irrespetive of the order


#Assembling data
bind_rows ()
bind_cols ()
#.id function review online
data_frame
as_data_frame()

#advance join
rownames_to_column

#combining multiple tables  - best way is to use purrr package functiion reduce()


#PRACTICE
install.packages("Lahman")
library(Lahman)
Lahman::LahmanData
Lahman::Salaries
distinct(Salaries)
players <- Master %>% 
  # Return the columns playerID, nameFirst and nameLast
  select(playerID, nameFirst, nameLast) %>% 
  # Return one row for each distinct player
  distinct()

players %>% 
  # Find all players who do not appear in Salaries
  anti_join(Salaries, by = "playerID") %>%
  # Count them
  count()

players %>% 
  anti_join(Salaries, by = "playerID") %>% 
  # How many unsalaried players appear in Appearances?
  semi_join(Appearances, by = "playerID") %>% 
  count()

players %>% 
  # Find all players who do not appear in Salaries
  anti_join(Salaries, by = "playerID") %>% 
  # Join them to Appearances
  left_join(Appearances, by = "playerID") %>%
  # Calculate total_games for each player
  group_by(playerID) %>% 
  summarize(total_games = sum(G_all, na.rm = TRUE)) %>%
  # Arrange in descending order by total_games
  arrange(desc(total_games))

View(HallOfFame)

nominated <-  HallOfFame %>%
              select(playerID)   %>%          
              distinct(playerID)

count(nominated)

inducted <- HallOfFame %>% 
  filter(inducted == "Y") %>% 
  select(playerID) %>% 
  distinct()

nominated_full <- nominated %>%
                  left_join(Master, by ="playerID") %>%
                  select(playerID, nameFirst,nameLast)

# Tally the number of awards in AwardsPlayers by playerID
nAwards <- AwardsPlayers %>% 
  group_by(playerID) %>% 
  tally()
nAwards %>% 
  # Filter to just the players in inducted 
  semi_join(inducted, by = "playerID") %>% 
  # Calculate the mean number of awards per player
  summarize(avg_n = mean(n, na.rm = TRUE))


nAwards %>% 
  # Filter to just the players in nominated 
  semi_join(nominated, by = "playerID") %>%
  # Filter to players NOT in inducted 
  anti_join(inducted, by = "playerID") %>%
  # Calculate the mean number of awards per player
  summarize(avg_n = mean(n, na.rm = TRUE))

# Find the players who are in nominated, but not inducted
notInducted <- nominated %>% 
  setdiff(inducted)

Salaries %>% 
  # Find the players who are in notInducted
  semi_join(notInducted, by = "playerID") %>%
  # Calculate the max salary by player
  group_by(playerID) %>% 
  summarize(max_salary = max(salary, na.rm = TRUE)) %>% 
  # Calculate the average of the max salaries
  summarize(avg_salary = mean(max_salary, na.rm = TRUE))

# Repeat for players who were inducted
Salaries %>% 
  semi_join(inducted, by = "playerID") %>% 
  group_by(playerID) %>% 
  summarize(max_salary = max(salary, na.rm = TRUE)) %>% 
  summarize(avg_salary = mean(max_salary, na.rm = TRUE))


Appearances %>% 
  # Filter Appearances against nominated
  semi_join(nominated, by = "playerID") %>% 
  # Find last year played by player
  group_by(playerID) %>% 
  summarize(last_year = max(yearID)) %>% 
  # Join to full HallOfFame
  left_join(HallOfFame, by = "playerID") %>% 
  # Filter for unusual observations
  filter(last_year >= yearID)

#_________________________________________________________________________

#data.table

library(data.table)
my_first_data_table <- data.table(x = c("a", "b", "c", "d", "e"), 
                                  y = c(1, 2, 3, 4, 5))  
# Create a data.table using recycling
DT <- data.table(a = c(1L, 2L), b = LETTERS[1:4])
DT[3]
DT[2:3]
DT[.N]
DT[.N-1]
dim(DT)
