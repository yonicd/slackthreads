
<!-- README.md is generated from README.Rmd. Please edit that file -->

# threads

<!-- badges: start -->

[![Lifecycle:
experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://www.tidyverse.org/lifecycle/#experimental)
[![R-win build
status](https://github.com/yonicd/threads/workflows/R-win/badge.svg)](https://github.com/yonicd/threads)
[![R-mac build
status](https://github.com/yonicd/threads/workflows/R-mac/badge.svg)](https://github.com/yonicd/threads)
[![R-linux build
status](https://github.com/yonicd/threads/workflows/R-linux/badge.svg)](https://github.com/yonicd/threads)
[![Codecov test
coverage](https://codecov.io/gh/yonicd/threads/branch/master/graph/badge.svg)](https://codecov.io/gh/yonicd/threads?branch=master)
<!-- badges: end -->

The goal of threads is to interact with the Slack API to retrieve and
interrogate team conversations.

## Installation

``` r
remotes::install_github("yonicd/threads")
```

## In the Tin

  - Fetch messages from conversations
  - Fetch replies in threads to the messages in the conversations

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
#> [5] "5_general_r_help"            "6_github_open_source"       
#> [7] "7_spatial"                   "8_statistics"
```

### Retrieve Conversations

This will retrieve the last 20 messages from the “1\_explore\_wrangle”
channel.

``` r
  
convos <- threads::conversations(channel = '1_explore_wrangle', limit = 20, max_results = 20)
```

Check that request was returned ok and that up to 20 were returned.

``` r
length(convos)
#> [1] 20
```

There are 6 replies to the first message

``` r
convos[[1]]$reply_count
#> [1] 6
```
