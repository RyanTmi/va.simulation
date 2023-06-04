##########################################################
#                                                        #
#  Generation Of Discrete Distributions From Fair Coins  #
#                                                        #
##########################################################


source("R/tree.R")

#' @importFrom R6 R6Class
#' @importFrom tictoc tic toc
#' @importFrom collections priority_queue
#' @importFrom graphics hist par points text
#' @importFrom stats rbinom rexp
NULL


#' Generate a v.a from frequencies.
#'
#' @param freqs The frequencies vector.
#'
#' @return The root of the Huffman tree.
#' @export
generate_va <- function(freqs) {
  nodes_pq <- get_nodes(freqs)
  tree <- .get_huffman_tree(nodes_pq)

  return(tree)
}


#' Construct the Huffman tree from frequencies.
#'
#' @param nodes_pq The priority queue containing all dyadic frequencies.
#'
#' @return The root of the Huffman tree.
#' @export
.get_huffman_tree <- function(nodes_pq) {
  while (nodes_pq$size() > 1) {
    right <- nodes_pq$pop()
    left <- nodes_pq$pop()

    nodes_pq$push(
      Node$new(NULL, left$freq + right$freq, left, right),
      priority = -log2(left$freq + right$freq)
    )
  }

  return(nodes_pq$pop())
}


#' Decode a binary message.
#'
#' @param h_tree Huffman root tree.
#' @param encoded_msg Binary vector.

#' @return Message decoded through symbols.
#' @export
decode <- function(h_tree, encoded_msg) {
  decoded_msg <- NULL

  current <- h_tree
  for (b in encoded_msg) {
    if (b == 0) {
      current <- current$left
    } else {
      current <- current$right
    }

    if (!is.null(current$sym)) {
      decoded_msg <- c(decoded_msg, current$sym)
      current <- h_tree
    }
  }

  return(decoded_msg)
}

