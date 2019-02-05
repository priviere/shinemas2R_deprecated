This version of `shinemas2R` is deprecated because:

- the sql queries are not updated (`get.data.R`)
- the idea is to separate queries from SHiNeMaS from the analysis: all descriptive fonction has been moved to `PPBstats`, see here for more information: https://github.com/priviere/PPBstats
- the generation of report throught `get.pdf.R` is not really useful as Rmarkdown now does beautiful things! See https://github.com/priviere/PPBstats/issues/81

A new version of `shinemas2R` may be done one day with only one fonction `shinemas()` that could get dataset formated for a given package as `PPBstats` for example.

# shinemas2R

`shinemas2R` is an R package that analyses outputs from the data base [SHiNeMaS (Seeds History and Network Management System)](http://moulon.inra.fr/index.php/en/tranverse-team/atelier-de-bioinformatique/projects/181). 

The R code is under licence GPL-3.

The vignette of this package is under licence creative commons BY-NC-SA 4.0. 
More information about this licence [here](http://creativecommons.org/licenses/by-nc-sa/4.0/).

The copyright of the R code and the vignette are owned by Réseau Semences Paysannes and Institut National de la Recherche Agronomique

## Version
`shinemas2R` is now at version 0.11

The version number is under the form A.B with

* A: the number of the version on CRAN (0 = no version on CRAN yet)

* B: +1 when the code and/or the vignette change

See NEWS [here](https://github.com/priviere/shinemas2R/blob/master/NEWS) to know the evolution of the codes.

## Participate to development

You can participate in three ways:

1. test this development version and report bugs
2. translate the package
3. update functions to answer your specific needs

If you update the code, you can refer to 
[the issues](https://github.com/priviere/shinemas2R/issues)
and do it in on another branch.
Anyhow, send me an email if you wish to participate in order to coordinate our efforts!

### 1. Test and report bugs

First, load the development version:

  `
  devtools::install_github("priviere/shinemas2R")
  `

The easiest way to start is to look at the vignette to know how the package works.

You can see the vignette [here](https://www.dropbox.com/s/8gmuxttrga7hfe1/shinemas2R.pdf?dl=0). You can download it by clicking on 'Raw' in the top right corner.

Do not hesitate to let a message [in the issues](https://github.com/priviere/shinemas2R/issues) or to send me an email if some points are not clear in the vignette or you find bugs.


### 2. Translate

The package is in english. 
Every contributions to other languages are welcome!
More information on R package translation [here](http://developer.r-project.org/Translations30.html).

### 3. Update functions to answer your specific needs
You can update `format.data` [here](https://github.com/priviere/shinemas2R/blob/master/R/format.data.R) in order to format data for existing R packages.
Note that the output of the R packages must be a ggplot object to be taken by `get.pdf`.

You may want new query types (`get.data` [here](https://github.com/priviere/shinemas2R/blob/master/R/get.data.R)), 
new plots (`get.ggplot` [here](https://github.com/priviere/shinemas2R/blob/master/R/get.ggplot.R)) or 
new tables (`get.table` [here](https://github.com/priviere/shinemas2R/blob/master/R/get.table.R)) 
to answer your specific needs.

