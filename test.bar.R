len <- 10
progress.bar.initialize(len)
for (i in 1:len) {
    Sys.sleep(1)
    progress.bar.show(40)
}
progress.bar.finalize()
