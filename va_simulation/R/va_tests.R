
source("R/random_variable_generator.R")
source("R/distribution.R")

library(tictoc)


#' Test a simulation of a v.a
#'
#' @param freqs The frequencies vector.
#' @param plot If TRUE show the plot.
#'
#' @return Nothing.
#' @export
tests_random_va <- function(freqs, plot = TRUE) {
  symbols <- seq_along(freqs)
  tic("Total")

  tic("Encodage")
  tree <- generate_va(freqs)
  toc()

  ent <- get_entropy(freqs)
  afb <- tree$average_fair_bits()

  sample_size <- 10000

  tic("Decodage")
  msg_encoded <- rbinom(afb * sample_size, 1, 0.5)
  msg_decoded <- decode(tree, msg_encoded)
  toc()
  toc()

  tic("R sample")
  sample_size <- length(msg_decoded)
  sample <- sample(x = symbols, sample_size, replace = TRUE, prob = freqs)
  toc()

  cat("Entropie         = ", ent, "\n")
  cat("Longueur moyenne = ", afb, "\n")

  if (plot) {
    par(mfrow = c(1, 2))
    if (length(symbols) <= 15) {
      plot_va(symbols, extract_freqs(msg_decoded), "red", "Fair Coins")
      plot_va(symbols, extract_freqs(sample), "blue", "R sample")
    } else {
      hist_va(symbols, msg_decoded, "dark red", "Fair Coins")
      hist_va(symbols, sample, "dark blue", "R sample")
    }
  }
}

plot_va <- function(symbols, freqs, color, title) {
  plot(seq_along(symbols), freqs, type = "h",
       xlim = c(.5, length(symbols) + .5), ylim = c(0, .6),
       lwd = 2, col = color,
       xlab = "value", ylab = "prob", main = title)
  points(seq_along(symbols), freqs, pch = 16, cex = 1, col = "black")
  text(seq_along(symbols), freqs, labels = sprintf("%.4f", freqs),
       cex = .6, adj = c(-.5, .5), col = color, srt = 90)
}

hist_va <- function(symbols, sample, color, title) {
  hist(as.numeric(sample), col = color, breaks = "FD", main = title,
       plot = TRUE, xlab = "value", ylab = "count")
}

extract_freqs <- function(sample) {
  as.data.frame(prop.table(table(sample)))$Freq
}
