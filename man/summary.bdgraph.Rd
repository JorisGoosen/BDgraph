\name{summary.bdgraph}
\alias{summary.bdgraph}

\title{ Summary function for \code{S3} class \code{"bdgraph"} }

\description{
Provides a summary of the results for function \code{\link{bdgraph}}.  
}

\usage{
\method{summary}{bdgraph}( object, round = 2, vis = TRUE, ... )
}

\arguments{
  \item{object}{ An object of \code{S3} class \code{"bdgraph"}, from function \code{\link{bdgraph}}. }
  \item{round}{ A value for rounding all probabilities to the specified number of decimal places. }
  \item{vis}{ Visualize the results. }
  \item{\dots}{System reserved (no specific usage).}
}

\value{
	\item{best.graph}{The adjacency matrix corresponding to the selected graph which has the highest posterior probability.}
	\item{p_links}{An upper triangular matrix corresponding to the posterior probabilities of all possible links.}
	\item{K_hat}{The estimated precision matrix.}
}

\references{
Mohammadi, A. and E. Wit (2015). Bayesian Structure Learning in Sparse Gaussian Graphical Models, \emph{Bayesian Analysis}, 10(1):109-138

Mohammadi, A. and E. Wit (2015). \pkg{BDgraph}: An \code{R} Package for Bayesian Structure Learning in Graphical Models, \emph{arXiv preprint arXiv:1501.05108} 

Dobra, A. and A. Mohammadi (2017). Loglinear Model Selection and Human Mobility, \emph{arXiv preprint arXiv:1711.02623}

Mohammadi, A. et al (2017). Bayesian modelling of Dupuytren disease by using Gaussian copula graphical models, \emph{Journal of the Royal Statistical Society: Series C} 

Mohammadi, A., Massam H., and G. Letac (2017). The Ratio of Normalizing Constants for Bayesian Graphical Gaussian Model Selection, \emph{arXiv preprint arXiv:1706.04416} 
}

\author{ Reza Mohammadi and Ernst Wit }

\seealso{\code{\link{bdgraph}}}

\examples{
\dontrun{
# Generating multivariate normal data from a 'random' graph
data.sim <- bdgraph.sim( n = 50, p = 6, size = 7, vis = TRUE )
   
bdgraph.obj <- bdgraph( data = data.sim )
   
summary( bdgraph.obj )
   
bdgraph.obj <- bdgraph( data = data.sim, save.all = TRUE )
   
summary( bdgraph.obj )
   
summary( bdgraph.obj, vis = FALSE )
}
}
