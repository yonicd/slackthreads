tidy_convo <- function(convo){

  y <- purrr::map_df(convo$messages,.f=function(x) {

    if(is.null(x$client_msg_id))
      x$client_msg_id <- NA_character_

    if(is.null(x$reply_count))
      x$reply_count <- NA_integer_

    tibble::tibble(
      id = x$client_msg_id,
      ts_root= x$ts,
      root = x$user,
      root_text = x$text,
      reply_count = x$reply_count,
      reply_users = list(x$reply_users),
      replies = list(x$replies),
      latest_reply = list(x$latest_reply),
      reactions = list(x$reactions))
  })

  y$latest_reply <- purrr::map_chr(y$latest_reply,.f = function(x){
    if(is.null(x))
      return(NA_character_)

    x
  })

  y$replies <- purrr::modify(y$replies,.f=function(x){
    if(is.null(x)){
      ret <- tibble::tibble(user = NA_character_,ts = NA_character_)
    }else{
      ret <- tidyr::unnest(tibble::as_tibble(purrr::transpose(x)),cols = c(user, ts))
    }

    ret$reply_date <- as.POSIXct(as.numeric(ret$ts), origin="1970-01-01")
    ret
  })

  y$root_date <- as.POSIXct(as.numeric(y$ts_root), origin="1970-01-01")

  y$latest_reply_date <- as.POSIXct(as.numeric(y$latest_reply), origin="1970-01-01")

  y$heavy_check_mark <- purrr::map(y$reactions,.f = function(rxn) {

    if(is.null(rxn))
      return(FALSE)

    purrr::map_lgl(rxn,.f=function(rxn_i){"heavy_check_mark"%in%rxn_i$name})

  })

  y$heavy_check_mark <- purrr::map_lgl(y$heavy_check_mark,any)

  y$speech_balloon <- purrr::map(y$reactions,.f = function(rxn) {

    if(is.null(rxn))
      return(FALSE)

    purrr::map_lgl(rxn,.f=function(rxn_i){"speech_balloon"%in%rxn_i$name})

  })

  y$speech_balloon <- purrr::map_lgl(y$speech_balloon,any)

  y$duration <- NA_real_

  y$duration[y$heavy_check_mark] <- lubridate::make_difftime(y$latest_reply_date[y$heavy_check_mark] - y$root_date[y$heavy_check_mark],units = 'days')


  y$duration[!y$heavy_check_mark] <- lubridate::make_difftime(Sys.time() - y$root_date[!y$heavy_check_mark],units = 'days')

  y$duration[is.na(y$latest_reply)&y$heavy_check_mark] <- lubridate::make_difftime(Sys.Date() - Sys.Date(),units = 'days')


  y
}
