
<!-- README.md is generated from README.Rmd. Please edit that file -->

# slackthreads

<!-- badges: start -->

[![Lifecycle:
experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://www.tidyverse.org/lifecycle/#experimental)
[![R-win build
status](https://github.com/yonicd/slackthreads/workflows/R-win/badge.svg)](https://github.com/yonicd/slackthreads)
[![R-mac build
status](https://github.com/yonicd/slackthreads/workflows/R-mac/badge.svg)](https://github.com/yonicd/slackthreads)
[![R-linux build
status](https://github.com/yonicd/slackthreads/workflows/R-linux/badge.svg)](https://github.com/yonicd/slackthreads)
[![Codecov test
coverage](https://codecov.io/gh/yonicd/slackthreads/branch/master/graph/badge.svg)](https://codecov.io/gh/yonicd/slackthreads?branch=master)
<!-- badges: end -->

`slackthreads` is a part of `slackverse`

|                                                                                                                                 |                                                                                                                                     |                                                                                                                                    |
| :-----------------------------------------------------------------------------------------------------------------------------: | :---------------------------------------------------------------------------------------------------------------------------------: | :--------------------------------------------------------------------------------------------------------------------------------: |
|                                                                                                                                 | slackcalls<br>[![](https://github.com/yonicd/slackcalls/workflows/R-mac/badge.svg)](https://github.com/yonicd/slackcalls)<br>↙️⬇️↘️ |                                                                                                                                    |
| slackthreads<br>[![](https://github.com/yonicd/slackthreads/workflows/R-mac/badge.svg)](https://github.com/yonicd/slackthreads) |  slackteams<br>[![](https://github.com/yonicd/slackteams/workflows/R-mac/badge.svg)](https://github.com/yonicd/slackteams)<br>⬅️➡️  | slackblocks<br>[![](https://github.com/yonicd/slackblocks/workflows/R-mac/badge.svg)](https://github.com/yonicd/slackblocks)<br>⬇️ |
|                                                                                                                                 |                                                                                                                                     |    slackreprex<br>[![](https://github.com/yonicd/slackreprex/workflows/R-mac/badge.svg)](https://github.com/yonicd/slackreprex)    |

The goal of `slackthreads` is to interact with the Slack API to retrieve
and interrogate team conversations.

## Installation

``` r
remotes::install_github("yonicd/slackthreads")
```

## In the Tin

  - Fetch messages from conversations
  - Fetch replies in slackthreads to the messages in the conversations

## Example Using [R4DS Slack](https://www.rfordatasci.com/)

``` r
library(slackteams)
library(slackthreads)
```

### Load the Team

``` r
slackteams::load_teams()
#> The following teams are loaded:
#>   yonihuji, slackr, ropensci, r4ds
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
  
convos <- slackthreads::conversations(channel = '1_explore_wrangle', limit = 20, max_results = 20)
```

Check that request was returned ok and that up to 20 were returned.

``` r
length(convos)
#> [1] 20
```

There are 2 replies to the first message

``` r
convos[[1]]$reply_count
#> [1] 2
```
