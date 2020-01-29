library(dplyr)
library(ggraph)
library(tidygraph)
library(igraph)
library(patchwork)


g <- convos_tbl%>%
  dplyr::select(channel,root,ts_root,heavy_check_mark,replies,reply_count)%>%
  tidyr::unnest(cols = c(replies))%>%
  dplyr::left_join(users%>%dplyr::select(root=id,root_name=name),by='root')%>%
  dplyr::left_join(users%>%dplyr::select(user=id,user_name=name,user_mentor=mentor),by='user')%>%
  dplyr::select(from = root_name,to = user_name,from_time = ts_root,heavy_check_mark,reply_count,channel)%>%
  dplyr::mutate(
    from = glue::glue('{from}_{from_time}'),
    solved = factor(heavy_check_mark,labels = c('No','Yes')),
    to = dplyr::case_when(
      is.na(to)&heavy_check_mark~'self closed',
      is.na(to)&!heavy_check_mark~'orphan',
      TRUE ~ to
    )
  )%>%
  dplyr::distinct()%>%
  dplyr::group_by(channel,solved)%>%
  dplyr::group_split()%>%
  purrr::set_names(sort(glue::glue("{rep(question_channels,2)}_{rep(c('Not Solved','Solved'),each=6)}")))%>%
  purrr::map(.f=function(x){
    xg <- as_tbl_graph(x)
    V(xg)$mentor <- as.character(factor(V(xg)$name%in%mentors$name,labels = c('No','Yes')))
    V(xg)$mentor_name <- NA_character_
    V(xg)$mentor_name[V(xg)$name%in%c(mentors$name,'orphan','self closed')] <- V(xg)$name[V(xg)$name%in%c(mentors$name,'orphan','self closed')]
    xg
  })


graph_list <- purrr::map(g,.f=function(gi){
  ggraph(gi) +
    geom_edge_link(arrow = grid::arrow(length = unit(0.05, "inches")),alpha=0.5) +
    geom_node_point(aes(colour=mentor)) +
    geom_node_label(aes(label = mentor_name), repel = TRUE,size=3)
})%>%
  purrr::imap(.f=function(x,y) x + labs(subtitle=y))

graph_list_1 <- graph_list[grepl('explore_wrangle|visualize|model',names(graph_list))]

graph_list_1%>%
  purrr::reduce(`+`) + plot_layout(guides = 'collect',nrow=2)

graph_list_2 <- graph_list[!grepl('explore_wrangle|visualize|model',names(graph_list))]

graph_list_2%>%
  purrr::reduce(`+`) + plot_layout(guides = 'collect',nrow=2)
