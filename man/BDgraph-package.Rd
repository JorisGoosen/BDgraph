\name{BDgraph-package}
\alias{BDgraph-package}
\alias{BDgraph}

\alias{ compute_tp_fp }
\alias{ compute_measures }

\alias{ hill_climb_mpl }
\alias{ local_mb_hc }
\alias{ global_hc }
\alias{ log_mpl_disrete }

\alias{ hill_climb_mpl_binary }
\alias{ local_mb_hc_binary }
\alias{ global_hc_binary }
\alias{ log_mpl_binary }

\alias{ detect_cores }
\alias{ check.os }

\alias{ sample_ug }
\alias{ generate_clique_factors }
\alias{ calc_joint_dist }

\docType{package}

\title{ Bayesian Structure Learning in Graphical Models }

\description{
The \code{R} package \pkg{BDgraph} provides statistical tools for Bayesian structure learning in undirected graphical models.      
The package is implemented the recent improvements in the Bayesian graphical models literature, including Mohammadi and Wit (2015), Mohammadi et al. (2017), and Dobra and Mohammadi (2017).
The computationally intensive tasks of the package are implemented in parallel using \pkg{OpenMP} in \code{C++} and interfaced with \code{R}, to speed up the computations. 
Besides, the package contains several functions for simulation and visualization, as well as three multivariate datasets taken from the literature.
}
\details{
The package includes the following main functions: 

\preformatted{
bdgraph      Search algorithm in graphical models
bdgraph.mpl  Search algorithm in graphical models using marginal pseudo-likehlihood
bdgraph.sim  Graph data generator 
bdgraph.npn  Nonparametric transfer 
compare      Graph structure comparison 
plinks       Estimated posterior link probabilities
plotcoda     Convergence plot
plotroc      ROC plot
rgwish       Sampling from G-Wishart distribution
rwish        Sampling from Wishart distribution
select       Graph selection
traceplot    Trace plot of graph size
}
}

\section{How to cite this package}{
Whenever using this package, please cite as
\preformatted{
Mohammadi R. and E. C. Wit (2018). BDgraph: Bayesian Structure Learning in 
Graphical Models using Birth-Death MCMC, R package version 2.51, 
https://cran.r-project.org/package=BDgraph
}
}

\author{
	Reza Mohammadi [aut, cre], Ernst Wit [ctb], and Adrian Dobra [ctb]
	
	Maintainer: Reza Mohammadi \email{a.mohammadi@uva.nl}
}

\references{
Mohammadi, A. and E. Wit (2015). Bayesian Structure Learning in Sparse Gaussian Graphical Models, \emph{Bayesian Analysis}

Mohammadi, A. and E. Wit (2015). \pkg{BDgraph}: An \code{R} Package for Bayesian Structure Learning in Graphical Models, \emph{arXiv preprint arXiv:1501.05108} 

Dobra, A., et al. (2011). Copula Gaussian graphical models and their application to modeling functional disability data, \emph{The Annals of Applied Statistics}

Dobra, A., et al. (2011). Bayesian inference for general Gaussian graphical models with application to multivariate lattice data. \emph{Journal of the American Statistical Association}

Mohammadi, A., et al (2017). Bayesian modelling of Dupuytren disease by using Gaussian copula graphical models, \emph{Journal of the Royal Statistical Society: Series C} 

Dobra, A. and A. Mohammadi (2017). Loglinear Model Selection and Human Mobility, \emph{arXiv preprint arXiv:1711.02623}

Mohammadi, A. and A. Dobra (2017). The \code{R} Package \pkg{BDgraph} for Bayesian Structure Learning in Graphical Models, \emph{ISBA Bulletin}

Mohammadi, A., et al (2017). The Ratio of Normalizing Constants for Bayesian Graphical Gaussian Model Selection, \emph{arXiv preprint arXiv:1706.04416} 

Lenkoski, A. (2013). A direct sampler for G-Wishart variates, \emph{Stat}
}

\examples{
\dontrun{

library( BDgraph )

# Generating multivariate normal data from a 'random' graph
data.sim <- bdgraph.sim( n = 70, p = 6, size = 7, vis = TRUE )

# Running algorithm based on GGMs
bdgraph.obj <- bdgraph( data = data.sim, iter = 5000 )

summary( bdgraph.obj )

# To compare the result with true graph
compare( data.sim, bdgraph.obj, colnames = c("True graph", "BDgraph"), vis = TRUE )

# Running algorithm based on GGMs and marginal pseudo-likelihood
bdgraph.obj_mpl <- bdgraph.mpl( data = data.sim, iter = 5000 )

summary( bdgraph.obj_mpl )

# To compare the results of both algorithms with true graph
compare( data.sim, bdgraph.obj, bdgraph.obj_mpl, 
         colnames = c( "True graph", "BDgraph", "BDgraph_mpl" ), vis = TRUE )
}
}

\keyword{ Package, BDgraph, Bayesian Structure Learning, Gaussian Graphical Models, Gaussian Copula Graphical Models, BDMCMC, G-Wishart, Marginal Pseudo-likelihood }
