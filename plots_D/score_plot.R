library(dplyr)
library(reshape2)
library(ggplot2)
library(stringi)
library(plotly)

year = 2014

season_score <- teams_seasons_statistics %>%
  full_join(teams_names, by = c("team_id" = "id")) %>%
  filter(season == year) %>%
  select(team_id, total_2ps, total_3ps, Possition, Conference) %>%
  arrange(desc(Conference), Possition)

teams_levels <- as.character(season_score$team_id)
season_score$team_id <- factor(season_score$team_id, levels = teams_levels, ordered = TRUE)

season_score_W <- season_score %>%
  filter(Conference == 'W')

season_score_E <- season_score %>%
  filter(Conference == 'E')





f <- list(size = 18)

m <- list(
  l = 100,
  r = 100,
  b = 100,
  t = 100,
  pad = 4
)

y <- list(
  title = 'Points',
  titlefont = f
)

x <- list(
  #title = 'Months',
  tickangle = 60,
  titlefont = f
)

pW <- plot_ly(season_score_W, x = ~team_id, y = ~total_3ps, type = 'bar', name = '3pts, W', marker=list(color='#7b3294')) %>%
  add_trace(y = ~total_2ps , name = '2pts, W', marker=list(color="#c2a5cf")) %>%
  layout(barmode = 'stack',
         xaxis = x)

pE <- plot_ly(season_score_E, x = ~team_id, y = ~total_3ps, type = 'bar', name = '3pts, E', marker=list(color='#008837')) %>%
  add_trace(y = ~total_2ps , name = '2pts, E', marker=list(color='#a6dba0')) %>%
  layout(barmode = 'stack',
         xaxis = x)

subplot(pW, pE, shareY = TRUE) %>%
  layout(title = paste0('3P and 2P in ',year,' season<br>Cummulative plot'),
         #xaxis = list(title = 'Teams'),
         font = f,
         yaxis = y,
         margin = m)

#---------------------------
#plotly war
#---------------------------

# p <- plot_ly(season_score, y = ~team_id, x = ~total_3ps, type = 'bar', name = '3 Points Shots Score', orientation = 'h',
#              marker = list(color = 
#                              c('#006C9A', '#006C9A', '#006C9A', '#006C9A', '#006C9A',
#                                '#006C9A', '#006C9A', '#006C9A', '#006C9A', '#006C9A',
#                                '#006C9A', '#006C9A', '#006C9A', '#006C9A', '#006C9A',
#                                '#00BEBE', '#00BEBE', '#00BEBE', '#00BEBE', '#00BEBE',
#                                '#00BEBE', '#00BEBE', '#00BEBE', '#00BEBE', '#00BEBE',
#                                '#00BEBE', '#00BEBE', '#00BEBE', '#00BEBE', '#00BEBE'))) %>%
#   add_trace(x = ~total_2ps , name = '2 Points Shots Score',
#             marker = list(color = c(	'#00F3E4', '#00F3E4', '#00F3E4', '#00F3E4', '#00F3E4',
#                                      '#00F3E4', '#00F3E4', '#00F3E4', '#00F3E4', '#00F3E4',
#                                      '#00F3E4', '#00F3E4', '#00F3E4', '#00F3E4', '#00F3E4',
#                                      '#9FF9C1', '#9FF9C1', '#9FF9C1', '#9FF9C1', '#9FF9C1',
#                                      '#9FF9C1', '#9FF9C1', '#9FF9C1', '#9FF9C1', '#9FF9C1',
#                                      '#9FF9C1', '#9FF9C1', '#9FF9C1', '#9FF9C1', '#9FF9C1'))) %>%
#   layout(title = paste0('3P and 2P in ',year,' season'),
#          xaxis = list(title = 'Teams'),
#          yaxis = list(title = 'Points'),
#          barmode = 'stack')
# p



#wykres 1
#iloĹ›Ä‡ zdobytych punktĂłw za dwa i trzy w sezonie zasadniczym z podziaĹ‚em na konferencje
#
#przygotowanie tabeli
  # season_score <- teams_seasons_statistics %>%
  #   full_join(teams_names, by = c("team_id" = "id")) %>%
  #   filter(season == year) %>%
  #   select(team_id, total_2ps, total_3ps, Possition, Conference) %>%
  #   #mutate(total_2ps = total_2ps + total_3ps) %>%
  #   arrange(desc(Conference), Possition) %>%
  #   rename(`Total Score` = total_2ps, `3 Points Shots Score` = total_3ps, Team = team_id)
  # 
  # teams_levels <- as.character(season_score$Team)
  # 
  # season_score<-melt(season_score,id.vars=c("Team", "Possition", "Conference")) %>%
  #   arrange(desc(variable)) %>%
  #   mutate(value = as.numeric(as.character(value))) %>%
  #   rename(Points = value, `Points Type` = variable)
  # type_levels <- c("3 Points Shots Score", "Total Score")
  # 
  # season_score$Team <- factor(season_score$Team, levels = teams_levels, ordered = TRUE)
  # season_score$`Points Type` <- factor(season_score$`Points Type`, levels = type_levels, ordered = TRUE)
  # 
  # #tworzenie wykresĂłW
  # plot <- ggplot(season_score, aes(x=Team, y=Points, fill=`Points Type`, alpha=Conference)) +
  #   geom_bar(stat="identity", colour="black") + 
  #   scale_alpha_manual(values=c(0.4, 1)) +
  #   ggtitle(paste0('3P and 2P in ',year,' season')) +
  #   xlab('Teams') + ylab('Points') +
  #   #theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
  #   coord_flip()
  # #plot
  # ggplotly(plot)