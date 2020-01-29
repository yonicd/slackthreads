#' @title Retrieve Conversations
#' @description  Retrieve conversations from a channel on a Slack team.
#' @param channel Character. Channel name to retrieve conversation from.
#' @param ... Arguments to pass to method
#' @param token Character. Your Slack API token. Default: Sys.getenv("SLACK_API_TOKEN")
#' @param limit Numeric, maximum number of results per call. Default: 1000L
#' @inheritParams slackcalls::post_slack
#' @return A list of channel messages with class "conversations.history".
#' @details To use the method, you'll need at least one of the channels, groups,
#'   im or mpim scopes corresponding to the conversation type you're working
#'   with.
#'
#'   See [Slack
#'   Documentation](https://api.slack.com/methods/conversations.history) for
#'   more details on the arguments that the method can recieve in \dots.
#' @rdname conversations
#' @export
#' @importFrom slackcalls post_slack
conversations <- function(channel,
                          ...,
                          token = Sys.getenv("SLACK_API_TOKEN"),
                          max_results = Inf,
                          max_calls = Inf,
                          limit = 1000L) {

  channel <- validate_channel(channel)
  res <- slackcalls::post_slack(
    slack_method = 'conversations.history',
    max_results = max_results,
    max_calls = max_calls,
    channel = channel,
    token = token,
    limit = limit,
    ...
  )

  if (is.null(res$messages)) {
    # I don't know of a way that this can happen, but this is here in case.
    # nocov start
    structure(
      list(0),
      class = c("conversations.history", "list"),
      channel = channel
    )
    # nocov end
  } else {
    # Add a class to each message and a channel attribute.
    messages <- lapply(
      res$messages,
      structure,
      class = c("conversation", "list"),
      channel = channel
    )

    structure(
      messages,
      class = class(res),
      channel = channel
    )
  }

}

#' @title Retrieve Replies
#' @description Retrieve replies to individual conversations on a Slack team.
#' @inheritParams conversations
#' @param ts Character. Unique identifier of a thread's parent message.
#' @rdname replies
#' @export
#' @importFrom slackcalls post_slack
replies <- function(ts,
                    channel,
                    ...,
                    token = Sys.getenv("SLACK_API_TOKEN"),
                    max_results = Inf,
                    max_calls = Inf,
                    limit = 1000L) {

  channel <- validate_channel(channel)

  res <- slackcalls::post_slack(
    slack_method = 'conversations.replies',
    max_results = max_results,
    max_calls = max_calls,
    limit = limit,
    ts = ts,
    channel = channel,
    token = token,
    ...
  )

  # The first reply is the message itself.
  messages <- res$messages
  messages[[1]] <- NULL

  if (is.null(messages)) {
    # I don't know of a way that this can happen, but this is here in case.
    # nocov start
    structure(
      list(0),
      class = c("conversations.replies", "list"),
      channel = channel
    )
    # nocov end
  } else {
    # Add a class to each message and a channel attribute.
    messages <- lapply(
      messages,
      structure,
      class = c("reply", "list"),
      channel = channel
    )

    structure(
      messages,
      class = class(res),
      channel = channel
    )
  }

}

#' @rdname replies
#' @param conversation An individual conversation object from the list returned
#'   by \code{\link{conversations}}.
#' @export
conversation_replies <- function(conversation,
                                 ...,
                                 token = Sys.getenv("SLACK_API_TOKEN"),
                                 max_results = Inf,
                                 max_calls = Inf,
                                 limit = 1000L) {
  replies(
    ts = conversation$ts,
    channel = attr(conversation, "channel"),
    ...,
    token = token,
    max_results = max_results,
    max_calls = max_calls,
    limit = limit
  )
}
