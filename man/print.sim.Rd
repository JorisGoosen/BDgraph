\name{print.sim}
\alias{print.sim}

\title{ Print function for \code{S3} class \code{"sim"} }

\description{ Prints the information about the type of data, the sample size, the graph type, the number of nodes, number of links and sparsity of the true graph. }

\usage{ \method{print}{sim}( x, ... ) }

\arguments{
  \item{x}{ An object of \code{S3} class \code{"sim"}, from function \code{\link{bdgraph.sim}}.  }
  \item{\dots}{ System reserved (no specific usage). }
}

\references{
Mohammadi, A. and E. Wit (2015). Bayesian Structure Learning in Sparse Gaussian Graphical Models, \emph{Bayesian Analysis}, 10(1):109-138

Mohammadi, A. and E. Wit (2015). \pkg{BDgraph}: An \code{R} Package for Bayesian Structure Learning in Graphical Models, \emph{arXiv preprint arXiv:1501.05108v2} 

Dobra, A. and A. Mohammadi (2017). Loglinear Model Selection and Human Mobility, \emph{arXiv preprint arXiv:1711.02623}

Mohammadi, A. et al (2017). Bayesian modelling of Dupuytren disease by using Gaussian copula graphical models, \emph{Journal of the Royal Statistical Society: Series C} 

Mohammadi, A., Massam H., and G. Letac (2017). The Ratio of Normalizing Constants for Bayesian Graphical Gaussian Model Selection, \emph{arXiv preprint arXiv:1706.04416} 
}

\author{ Reza Mohammadi, Adrian Dobra, and Ernst Wit }

\seealso{ \code{\link{bdgraph.sim}} }

\examples{
\dontrun{
# Generating multivariate normal data from a 'random' graph 
data.sim <- bdgraph.sim( n = 20, p = 10, vis = TRUE )
   
print( data.sim )
}
}
