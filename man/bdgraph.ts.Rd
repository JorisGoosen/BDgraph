\name{bdgraph.ts}
\alias{bdgraph.ts}

\title{	Search algorithm in time series graphical models }
\description{
	This function is for Bayesian model determination in time series graphical models, based on birth-death MCMC method. 
}
\usage{
bdgraph.ts( data, Nlength = NULL, n, iter = 1000, burnin = iter / 2, 
            g.start = "empty", g.space = NULL, prior.df = rep( 3, Nlength ), 
            save.all = FALSE, cores = 2 )
}

\arguments{
	\item{data}{
	The aggregate periodogram \eqn{P_k}, which is arranged as a large \eqn{p x (Nlength*p)} matrix \eqn{[P_1, P_2, ... ,P_Nlength]}.
	}

	\item{Nlength}{ The length of the time series. }
	\item{n}{The number of observations. }
	  	
	\item{iter}{The number of iteration for the sampling algorithm.}
	\item{burnin}{The number of burn-in iteration for the sampling algorithm.}

	\item{g.start}{
		Corresponds to a starting point of the graph. It could be \code{"empty"} (default) and \code{"full"}. 
		Option \code{"empty"} means the initial graph is an empty graph and \code{"full"} means a full graph. 
		It also could be an object with \code{S3} class \code{"bdgraph"}; 
		with this option we could run the sampling algorithm from the last objects of previous run (see examples).     
	} 
	
	\item{g.space}{
		Corresponds to the sub-space of the graph. 
		For the case \code{ g.start = "NULL"} (default), algorithm search in the hole graph space. 
		With this option, one could run the search algorithm only to the restricted subspace of the graph.
		Subspace should determine as an adjacency matrix.
	} 
	
	\item{prior.df}{
		The degree of freedom for complex G-Wishart distribution, \eqn{CW_G(b,D)}, which is a prior distribution of the precision matrix in each frequency.
	}
	\item{save.all}{
		Logical: if FALSE (default), the adjacency matrices are NOT saved. 
		If TRUE, the adjacency matrices after burn-in are saved.
	}	
	\item{cores}{ The number of cores to use for parallel execution. 
	   The default is to use \code{2} CPU cores of the computer.
	   The case \code{cores="all"} means all CPU cores to use for parallel execution. 
	   }	
}

\value{
	An object with \code{S3} class \code{"bdgraph"} is returned:
	
	\item{p_links}{ An upper triangular matrix which corresponds the estimated posterior probabilities of all possible links. }
	
	\item{K_hat}{ The posterior estimation of the precision matrix. }

	For the case "save.all = TRUE" is returned:

	\item{sample_graphs}{ A vector of strings which includes the adjacency matrices of visited graphs after burn-in.}
	\item{graph_weights}{ A vector which includes the waiting times of visited graphs after burn-in. }

	\item{all_graphs}{A vector which includes the identity of the adjacency matrices for all iterations after burn-in. 
		  It is needed for monitoring the convergence of the BD-MCMC algorithm.}

	\item{all_weights}{A vector which includes the waiting times for all iterations after burn-in. It is needed for monitoring the convergence of the BD-MCMC algorithm.}
	\item{status}{An integer to indicate the iteration where the algorithm exits, since if the sum of all rates is 0 at some iteration, the graph at this iteration is              regarded as the real graph. It is 0 if the algorithm doesn't exit.}
	
}

\references{
Tank, A., N. Foti, and E. Fox (2015) Bayesian Structure Learning for Stationary Time Series, , \emph{arXiv preprint arXiv:1505.03131}

Mohammadi, A. and E. Wit (2015). Bayesian Structure Learning in Sparse Gaussian Graphical Models, \emph{Bayesian Analysis}, 10(1):109-138

Mohammadi, A. and E. Wit (2015). \pkg{BDgraph}: An \code{R} Package for Bayesian Structure Learning in Graphical Models, \emph{arXiv preprint arXiv:1501.05108} 

Mohammadi, A. et al (2017). Bayesian modelling of Dupuytren disease by using Gaussian copula graphical models, \emph{Journal of the Royal Statistical Society: Series C} 

Mohammadi, A., Massam H., and G. Letac (2017). The Ratio of Normalizing Constants for Bayesian Graphical Gaussian Model Selection, \emph{arXiv preprint arXiv:1706.04416} 

Dobra, A. and A. Mohammadi (2017). Loglinear Model Selection and Human Mobility, \emph{arXiv preprint arXiv:1711.02623}
}

\author{ Lang Liu, Nicholas Foti, Alex Tank and Reza Mohammadi }

\seealso{ \code{\link{bdgraph}} \code{\link{bdgraph.sim}}, \code{\link{summary.bdgraph}}, and \code{\link{compare}} }

\examples{
\dontrun{
# Generating time series data
Nlength = 100; N = 150; p = 6; b = 3; threshold = 1e-8;

I                   = diag( p )
A                   = diag( p )
A[ upper.tri( A ) ] = rbinom( p * ( p - 1 ) / 2, 1, 0.2 )
A                   = 0.5 * A

G = matrix( 0, p, p )
K = matrix( 0, p, p * Nlength )

lambda  = seq( 0, Nlength - 1, 1 ) * 2 * pi / Nlength
K0      = matrix( 0, p, p * Nlength )
K_times = matrix( 1, p, p )

for( k in 1:Nlength )
{ # Compute K0
	K0[,(k*p - p + 1):(k*p)] = I + t(A) %*% A + complex(1,cos(-lambda[k]),sin(-lambda[k]))*A 
	                  + complex(1,cos(lambda[k]),sin(lambda[k]))*t(A)
	K_times = K_times * ( K0[ , ( k * p - p + 1 ) : ( k * p ) ] != 0 )
	diag( K[ , ( k * p - p + 1 ) : ( k * p ) ] ) = 1
}

G0         = K_times
diag( G0 ) = 0

D = K
d = array( 0, c( p, Nlength, N ) )  # d is the Fourier coefficients of X
x = array( 0, c( p, Nlength, N ) )

for( n in 1:N )
{ # Generate X
	e = matrix( rnorm( p * Nlength ), p, Nlength )
	for( t in 1:Nlength )
		x[ , t, n ] = ifelse( t == 1, e[ , t ], e[ , t ] + A %*% x[ , t - 1, n ] )
}

P = 0 * D
for( n in 1:N )
{   # Compute Pk
	X = x[ , , n ]

	for( i in 1:p ) d[ i, , n ] = fft( X[ i, ] )

	for( i in 1:Nlength ) 
		P[, (i*p-p+1):(i*p)] = P[, (i*p-p+1):(i*p)] + d[, i, n] %*% t(Conj(d[, i, n]))
}

bdgraph.obj = bdgraph.ts( P, Nlength, N, iter = 1000 )

summary( bdgraph.obj )
   
compare( G0, bdgraph.obj )	  
}
}
