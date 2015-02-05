# katexR htmlwidget

**note: pre-Alpha**

`katexR` is a R [`htmlwidget`](http://htmlwidgets.org) that brings the power of [KaTeX](http://khan.github.io/KaTeX) to R.  Try it out with a couple lines of code.

```R
#devtools::install_github("timelyportfolio/katexR")
library(katexR)
katexR("\\KaTeX")

katexR( "Var(X)= E(X^2)-(E(X))^2" )
```

More than likely you might like to integrate `katexR` in your other HTML content.  With `tags` from `htmltools`, we could put it all together like this.

```R
#devtools::install_github("timelyportfolio/katexR")
library(katexR)
library(htmltools)

# use the example from the KaTeX site
html_print(
  tagList(
    tags$pre(
      "f(x) = \\int_{-\\infty}^\\infty
          \\hat f(\\xi)\\,e^{2 \\pi i \\xi x}
          \\,d\\xi"
    )
    ,tags$p( " will become this ")
    ,as.tags(
      katexR(
        "f(x) = \\int_{-\\infty}^\\infty
            \\hat f(\\xi)\\,e^{2 \\pi i \\xi x}
            \\,d\\xi"
      )
    )
  )
)
```

Like all `htmlwidgets`, `katexR` will integrate beautifully with `rmarkdown`.  If you write research in `R`, I think you'll definitely want to try out `katexR`.

`katexR` is the `htmlwidget` of the week at [Building Widgets](http://buildingwidgets.org).  See the writeup on `katexR` and all of the other `htmlwidgets` from the project on the [blog](http://buildingwidgets.org/blog).

