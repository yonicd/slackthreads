#' POST Channel Conversation
#'
#' Conversations API method's required scopes depend on the type
#'   of channel-like object you're working with.
#'
#' @param ... arguments to pass to POST call
#' @param channel character, channel name to fetch history for, Default:
#'   \code{Sys.getenv("SLACK_CHANNEL")}
#' @param api_token character, full Slack API token, Default:
#'   \code{Sys.getenv("SLACK_API_TOKEN")}
#'
#' @return A tibble containing channel messages with the class "conversation"
#'
#' @details To use the method, you'll need at least one of the channels, groups,
#'   im or mpim scopes corresponding to the conversation type you're working
#'   with. See [Slack
#'   Documentation](https://api.slack.com/methods/conversations.history) for
#'   more details.
#'
#' @export
#'
#' @examples
#' \dontrun{
#' convos <- get_conversations(channel = "5_general_r_help", limit = 100)
#' }
get_conversations <- function(...,
                              channel = Sys.getenv("SLACK_CHANNEL"),
                              api_token = Sys.getenv("SLACK_API_TOKEN")) {
  # Validate inputs.
  if ( !is.character(channel) | length(channel) > 1 ) {
    stop("channel must be a character vector of length one")
  }
  if ( !is.character(api_token) | length(api_token) > 1 ) {
    stop("api_token must be a character vector of length one")
  }

  # I don't know why this block of code is here. -JDH
  loc <- Sys.getlocale('LC_CTYPE')
  Sys.setlocale('LC_CTYPE','C')
  on.exit(Sys.setlocale("LC_CTYPE", loc))

  # The "SLACK_CHANNEL" environment variable has a # at the start of the channel
  # name, but the API doesn't want that. Users might do the same.
  channel <- sub("^#", "", channel)

  # Translate channel name to channel id.
  chnl_map <- slackteams::get_team_channels()[,c('id', 'name')]
  this_chnl <- chnl_map$id[grepl(channel, chnl_map$name)]

  # Do the call.
  resp <- httr::POST(
    url = "https://slack.com/api/conversations.history",
    body = list(
      token = api_token,
      channel = this_chnl,
      ...
    )
  )

  # If the call didn't work, throw an error.
  httr::stop_for_status(resp) # nocov

  # From now on we'll want the content of the response.
  resp <- httr::content(resp)

  # If the call "worked" but Slack returned ok = FALSE, throw an error.
  if (!resp$ok) {
    stop(resp$error)
  }

  # We should deal with $has_more and the associated
  # $response_metadata$next_cursor, but that will take some additional info.

  # Structure the messages into a tidy tibble.
  resp_tbl <- tidyr::unnest_wider(
    tibble::tibble(channel = channel, messages = resp$messages),
    "messages"
  )
  structure(
    resp_tbl,
    class = c("conversation_tbl", class(resp_tbl))
  )
}
