#' @title Pagination
#' @description Paginating through collections of messages and replies.
#' @param parent conversation or reply class object
#' @param ... arguments to pass to get_conversation or get_reply
#' @return list of [response][httr::response] objects containing channel messages or thread messages
#' @details See [Slack Documentation](https://api.slack.com/docs/pagination) for more details.
#' @rdname paginate
#' @export
paginate <- function(parent,...){

  UseMethod('paginate')

}


#' @export
paginate.conversation <- function(parent,...){

  cont <- TRUE
  output <- list()
  output[[1]] <- parent
  i <- 1

  while(cont){
    this_cursor <- output[[i]]$response_metadata$next_cursor
    this <- get_conversations(..., channel = attr(parent,'channel'), cursor =  this_cursor)
    output <- append(output,list(this))
    i <- i+1
    cont <- output[[i]]$has_more
  }

  output
}


#' @export
paginate.reply <- function(parent,...){

  cont <- TRUE
  output <- list()
  output[[1]] <- parent
  i <- 1

  while(cont){
    this_cursor <- output[[i]]$response_metadata$next_cursor
    this <- get_replies(ts = attr(parent,'ts'), ..., channel =  attr(parent,'channel'),cursor =  this_cursor)
    output <- append(output,list(this))
    i <- i+1
    cont <- output[[i]]$has_more
  }

  output
}
