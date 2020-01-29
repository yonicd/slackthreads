# Raw Scripts for r4ds dashboards

## libraries needed

  - yonicd/slackteams, yonicd/threads, dplyr, purrr, ggplot2, tidyr, ggraph, tidygraph, igraph, patchwork, googleVis
  
## Usage

You will need to have an API key created from [slackr-app](https://github.com/yonicd/slackr-app) you can follow the directions in the [slackteams](https://github.com/yonicd/slackteams) to set it up.

 - wrapper.R fetches the data from slack 
   - tidy_convo converts the API responses to a tibble (it is called in the wrapper.R script)
 - channel_networks.R creates ggraph outputs
 - mentors.R contains output ideas for the mentor dashboard
  