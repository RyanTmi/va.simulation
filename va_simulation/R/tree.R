##########################################################
#                                                        #
#                  Binary Search Tree                    #
#                                                        #
##########################################################

# using R6 class to represent BST
library(R6)


Node <- R6Class("Node", list(
  sym = NULL,
  freq = NULL,
  left = NULL,
  right = NULL,

  initialize = function(sym, freq, left = NULL, right = NULL) {
    self$sym <- sym
    self$freq <- freq
    self$left <- left
    self$right <- right
    invisible(self)
  },

  average_fair_bits = function() {
    if (!is.null(self$sym)) {
      return(self$freq * -log2(self$freq))
    }
    afb <- 0
    if (!is.null(self$left)) {
      afb <- afb + self$left$average_fair_bits()
    }
    if (!is.null(self$right)) {
      afb <- afb + self$right$average_fair_bits()
    }
    return(afb)
  },

  to_string = function(prefix, is_left) {
    h <- paste0("(", as.character(floor(-log2(self$freq))), ")")
    v <- if (is.null(self$sym)) h else paste0(" ", self$sym)
    cat(prefix, if (is_left) "/--" else "\\--", paste0(v, "\n"), sep = "")

    prefix <- paste0(prefix, if (is_left) "|   " else "    ")
    if (!is.null(self$left)) {
      self$left$to_string(prefix, TRUE)
    }
    if (!is.null(self$right)) {
      self$right$to_string(prefix, FALSE)
    }
  },

  print = function() {
    self$to_string("", FALSE)
  }
))
