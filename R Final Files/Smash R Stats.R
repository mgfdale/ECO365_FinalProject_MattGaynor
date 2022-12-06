library(rvest)
library(tidyverse)

stats_list <- c("https://ultimateframedata.com/stats")

#USE A FULL JOIN TO COMBINE EACH INDIVIDUAL DATASET

#Air acceleration
grab_table <- function(url){
  out <- url %>% read_html %>% html_table
  out[[1]]
}
air_acceleration <- map_df(stats_list,grab_table)


#Change the out index to change what table is taken from the website
#Air speed
grab_table2 <- function(url){
  out <- url %>% read_html %>% html_table
  out[[2]]
}

air_speed <- map_df(stats_list,grab_table2)

#Fall Speed
grab_table3 <- function(url){
  out <- url %>% read_html %>% html_table
  out[[3]]
}
fall_speed <- map_df(stats_list,grab_table3)


#Gravity
grab_table4 <- function(url){
  out <- url %>% read_html %>% html_table
  out[[4]]
}
gravity <- map_df(stats_list,grab_table4)


#Jump Height
grab_table5 <- function(url){
  out <- url %>% read_html %>% html_table
  out[[5]]
}
jump_height <- map_df(stats_list,grab_table5)


#Jump Durations
grab_table6 <- function(url){
  out <- url %>% read_html %>% html_table
  out[[6]]
}
jump_duration <- map_df(stats_list,grab_table6)

#Weight
grab_table7 <- function(url){
  out <- url %>% read_html %>% html_table
  out[[7]]
}
weight <- map_df(stats_list,grab_table7)

#Landing
grab_table8 <- function(url){
  out <- url %>% read_html %>% html_table
  out[[8]]
}
landing <- map_df(stats_list,grab_table8)

#Walk speed
grab_table9 <- function(url){
  out <- url %>% read_html %>% html_table
  out[[9]]
}
walk_speed <- map_df(stats_list,grab_table9)

#Dash and Run speed
grab_table10 <- function(url){
  out <- url %>% read_html %>% html_table
  out[[10]]
}
dash_run_speed <- map_df(stats_list,grab_table10)

#Dash Turnaround
grab_table11 <- function(url){
  out <- url %>% read_html %>% html_table
  out[[11]]
}
dash_turnaround <- map_df(stats_list,grab_table11)

#Neutral Air Dodge
grab_table12 <- function(url){
  out <- url %>% read_html %>% html_table
  out[[12]]
}
neutral_air_dodge <- map_df(stats_list,grab_table12)

#backward roll
grab_table13 <- function(url){
  out <- url %>% read_html %>% html_table
  out[[13]]
}
backward_roll <- map_df(stats_list,grab_table13)


#Forward roll
grab_table14 <- function(url){
  out <- url %>% read_html %>% html_table
  out[[14]]
}
forward_roll <- map_df(stats_list,grab_table14)


#Spot Dodges
grab_table15 <- function(url){
  out <- url %>% read_html %>% html_table
  out[[15]]
}
spot_dodges <- map_df(stats_list,grab_table15)

#Grab range
grab_table16 <- function(url){
  out <- url %>% read_html %>% html_table
  out[[16]]
}
grab_range <- map_df(stats_list,grab_table16)

#Ledge stats
grab_table17 <- function(url){
  out <- url %>% read_html %>% html_table
  out[[17]]
}
ledge_stats <- map_df(stats_list,grab_table17)


#Reflectors
grab_table18 <- function(url){
  out <- url %>% read_html %>% html_table
  out[[18]]
}
reflectors <- map_df(stats_list,grab_table18)


#Out of shield
grab_table19 <- function(url){
  out <- url %>% read_html %>% html_table
  out[[19]]
}
out_of_shield <- map_df(stats_list,grab_table19)

#GO INTO EACH DATASET MANUALLY AND ADD _AIR_ACCELERATION AT THE TOTAL OR RANK COLUMNS TO AVOID CHANGING SUFFIXES
air_acceleration <- rename(air_acceleration, air_acceleration_rank = Rank)
air_acceleration <- rename(air_acceleration, air_acceleration_base = Base)
air_acceleration <- rename(air_acceleration, air_acceleration_additional = Additional)
air_acceleration <- rename(air_acceleration, air_acceleration_max = Max)
air_speed <- rename(air_speed, air_speed_rank = Rank)
backward_roll <- rename(backward_roll, backward_roll_rank = Rank)
backward_roll <- rename(backward_roll, backward_roll_total = Total)
backward_roll <- rename(backward_roll, backward_roll_note = Note)
backward_roll <- rename(backward_roll, backward_roll_start_up = Startup)
fall_speed <- rename(fall_speed, fall_speed_rank = Rank)
forward_roll <- rename(forward_roll, forward_roll_rank = Rank)
forward_roll <- rename(forward_roll, forward_roll_total = Total)
forward_roll <- rename(forward_roll, forward_roll_Notes = Notes)
forward_roll <- rename(forward_roll, forward_roll_start_up = Startup)
ledge_stats <- rename(ledge_stats, ledge_roll = Roll)
ledge_stats <- rename(ledge_stats, ledge_jump = Jump)
neutral_air_dodge <- rename(neutral_air_dodge, na_dodge_rank = Rank)
neutral_air_dodge <- rename(neutral_air_dodge, na_dodge_startup = Startup)
neutral_air_dodge <- rename(neutral_air_dodge, na_dodge_total = Total)
neutral_air_dodge <- rename(neutral_air_dodge, na_dodge_notes = Notes)
spot_dodges <- rename(spot_dodges, spot_dodges_rank = Rank)
spot_dodges <- rename(spot_dodges, spot_dodges_notes = Notes)
walk_speed <- rename(walk_speed, walk_speed_rank = Rank)


#Now join the datasets all together, you don't have to do suffixes


df <-full_join(air_acceleration,air_speed, by = c("Character"))

df2 <- full_join(df, backward_roll, by = c("Character"))

df3 <- full_join(df2,dash_run_speed, by = c("Character"))

df4 <- full_join(df3,dash_turnaround, by = c("Character"))

df5 <- full_join(df4,fall_speed, by = c("Character"))

df6 <- full_join(df5,forward_roll, by = c("Character"))

df7 <- full_join(df6,grab_range, by = c("Character"))

df8 <- full_join(df7,gravity, by = c("Character"))

df9 <- full_join(df8,jump_duration, by = c("Character"))

df10 <- full_join(df9,jump_height, by = c("Character"))

df11 <- full_join(df10,landing, by = c("Character"))

df12 <- full_join(df11,ledge_stats, by = c("Character"))

df13 <- full_join(df12,neutral_air_dodge, by = c("Character"))

df14 <- full_join(df13,out_of_shield, by = c("Character"))

df15 <- full_join(df14,reflectors, by = c("Character"))

df16 <- full_join(df15,spot_dodges, by = c("Character"))

df17 <- full_join(df16,walk_speed, by = c("Character"))

smash_df <- full_join(df17,weight, by = c("Character"))

write.csv(smash_df,"~/Desktop/smash_df.csv")












