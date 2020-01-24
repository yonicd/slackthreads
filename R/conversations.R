#' @title Retrieve Conversations and Replies
#' @description  Retrieve Conversations from a Channel on a Slack Team
#' @param channel character, Channel name to retieve conversation from
#' @param ts character, Unique identifier of a thread's parent message
#' @param ... arguments to pass to method
#' @param api_token character, full Slack API token, Default: Sys.getenv("SLACK_API_TOKEN")
#' @return A [response][httr::response] object containing channel messages with the class "conversation"
#' @details To use the method, you'll need at least one of the channels,
#'  groups, im or mpim scopes corresponding to the conversation
#'  type you're working with.
#'
#'  See [Slack Documentation](https://api.slack.com/methods/conversations.history) for more details on the arguments that the method can recieve in \dots.
#' @rdname conversations
#' @export
#' @importFrom slackcalls post_slack
conversations <- function(channel, ..., api_token = Sys.getenv("SLACK_API_TOKEN"), max_results = Inf, max_calls = Inf, paginate = TRUE) {

  slackcalls::post_slack('conversations.history',max_results = max_results, max_calls = max_calls, paginate = paginate, channel = validate_channel(channel), token = api_token, ...)

}

#' @rdname conversations
#' @export
#' @importFrom slackcalls post_slack
replies <- function(ts, channel, ..., api_token = Sys.getenv("SLACK_API_TOKEN"), max_results = Inf, max_calls = Inf, paginate = TRUE) {

  slackcalls::post_slack('conversations.replies',max_results = max_results, max_calls = max_calls, paginate = paginate, ts = ts, channel = validate_channel(channel), token = api_token, ...)

}


#' @importFrom slackteams get_team_channels get_active_team
validate_channel <- function(channel){
  team_channels <- slackteams::get_team_channels(slackteams::get_active_team(),fields = c('id','name'))
  team_channels$id[grepl(channel,team_channels$name)]
}