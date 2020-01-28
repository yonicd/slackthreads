#' @importFrom slackteams get_team_channels get_active_team
validate_channel <- function(channel){

  # Strip leading # or @ to allow user flexibility.
  channel <- sub("^#", "", channel)
  channel <- sub("^@", "", channel)

  team_channels <- slackteams::get_team_channels(
    slackteams::get_active_team(),
    fields = c('id','name')
  )

  # Check both the id and name, in case the user passed in an id.
  if (channel %in% team_channels$id) {
    return(channel)
  } else if (channel %in% team_channels$name) {
    return(team_channels$id[grepl(channel, team_channels$name)])
  } else {
    stop("Unknown channel.")
  }


}
