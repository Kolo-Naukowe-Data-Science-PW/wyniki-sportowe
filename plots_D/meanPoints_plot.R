library(dplyr)
library(reshape2)
library(ggplot2)
library(stringi)
library(plotly)

#wykres 2
#wykres wstÄ™gowy pokazujÄ…cy Ĺ›redniÄ… liczbÄ™ zdobytych punktĂłw w danym miesiÄ…cu przez druĹĽyny w zadanych sezonach
#
#
year = 2012
x2.host <- games_story %>%
  filter(season == year) %>%
  group_by(team_1_id, Month) %>%  
  summarise(Mean_Points = mean(as.numeric(team_1_score))) %>%
  mutate(freq=n()) %>%
  rename(Team = team_1_id)

x2.opp <- games_story %>%
  filter(season == year) %>%
  group_by(team_2_id, Month) %>%  
  summarise(Mean_Points = mean(as.numeric(team_2_score))) %>%
  mutate(freq=n()) %>%
  rename(Team = team_2_id)

x2 <- rbind(x2.host, x2.opp) %>%
  group_by(Team, Month) %>%
  summarise(Points = round(weighted.mean(Mean_Points, freq)))


f <- list(size = 20)

m <- list(
  l = 100,
  r = 100,
  b = 100,
  t = 100,
  pad = 4
)

y <- list(
  title = 'Month',
  titlefont = f
)

x <- list(
  title = 'Mean Points per Game',
  titlefont = f
)

p <- plot_ly(x2, y = ~Month, x = ~Points, type = "box", orientation = 'h') %>%
  layout(title = paste0('Mean points per game in season ',year,'<br>Month comparison'),
         font = f,
         xaxis = x,
         yaxis = y,
         margin = m)
p







# g1 <- ggplot(x2, aes(factor(Month) , Points)) +
#   geom_boxplot() +
#   xlab('Months') + ylab('Mean Points per Game') +
#   ggtitle(paste('Mean points per game in season',year, sep = " "))
# 
# ggplotly(g1)
