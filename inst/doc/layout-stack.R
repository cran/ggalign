## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----setup--------------------------------------------------------------------
library(ggalign)

## ----setup_data---------------------------------------------------------------
set.seed(123)
small_mat <- matrix(rnorm(81), nrow = 9)
rownames(small_mat) <- paste0("row", seq_len(nrow(small_mat)))
colnames(small_mat) <- paste0("column", seq_len(ncol(small_mat)))

## -----------------------------------------------------------------------------
ggstack(small_mat)

## -----------------------------------------------------------------------------
ggstack(small_mat) + align_dendro()

## -----------------------------------------------------------------------------
ggstack(small_mat) +
  align_kmeans(centers = 3L) +
  ggalign(rowSums) +
  geom_bar(aes(value, fill = .panel), orientation = "y", stat = "identity") +
  facet_grid(switch = "y") +
  theme(strip.text = element_text()) +
  align_dendro(aes(color = branch))

## -----------------------------------------------------------------------------
ggstack(small_mat, "v") + align_dendro()

## -----------------------------------------------------------------------------
ggstack(mtcars) +
  ggalign(mapping = aes(mpg)) +
  geom_point()

## -----------------------------------------------------------------------------
sessionInfo()

