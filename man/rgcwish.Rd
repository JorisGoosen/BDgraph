\name{rgcwish}
\alias{rgcwish}

\title{Sampling from complex G-Wishart distribution}

\description{
Generates random matrices, distributed according to the complex G-Wishart distribution with parameters b and D, \eqn{CW_G(b, D)}.
}

\usage{ rgcwish( n = 1, adj.g = NULL, b = 3, D = NULL ) }

\arguments{
  \item{n}{The number of samples required. The default value is 1.}
  \item{adj.g}{
    The adjacency matrix corresponding to the graph structure. It should be an upper triangular matrix in which \eqn{a_{ij}=1} 
    if there is a link between notes \eqn{i}{i} and \eqn{j}{j}, otherwise \eqn{a_{ij}=0}.
    }
  \item{b}{The degree of freedom for complex G-Wishart distribution, \eqn{CW_G(b, D)}. The default value is 3.}
  \item{D}{The positive definite \eqn{(p \times p)} "scale" matrix for complex G-Wishart distribution, \eqn{CW_G(b, D)}. 
           The default is an identity matrix.}
}

\details{
Sampling from the complex G-Wishart distribution, \eqn{K \sim CW_G(b, D)}, with density:

  \deqn{Pr(K) \propto |K| ^ {b} \exp \left\{- \mbox{trace}(K \times D)\right\},}

which \eqn{b > 2} is the degree of freedom and D is a symmetric positive definite matrix.
}

\value{
A numeric array, say A, of dimension \eqn{(p \times p \times n)}, where each \eqn{A[,,i]}{A[,,i]} is a positive 
definite matrix, a realization of the complex G-Wishart distribution, \eqn{CW_G(b, D)}.
}

\references{
Tank, A., N. Foti, and E. Fox (2015). Bayesian Structure Learning for Stationary Time Series, \emph{arXiv:1505.03131}

Mohammadi, A. and E. Wit (2015). \pkg{BDgraph}: An \code{R} Package for Bayesian Structure Learning in Graphical Models, \emph{arXiv:1501.05108} 
}

\author{ Lang Liu, Nicholas Foti, Alex Tank and  Abdolreza Mohammadi }

\examples{
\dontrun{
adj.g <- toeplitz( c( 0, 1, rep( 0, 3 ) ) )
adj.g    # adjacency of graph with 5 nodes and 4 links
   
sample <- rgcwish( n = 3, adj.g = adj.g, b = 3, D = diag(5) )
round( sample, 2 )  
}
}