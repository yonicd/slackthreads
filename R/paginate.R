#' @title FUNCTION_TITLE
#' @description FUNCTION_DESCRIPTION
#' @param root PARAM_DESCRIPTION
#' @param ... PARAM_DESCRIPTION
#' @param channel PARAM_DESCRIPTION
#' @return OUTPUT_DESCRIPTION
#' @details DETAILS
#' @examples
#' \dontrun{
#' if(interactive()){
#'  #EXAMPLE1
#'  }
#' }
#' @rdname paginate.conversation
#' @export
paginate <- function(root,...,channel){

  UseMethod('paginate')

}


#' @export
paginate.conversation <- function(root,...,channel){

  cont <- TRUE
  output <- list()
  output[[1]] <- root
  i <- 1

  while(cont){
    this_cursor <- output[[i]]$response_metadata$next_cursor
    this <- get_conversations(..., channel = attr(root,'channel'), cursor =  this_cursor)
    output <- append(output,list(this))
    i <- i+1
    cont <- output[[i]]$has_more
  }

  output
}


#' @export
paginate.reply <- function(root,...){

  cont <- TRUE
  output <- list()
  output[[1]] <- root
  i <- 1

  while(cont){
    this_cursor <- output[[i]]$response_metadata$next_cursor
    this <- get_replies(ts = attr(root,'ts'), ..., channel =  attr(root,'channel'),cursor =  this_cursor)
    output <- append(output,list(this))
    i <- i+1
    cont <- output[[i]]$has_more
  }

  output
}
