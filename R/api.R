#' @importFrom slackcalls post_slack parse_call
get_conversations_history <- function(channel, limit, ..., token = Sys.getenv("SLACK_API_TOKEN"), max_results = Inf, max_calls = Inf){

  res <- slackcalls::post_slack(slack_method = slackcalls::parse_call(), max_results = max_results, max_calls = max_calls, channel = channel, token = token, limit = limit, ...)
}
