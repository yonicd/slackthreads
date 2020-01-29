library(slackteams)
library(slackcalls)
library(threads)
library(magrittr)
#library(ggplot2)

#source('data-raw/r4ds/tidy_convo.R')

## Set up Team ----

slackteams::load_team_dcf(team = 'r4ds')
slackteams::activate_team('r4ds')
#channels <- slackteams::get_team_channels()
convo <- threads::conversations(channel = '5_general_r_help',max_results = 350)

## Locate Mentors ----

users <- slackteams::get_team_users(fields = c('id','name','status_emoji'))
users$mentor <- users$status_emoji==':m:'
mentors <- users[users$mentor,]

## Locate Channels ----

chnls <- slackteams::get_team_channels()

question_channels <- sort(grep('^[1-9]',chnls$name[chnls$is_channel],value = TRUE))

question_channels <- c(question_channels,'statistics')

question_channels <- setNames(question_channels,question_channels)

## Read in Conversations ----

convos <- lapply(question_channels,function(chnl){
  threads::get_conversations(limit = 1000, channel = chnl)
})

## Response to Tibble ----

convos_tbl <- purrr::map_df(convos,tidy_convo,.id = 'channel')

# Clean out mentor non questions

convos_tbl <- convos_tbl%>%
  dplyr::filter(!(grepl('tidytuesday|office|questions',root_text,ignore.case = TRUE)&convos_tbl$root%in%mentors$id))

## Calendars

## Duration of Questions

### Dots

convos_tbl%>%
  dplyr::mutate(root_day = as.Date(root_date))%>%
  ggplot(aes(x=root_day,y=duration,colour = heavy_check_mark)) +
  geom_point() +
  facet_wrap(~channel,scales='free_y') +
  labs(x = 'Question Opened',
       y= ' Duration (days)')

### Smooth

convos_tbl%>%
  dplyr::select(channel,heavy_check_mark,ts_root,root_date,latest_reply_date,duration)%>%
  dplyr::mutate(
    latest_reply_date = dplyr::if_else(is.na(latest_reply_date),as.POSIXct(as.numeric(Sys.time()), origin="1970-01-01"),latest_reply_date),
    duration = lubridate::make_difftime(latest_reply_date-root_date,units = 'days'),
    date=as.Date(root_date)
  )%>%
  ggplot(aes(x=date,y=duration,colour=heavy_check_mark)) +
  geom_point(alpha=0.25) +
  geom_smooth(se=FALSE) +
  facet_wrap(~channel,scales = 'free_y')
