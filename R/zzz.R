# to print welcome message when loading the package
.onLoad <- function(...) {
packageStartupMessage("
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!!! Thanks for using shinemas2R :-)
!!! For a tutorial, type vignette(\"shinemas2R\")
!!! You can follow developments here : github.com/priviere/shinemas2R
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
"
)
}
