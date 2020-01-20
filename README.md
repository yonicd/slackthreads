
<!-- README.md is generated from README.Rmd. Please edit that file -->

# threads

<!-- badges: start -->

[![Lifecycle:
experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://www.tidyverse.org/lifecycle/#experimental)
<!-- badges: end -->

The goal of threads is to interact with the Slack API to retrieve and
interrogate team conversations.

## Installation

``` r
remotes::install_github("yonicd/threads")
```

## In the Tin

  - httr call for Slack API
    [conversation.history](https://api.slack.com/methods/conversations.history)
  - httr call for Slack API
    [conversation.replies](https://api.slack.com/methods/conversations.replies)
  - Pagination Functions

## Example Using [R4DS Slack](https://www.rfordatasci.com/)

``` r
library(slackteams)
library(threads)
```

### Load the Team

``` r
slackteams::load_teams()
#> The following teams are loaded:
#>   r4ds
slackteams::activate_team('r4ds')
#> slackr environment variables are set to 'r4ds' supplied definitions
```

### Retrieve Team Channels

``` r
chnls <- slackteams::get_team_channels()

 # r4ds has channels to ask questions in
question_channels <- sort(
  grep('^[1-9]', chnls$name[chnls$is_channel], value = TRUE)
)

question_channels
#> [1] "1_explore_wrangle"           "2_program"                  
#> [3] "3_model"                     "4_visualize_ggplot2_rmd_etc"
#> [5] "5_general_r_help"            "6_github_open_source"       
#> [7] "7_spatial"                   "8_statistics"
```

### Retrieve Conversations

This will retrieve the last 20 messages from each channel

``` r

# question_channels <- setNames(question_channels, question_channels)

convos <- purrr::map_dfr(
  question_channels, ~threads::get_conversations(channel = .x, limit = 20)
) 
  
convos
#> # A tibble: 160 x 33
#>    channel type  text  user  ts    team  attachments blocks thread_ts
#>    <chr>   <chr> <chr> <chr> <chr> <chr> <list>      <list> <chr>    
#>  1 1_expl~ mess~ "I m~ UL5J~ 1577~ T6UC~ <list [1]>  <list~ 15771507~
#>  2 1_expl~ mess~ "I h~ U8LJ~ 1576~ <NA>  <???>       <list~ 15769154~
#>  3 1_expl~ mess~ "Doe~ UQWC~ 1576~ T6UC~ <???>       <list~ 15767605~
#>  4 1_expl~ mess~ "Can~ UKRF~ 1576~ <NA>  <???>       <???>  15766003~
#>  5 1_expl~ mess~ "I h~ U8LJ~ 1576~ T6UC~ <???>       <list~ 15764933~
#>  6 1_expl~ mess~ "I a~ U8LJ~ 1576~ <NA>  <???>       <list~ 15764162~
#>  7 1_expl~ mess~ "Any~ U8LJ~ 1576~ T6UC~ <???>       <list~ <NA>     
#>  8 1_expl~ mess~ "Hi ~ UNEL~ 1576~ T6UC~ <???>       <list~ <NA>     
#>  9 1_expl~ mess~ "<@U~ U8LJ~ 1576~ <NA>  <???>       <list~ 15692836~
#> 10 1_expl~ mess~ "Hey~ UL5J~ 1576~ T6UC~ <???>       <list~ 15761076~
#> # ... with 150 more rows, and 24 more variables: reply_count <int>,
#> #   reply_users_count <int>, latest_reply <chr>, reply_users <list>,
#> #   replies <list>, subscribed <lgl>, files <list>, upload <lgl>,
#> #   edited <list>, client_msg_id <chr>, reactions <list>, display_as_bot <lgl>,
#> #   parent_user_id <chr>, subtype <chr>, root <list>, hidden <lgl>,
#> #   last_read <chr>, username <chr>, icons <list>, bot_id <chr>,
#> #   old_name <chr>, name <chr>, bot_link <chr>, inviter <chr>
```

### Pagination

We are in the process of merging pagination into the `get_*` functions.

### Messages Replies (Threads)

How many replies were there to the first message?

``` r
convos$reply_count[[1]]
#> [1] 1
```

Retrieve that reply.

The first element will be the parent message and the subsequent ones are
the messages in the thread.

``` r
reply <- threads::get_replies(convos$ts[[1]], channel = convos$channel[[1]])
```

Check that request was returned ok and how many messages where returned

``` r
reply$ok
#> [1] TRUE
length(reply$messages)
#> [1] 2
```

## Contributing

Please note that the ‘threads’ project is released with a [Contributor
Code of Conduct](CODE_OF_CONDUCT.md). By contributing to this project,
you agree to abide by its terms.
