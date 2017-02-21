library(dplyr)
library(reshape2)
library(ggmap)

#dopisanie konferencji
teams_names$Conference <- c("E", "E", "E", "E", "E",
                           "E", "W", "W", "E", "W",
                           "W", "E", "W", "W", "W",
                           "E", "E", "W", "W", "E",
                           "W", "E", "E", "W", "W",
                           "W", "W", "E", "W", "E")

#współrzędne miast
teams_names$City <- c("Atlanta",
                     "Boston",
                     "Brooklyn",
                     "Charlotte",
                     "Chicago",
                     "Cleveland",
                     "Dalls",
                     "Denver",
                     "Detroit",
                     "Oakland",
                     "Houston",
                     "Indiana",
                     "Los Angeles",
                     "Los Angeles",
                     "Memphis",
                     "Miami",
                     "Milwaukee",
                     "Minnesota",
                     "New Orleans",
                     "New York",
                     "Oklahoma City",
                     "Orlando",
                     "Philadelphia",
                     "Phoenix",
                     "Portland",
                     "Sacramento",
                     "San Antonio",
                     "Toronto",
                     "Utah",
                     "Washington")

for (i in 1:nrow(teams_names)) {
  tmp <- as.numeric(geocode(teams_names$City[i]))
  teams_names$lon[i] <- tmp[1]
  teams_names$lat[i] <- tmp[2]
}
#teams_names$City[14] <- "Los Angeles 2"
#teams_names$lon[14] <- teams_names$lon[14] + 0.05
#teams_names$lat[14] <- teams_names$lat[14] + 0.05

#dopisanie miejsca w konferencji w sezonie zasadniczy
teams_seasons_statistics$Possition<-c(5,6,8,8,4,5,
                        4,7,12,7,5,3,
                        12,4,5,8,14,15,
                        15,14,7,11,6,4,
                        1,5,3,3,9,7,
                        13,13,10,2,1,1,
                        7,10,8,7,6,13,
                        6,3,11,12,10,10,
                        10,11,11,12,8,11,
                        13,6,6,1,1,1,
                        9,8,4,2,8,3,
                        3,3,1,9,7,7,
                        5,4,3,2,4,4,
                        3,7,14,14,15,12,
                        4,5,7,5,7,7,
                        2,1,1,10,3,13,
                        9,8,15,6,12,6,
                        12,12,10,15,13,13,
                        15,14,12,8,12,11,
                        7,2,9,15,13,10,
                        2,1,2,9,3,6,
                        6,15,13,13,11,11,
                        8,9,14,14,15,14,
                        10,15,9,10,14,15,
                        11,11,4,9,5,9,
                        14,13,13,13,10,8,
                        1,2,1,5,2,2,
                        11,10,3,4,2,2,
                        8,9,15,11,9,5,
                        14,12,5,5,10,9)

#dodanie miesięcy do games_story
string  <- as.character(games_story$game_date)
split <- strsplit(string, "-")
for (i in 1:length(split)) {
  games_story$Month[i] = split[[i]][2]
}
games_story$Month <- month.abb[as.integer(games_story$Month)]
games_story$Month <- factor(games_story$Month, levels = c("Oct", "Nov", "Dec", "Jan", "Feb", "Mar", "Apr"), ordered = TRUE)