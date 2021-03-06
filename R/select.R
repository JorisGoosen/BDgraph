## ------------------------------------------------------------------------------------------------|
#     Copyright (C) 2012 - 2018  Reza Mohammadi                                                    |
#                                                                                                  |
#     This file is part of BDgraph package.                                                        |
#                                                                                                  |
#     BDgraph is free software: you can redistribute it and/or modify it under                     |
#     the terms of the GNU General Public License as published by the Free                         |
#     Software Foundation; see <https://cran.r-project.org/web/licenses/GPL-3>.                    |
#                                                                                                  |
#     Maintainer: Reza Mohammadi <a.mohammadi@uva.nl>                                              |
## ------------------------------------------------------------------------------------------------|
#     To select the graph in which the edge posterior probabilities are more than "cut" value      |
#     OR if cut is NULL to select the best graph ( graph with the highest posterior probability )  |
## ------------------------------------------------------------------------------------------------|

select = function( bdgraph.obj, cut = NULL, vis = FALSE )
{
	if( class( bdgraph.obj ) == "bdgraph" )
	{
		p_links = bdgraph.obj $ p_links
		p       = nrow( bdgraph.obj $ last_graph )
	}

    if( class( bdgraph.obj ) == "ssgraph" )
    {
        p_links = bdgraph.obj $ p_links
        p       = nrow( bdgraph.obj $ K_hat )
    }
    
	if( is.matrix( bdgraph.obj ) ) 
	{
	    if( any( bdgraph.obj < 0 ) || any( bdgraph.obj > 1 ) ) stop( "Values of 'bdgraph.obj' must be between ( 0, 1 )." )
	    p_links = bdgraph.obj
		p       = nrow( p_links )
	}
  
	if( is.null( p_links ) )
	{
		if( is.null( cut ) )
		{
			sample_graphs <- bdgraph.obj $ sample_graphs
			graph_weights <- bdgraph.obj $ graph_weights
			
			indG_max     <- sample_graphs[ which( graph_weights == max( graph_weights ) )[1] ]
			vec_G        <- c( rep( 0, p * ( p - 1 ) / 2 ) )
			vec_G[ which( unlist( strsplit( as.character( indG_max ), "" ) ) == 1 ) ] <- 1

			dimlab       <- colnames( bdgraph.obj $ last_graph )
			selected_g   <- matrix( 0, p, p, dimnames = list( dimlab, dimlab ) )	
			selected_g[ upper.tri(selected_g) ] <- vec_G
		}else{
		    
			if ( ( cut < 0 ) || ( cut > 1 ) ) stop( "Value of 'cut' must be between ( 0, 1 )." )
			p_links                = as.matrix( BDgraph::plinks( bdgraph.obj ) )
			p_links[ p_links > cut ]  = 1
			p_links[ p_links <= cut ] = 0
			selected_g          = p_links
		}
	}else{
		if( is.null( cut ) ) cut = 0.5
		if( ( cut < 0 ) || ( cut > 1 ) ) stop( "Value of 'cut' must be between ( 0, 1 )." )
		
		selected_g                   = 0 * p_links
		selected_g[ p_links >  cut ] = 1
		selected_g[ p_links <= cut ] = 0
	}
		
	if( vis )
	{
		G <- graph.adjacency( selected_g, mode = "undirected", diag = FALSE )
		if( p < 20 ) sizev = 15 else sizev = 2

		if( is.null( cut ) )
		{
			plot.igraph( G, layout = layout.circle, main = "Graph with highest posterior probability", sub = paste( c( "Posterior probability = ", round( max( graph_weights ) / sum( graph_weights ), 4) ), collapse = "" ),
			            vertex.color = "white", vertex.size = sizev, vertex.label.color = 'black'  )
		}else{
			plot.igraph( G, layout = layout.circle, main = paste( c( "Graph with links posterior probabilities > ",  cut ), collapse = "" ), vertex.color = "white", vertex.size = sizev, vertex.label.color = 'black' )
		}
	}

	return( selected_g )
}
       
