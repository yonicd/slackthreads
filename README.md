
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

|                                                                                                                                 |                                                                                                                           |                                                                                                                              |
| :-----------------------------------------------------------------------------------------------------------------------------: | :-----------------------------------------------------------------------------------------------------------------------: | :--------------------------------------------------------------------------------------------------------------------------: |
|                                                                                                                                 | slackcalls<br>[![](https://github.com/yonicd/slackcalls/workflows/R-mac/badge.svg)](https://github.com/yonicd/slackcalls) |                                                                                                                              |
| slackthreads<br>[![](https://github.com/yonicd/slackthreads/workflows/R-mac/badge.svg)](https://github.com/yonicd/slackthreads) | slackteams<br>[![](https://github.com/yonicd/slackteams/workflows/R-mac/badge.svg)](https://github.com/yonicd/slackteams) |  slackposts<br>[![](https://github.com/yonicd/slackposts/workflows/R-mac/badge.svg)](https://github.com/yonicd/slackposts)   |
|                                                                                                                                 |                                                                                                                           | slackblocks<br>[![](https://github.com/yonicd/slackblocks/workflows/R-mac/badge.svg)](https://github.com/yonicd/slackblocks) |
|                                                                                                                                 |                                                                                                                           | slackreprex<br>[![](https://github.com/yonicd/slackreprex/workflows/R-mac/badge.svg)](https://github.com/yonicd/slackreprex) |

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
slackteams::activate_team('R4ds')
```

### Retrieve Team Channels

``` r
chnls <- slackteams::get_team_channels()

 # r4ds has channels to ask questions in
question_channels <- grep('^help-',chnls$name,value = TRUE)

question_channels
```

### Retrieve Conversations

This will retrieve the last 20 messages from the
“help-1-explore\_wrangle” channel.

``` r
  
convos <- conversations(
  channel = 'help-1-explore_wrangle', 
  limit = 20, 
  max_results = 20
)
```

Check that request was returned ok and that up to 20 were returned.

``` r
length(convos)
```

There are the following replies to the first message

``` r
convos[[1]]$reply_count
```
