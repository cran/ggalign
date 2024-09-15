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

## ----align_group_top----------------------------------------------------------
ggheatmap(small_mat) +
  hmanno("t") +
  align_group(sample(letters[1:4], ncol(small_mat), replace = TRUE))

## ----align_group_left---------------------------------------------------------
ggheatmap(small_mat) +
  theme(strip.text = element_text()) +
  hmanno("l") +
  align_group(sample(letters[1:4], nrow(small_mat), replace = TRUE))

## ----align_reorder------------------------------------------------------------
ggheatmap(small_mat) +
  hmanno("l") +
  align_reorder(rowMeans)

## ----align_reorder_decreasing-------------------------------------------------
ggheatmap(small_mat) +
  hmanno("l") +
  align_reorder(rowMeans, decreasing = TRUE)

## -----------------------------------------------------------------------------
ggheatmap(small_mat) +
  hmanno("t") +
  align_reorder(rowMeans)

## -----------------------------------------------------------------------------
ggheatmap(small_mat) +
  hmanno("t") +
  align_kmeans(3L)

## ----error=TRUE---------------------------------------------------------------
ggheatmap(small_mat) +
  hmanno("t") +
  align_group(sample(letters[1:4], ncol(small_mat), replace = TRUE)) +
  align_kmeans(3L)

## ----error=TRUE---------------------------------------------------------------
ggheatmap(small_mat) +
  hmanno("t") +
  align_kmeans(3L) +
  align_group(sample(letters[1:4], ncol(small_mat), replace = TRUE))

## ----align_dendro-------------------------------------------------------------
ggheatmap(small_mat) +
  hmanno("t") +
  align_dendro()

## ----align_dendro_distance_pearson--------------------------------------------
ggheatmap(small_mat) +
  hmanno("t") +
  align_dendro(distance = "pearson") +
  patch_titles(top = "pre-defined distance method (1 - pearson)")

## ----align_dendro_distance_function-------------------------------------------
ggheatmap(small_mat) +
  hmanno("t") +
  align_dendro(distance = function(m) dist(m)) +
  patch_titles(top = "a function that calculates distance matrix")

## -----------------------------------------------------------------------------
ggheatmap(small_mat) +
  hmanno("t") +
  align_dendro(method = "ward.D2")

## -----------------------------------------------------------------------------
ggheatmap(small_mat) +
  hmanno("t") +
  align_dendro(k = 3L)

## -----------------------------------------------------------------------------
ggheatmap(small_mat) +
  hmanno("t") +
  align_dendro() +
  geom_point(aes(y = y))

## -----------------------------------------------------------------------------
ggheatmap(small_mat) +
  hmanno("t") +
  align_dendro(aes(color = branch), k = 3) +
  geom_point(aes(color = branch, y = y))

## -----------------------------------------------------------------------------
column_groups <- sample(letters[1:3], ncol(small_mat), replace = TRUE)
ggheatmap(small_mat) +
  hmanno("t") +
  align_group(column_groups) +
  align_dendro(aes(color = branch))

## -----------------------------------------------------------------------------
ggheatmap(small_mat) +
  hmanno("t") +
  align_group(column_groups) +
  align_dendro(aes(color = branch), reorder_group = TRUE)

## -----------------------------------------------------------------------------
ggheatmap(small_mat) +
  hmanno("t") +
  align_group(column_groups) +
  align_dendro(aes(color = branch), reorder_group = TRUE) +
  hmanno("b") +
  align_dendro(aes(color = branch), reorder_group = FALSE)

## -----------------------------------------------------------------------------
sessionInfo()

