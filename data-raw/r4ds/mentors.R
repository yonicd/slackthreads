
mentors_tbl <- convos_tbl%>%
  dplyr::select(channel,root,ts_root,root_date,heavy_check_mark,replies,reply_count)%>%
  tidyr::unnest(cols = c(replies))%>%
  dplyr::left_join(users%>%dplyr::select(root=id,root_name=name,root_mentor=mentor),by='root')%>%
  dplyr::left_join(users%>%dplyr::select(user=id,user_name=name,user_mentor=mentor),by='user')%>%
  dplyr::mutate(
    root_month = strftime(root_date,'%Y/%m'),
    reply_month = strftime(reply_date,'%Y/%m')
    )

calc_month <- function(data,lag){

  d <- Sys.Date() - months(lag)

  data%>%
    dplyr::filter(user_mentor)%>%
    dplyr::count(reply_month,channel,user_name,name = sprintf('total_%s',strftime(d,'%Y/%m')))%>%
    dplyr::filter(reply_month==strftime(d,'%Y/%m'))%>%
    dplyr::select(-reply_month)
}

calc_month_checkmark <- function(data,lag){

  d <- Sys.Date() - months(lag)

  data%>%
    dplyr::filter(user_mentor&heavy_check_mark)%>%
    dplyr::count(reply_month,channel,user_name,name = sprintf('checkmark_%s',strftime(d,'%Y/%m')))%>%
    dplyr::filter(reply_month==strftime(d,'%Y/%m'))%>%
    dplyr::select(-reply_month)
}

reply_total <- purrr::map(c(6,1,0),calc_month,data = mentors_tbl)%>%
  purrr::reduce(dplyr::full_join, by = c("channel", "user_name"))

reply_checkmark <- purrr::map(c(6,1,0),calc_month_checkmark,data = mentors_tbl)%>%
  purrr::reduce(dplyr::full_join, by = c("channel", "user_name"))

dashboard <- mentors_tbl%>%
  dplyr::filter(user_mentor)%>%
  dplyr::group_by(channel,user_name)%>%
  dplyr::summarise(last_interaction = max(reply_date))%>%
  dplyr::arrange(dplyr::desc(last_interaction))%>%
  dplyr::ungroup()%>%
  dplyr::left_join(reply_total, by = c("channel", "user_name"))%>%
  dplyr::left_join(reply_checkmark, by = c("channel", "user_name"))

dashboard <- dashboard%>%
  dplyr::mutate_at(
    dplyr::vars(!!!rlang::syms(names(dashboard)[-c(1:3)])),
    list(function(x) ifelse(is.na(x),0,x)))


## Channel/Reply Date Facet by Mentor

mentors_tbl%>%
  dplyr::filter(user_mentor)%>%
  ggplot(aes(x=reply_date,y=channel)) +
  geom_point() +
  facet_wrap(~user_name)

## Mentor/Reply Date Facet by Channel

mentors_tbl%>%
  dplyr::filter(user_mentor)%>%
  ggplot(aes(x=reply_date,y=user_name)) +
  geom_point() +
  facet_wrap(~channel)

## Last Interaction

mentors_tbl%>%
  dplyr::filter(user_mentor)%>%
  dplyr::mutate(reply_month = strftime(reply_date,'%m/%Y'))%>%
  dplyr::group_by(channel,user_name)%>%
  dplyr::summarise(
    n = n(),
    last_interaction = max(reply_date)
  )%>%
  ggplot(aes(x=last_interaction,y=user_name)) +
  geom_point() +
  facet_wrap(~channel)
