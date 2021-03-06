% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/rtabulate.R
\name{rtabulate.logical}
\alias{rtabulate.logical}
\title{Tabulate a logical vector}
\usage{
\method{rtabulate}{logical}(x, col_by = by_all("col_1"), FUN = sum,
  ..., format = NULL, row.name = NULL, indent = 0,
  col_wise_args = NULL)
}
\arguments{
\item{x}{a vector}

\item{col_by}{(\code{\link{factor}} or \code{\link{data.frame}}
if a \code{\link{factor}} of length \code{nrow(x)} that defines
which levels in \code{col_by} define a column.
can use \code{\link{by_factor_to_matrix}} to create a matrix from a factor to use non-disjoint columns
can use \code{\link{by_all}} to have a column with all rows, alternatively look at \code{\link{by_add_total}})}

\item{FUN}{a function that processes the cell data}

\item{...}{arguments passed to \code{FUN}}

\item{format}{if \code{FUN} does not return a formatted \code{\link{rcell}}
then the \code{format} is applied}

\item{row.name}{if \code{NULL} then the \code{FUN} argument is deparsed and
used as \code{row.name} of the \code{\link{rrow}}}

\item{indent}{non-negative integer where 0 means that the row should not be
indented}

\item{col_wise_args}{a named list containing collections (e.g. vectors or
lists) with data elements for each column of the resulting table. The data
elements are then passed to the named argument \code{FUN} corresponding to
the element name of the outer list. Hence, the length and order of each
collection must match the levels in \code{col_by}. See examples.}
}
\value{
an \code{\link{rtable}} object
}
\description{
By default each cell reports the number of \code{TRUE} observations from the associated vector.
}
\examples{
rtabulate(iris$Species == "setosa")

rtabulate(iris$Species == "setosa", by_all("Species"),
   FUN = function(x, N) list(sum(x), sum(x)/N),
   row.name = "n (n/N)",
   col_wise_args = list(N = 150)
)

# default FUN is number of observations equal to TRUE
with(iris, rtabulate(Sepal.Length < 5, Species, row.name = "Sepal.Length < 5"))
 
# Custom FUN: number of TRUE records in a cell and precentages based on number of records
# in each column
with(iris, rtabulate(Sepal.Length < 5, Species,
  FUN = function(xi, N) sum(xi) * c(1, 1/N), 
  format = "xx.xx (xx.xx\%)",
  row.name = "Sepal.Length < 5",
  col_wise_args = list(N = table(Species))
))

}
