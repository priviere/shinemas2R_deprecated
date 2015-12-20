# to print welcome message when loading the package
.onLoad <- function(...) {
packageStartupMessage("
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!!! Thanks for using shinemas2R :-)
!!! For a tutorial, type vignette(\"shinemas2R\")
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
"
)
}
