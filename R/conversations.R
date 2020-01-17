#' @title FUNCTION_TITLE
#' @description FUNCTION_DESCRIPTION
#' @param ... PARAM_DESCRIPTION
#' @param channel PARAM_DESCRIPTION, Default: Sys.getenv("SLACK_CHANNEL")
#' @param api_token PARAM_DESCRIPTION, Default: Sys.getenv("SLACK_API_TOKEN")
#' @return OUTPUT_DESCRIPTION
#' @details DETAILS
#' @examples 
#' \dontrun{
#' if(interactive()){
#'  #EXAMPLE1
#'  }
#' }
#' @seealso 
#'  [get_team_channels][slackteams::get_team_channels]
#'  [POST][httr::POST], [warn_for_status][httr::warn_for_status], [content][httr::content]
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
