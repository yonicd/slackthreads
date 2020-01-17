
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

  - Slack API GET for
    [conversation.history](https://api.slack.com/methods/conversations.history)
  - Slack API GET for
    [conversation.replies](https://api.slack.com/methods/conversations.replies)
  - Pagination Methods for both

More to come ….

## Example Using [R4DS Slack](https://www.rfordatasci.com/)

``` r
library(slackteams)
library(threads)
```

### Load the Team

``` r
slackteams::load_teams()
#> The following teams are loaded:
#>   slackr, r4ds
slackteams::activate_team('r4ds')
#> slackr environment variables are set to 'r4ds' supplied definitions
```

### Retrieve Team Channels

``` r
chnls <- slackteams::get_team_channels()

 # r4ds has channels to ask questions in
question_channels <- sort(grep('^[1-9]',chnls$name[chnls$is_channel],value = TRUE))

question_channels
#> [1] "1_explore_wrangle"           "2_program"                  
#> [3] "3_model"                     "4_visualize_ggplot2_rmd_etc"
#> [5] "5_general_r_help"
```

### Retrieve Conversations

This will GET the first 20 messages from each channel

``` r

question_channels <- setNames(question_channels,question_channels)

convos <- lapply(question_channels,function(chnl){
  threads::get_conversations(limit = 20, channel = chnl)
})
```

Check that request was returned ok and that up to 20 were returned.

``` r
convos[[1]]$ok
#> [1] TRUE
length(convos[[1]]$messages)
#> [1] 20
```

### Pagination

We now use that initial object to retrieve the rest of the channel
messages using pagination

``` r
convo_paginate <- threads::paginate(convos[[1]],limit = 100)
```

This will return a list of requests where the first element in the root
request that returned 20 messages and the subsequent ones contain up to
100 messages

``` r
lapply(convo_paginate,function(x) length(x$messages))
#> [[1]]
#> [1] 20
#> 
#> [[2]]
#> [1] 100
#> 
#> [[3]]
#> [1] 64
```

### Messages Replies (Threads)

How many replies were there to this message

``` r
convos[[1]]$messages[[1]]$reply_count
#> [1] 1
```

Retrieve the reply.

The first element will be the parent message and the subsequent ones are
the messages in the
thread.

``` r
reply <- threads::get_replies(convos[[1]]$messages[[1]]$ts,channel = names(convos)[1])
```

Check that request was returned ok and how many messages where returned

``` r
reply$ok
#> [1] TRUE
length(reply$messages)
#> [1] 2
```
