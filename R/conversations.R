#' @title POST Channel Conversation
#' @description  Conversations API method's required scopes depend on the type
#'  of channel-like object you're working with.
#' @param ... arguments to pass to POST call
#' @param channel character, Conversation ID to fetch history for, Default: Sys.getenv("SLACK_CHANNEL")
#' @param api_token character, full Slack API token, Default: Sys.getenv("SLACK_API_TOKEN")
#' @return A [response][httr::response] object containing channel messages with the class "conversation"
#' @details To use the method, you'll need at least one of the channels,
#'  groups, im or mpim scopes corresponding to the conversation
#'  type you're working with. See [Slack Documentation](https://api.slack.com/methods/conversations.history) for more details.
#' @rdname get_conversations
#' @export
#' @importFrom slackteams get_team_channels
#' @importFrom httr POST warn_for_status content
get_conversations <- function(...,channel=Sys.getenv("SLACK_CHANNEL"),api_token=Sys.getenv("SLACK_API_TOKEN")) {

  if ( !is.character(channel) | length(channel) > 1 ) { stop("channel must be a character vector of length one") }
  if ( !is.character(api_token) | length(api_token) > 1 ) { stop("api_token must be a character vector of length one") }


  loc <- Sys.getlocale('LC_CTYPE')
  Sys.setlocale('LC_CTYPE','C')
  on.exit(Sys.setlocale("LC_CTYPE", loc))

  chnl_map <- slackteams::get_team_channels()[,c('id','name')]
  this_chnl <- chnl_map$id[grepl(channel,chnl_map$name)]

  resp <- httr::POST(url="https://slack.com/api/conversations.history",
                     body=list(token=api_token,
                               channel=this_chnl,
                               ...))
  httr::warn_for_status(resp)

  structure(httr::content(resp),class = c('conversation','list'),channel = channel)

}
