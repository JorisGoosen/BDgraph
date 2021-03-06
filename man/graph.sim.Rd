\name{graph.sim}
\alias{graph.sim}

\title{ Graph simulation }

\description{
Simulating graph structures, including 
\code{"random"}, \code{"cluster"}, \code{"scale-free"}, \code{"hub"}, \code{"fixed"}, \code{"circle"}, \code{"AR(1)"}, \code{"AR(2)"}, and \code{"star"}. 
}

\usage{
graph.sim( p = 10, graph = "random", prob = 0.2, size = NULL, class = NULL, vis = FALSE )
}

\arguments{
  \item{p}{The number of variables (nodes).}
  \item{graph}{The graph structure with option \code{"random"}, \code{"cluster"}, \code{"scale-free"}, 
               \code{"hub"}, \code{"circle"}. 
               It also could be an adjacency matrix corresponding to a graph structure (an upper triangular matrix in which 
               \eqn{g_{ij}=1} if there is a link between notes \eqn{i} and \eqn{j}, otherwise \eqn{g_{ij}=0}). 
    }
  \item{prob}{ If \code{graph="random"}, it is the probability that a pair of nodes has a link.}
  \item{size}{The number of links in the true graph (graph size).}
  \item{class}{ If \code{graph="cluster"}, it is the number of classes. }
  \item{vis}{Visualize the true graph structure.}
}

\value{
	\item{G}{The adjacency matrix corresponding to the simulated graph structure, as an object with \code{S3} class \code{"graph"}.}
}

\references{
Mohammadi, A. and E. Wit (2015). Bayesian Structure Learning in Sparse Gaussian Graphical Models, \emph{Bayesian Analysis}, 10(1):109-138

Mohammadi, A. and E. Wit (2015). \pkg{BDgraph}: An \code{R} Package for Bayesian Structure Learning in Graphical Models, \emph{arXiv preprint arXiv:1501.05108} 

Mohammadi, A. et al (2017). Bayesian modelling of Dupuytren disease by using Gaussian copula graphical models, \emph{Journal of the Royal Statistical Society: Series C} 

Mohammadi, A., Massam H., and G. Letac (2017). The Ratio of Normalizing Constants for Bayesian Graphical Gaussian Model Selection, \emph{arXiv preprint arXiv:1706.04416} 

Dobra, A. and A. Mohammadi (2017). Loglinear Model Selection and Human Mobility, \emph{arXiv preprint arXiv:1711.02623}

Pensar, J. et al (2017) Marginal pseudo-likelihood learning of discrete Markov network structures, \emph{Bayesian Analysis}
}

\author{ Reza Mohammadi }

\seealso{\code{\link{bdgraph.sim}}, \code{\link{bdgraph}}}

\examples{
\dontrun{
# Generating a 'hub' graph 
adj <- graph.sim( p = 8, graph = "scale-free" )
plot( adj )
adj
}
}
