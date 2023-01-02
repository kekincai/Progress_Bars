progress.bar.initialize <- function(len) {
    # initialize the bar
    # @param len the length of iter
    if (missing(len)) {
        stop("len is not initialized.")
    }
    .Iter.Len <<- len
    .Iter <<- 1
    .Bar.char <<- "\U2588" # bar character
    .unBar.char <<- "\U2591" # the undo progress character
    .Time <<- Sys.time() # the time
    .Mean.time <<- 0 # the average run time
}
progress.bar.show <- function(bar.total = 50) {
    # show the bar
    progress <- round(.Iter / .Iter.Len, 2)
    bar.len <- round(progress * bar.total)
    bar <- paste0(c(
        rep(.Bar.char, bar.len),
        rep(.unBar.char, bar.total - bar.len)
    ), collapse = "")
    time.info <- paste0(
        "ave runtime: ",
        round((.Mean.time <<- (.Mean.time * .Iter - difftime(.Time, .Time <<- Sys.time())) / (.Iter <<- .Iter + 1)), 2),
        "s  left time: ", round((.Mean.time * (.Iter.Len - min(.Iter, .Iter.Len))), 2), "s"
    )
    cat(progress * 100, "%", "|", bar, "| ", time.info, " \r")
    flush.console()
}

progress.bar.finalize <- function() {
    # remove the global variables
    rm(.Iter.Len,
        .Iter,
        .Bar.char,
        .unBar.char,
        .Time,
        .Mean.time,
        envir = .GlobalEnv
    )
}
