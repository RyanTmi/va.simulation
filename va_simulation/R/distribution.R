##########################################################
#                                                        #
#               Discrete Distribution Utils              #
#                                                        #
##########################################################


source("R/tree.R")


#' Generate a discrete distribution (based on exponential v.a).
#'
#' @param size Number of value.
#'
#' @return A numeric vector.
#' @export
generate_discrete_dist <- function(size) {
  lambda <- sample(1:100, 1)
  x <- rep(0, size)
  sum_xi <- 0

  for (i in 1:size) {
    x[i] <- rexp(1, lambda)
    sum_xi <- sum_xi + x[i]
  }
  for (i in 1:size) {
    x[i] <- x[i] / sum_xi
  }

  return(x)
}

#' Calculate the entropy of an v.a.
#'
#' @param freqs Frequencies vector.
#'
#' @return The entropy.
#' @export
get_entropy <- function(freqs) {
  freqs <- freqs[which(freqs > 0)]
  -sum(freqs * log2(freqs))
}


#' Map a vector of frequencies to priority queue of dyadic nodes.
#'
#' @param frequencies Frequencies vector.
#'
#' @return A priority queue of nodes.
#' @export
get_nodes <- function(frequencies) {
  nodes_pq <- priority_queue()

  for (i in seq_along(frequencies)) {
    .add_dyadic_decomposition(nodes_pq, frequencies[i], i)
  }

  return(nodes_pq)
}


.max_dyadic_precision <- 16
.dyadic_atoms <- 1 / (2 ^ (1:.max_dyadic_precision))


#' Add all dyadic atom of a frequency into a priority queue.
#'
#' @param pq The priority queue.
#' @param freq The frequency to split.
#' @param symbol The symbol associate with.
#'
#' @return The priority queue.
#' @export
.add_dyadic_decomposition <- function(pq, freq, symbol) {
  for (atom in .dyadic_atoms) {
    if (freq == atom) {
      pq$push(Node$new(symbol, atom), priority = -log2(atom))
      return()
    }
    if (freq > atom) {
      pq$push(Node$new(symbol, atom), priority = -log2(atom))
      freq <- freq - atom
    }
  }
  return(pq)
}
