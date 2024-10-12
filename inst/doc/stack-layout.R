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
    ggalign(data = rowSums) +
    geom_bar(aes(value, fill = .panel), orientation = "y", stat = "identity") +
    facet_grid(switch = "y") +
    theme(strip.text = element_text()) +
    align_dendro(aes(color = branch))

## -----------------------------------------------------------------------------
ggstack(small_mat, "v") + align_dendro()

## -----------------------------------------------------------------------------
ggstack(mtcars) +
    ggalign(aes(mpg)) +
    geom_point()

## -----------------------------------------------------------------------------
ggstack(small_mat) +
    ggheatmap()

## -----------------------------------------------------------------------------
ggstack(small_mat, direction = "v") +
    ggheatmap()

## -----------------------------------------------------------------------------
ggstack(small_mat) +
    ggheatmap() +
    scale_fill_viridis_c()

## -----------------------------------------------------------------------------
ggstack(small_mat) +
    ggheatmap() +
    scale_fill_viridis_c() +
    stack_active() +
    ggalign(data = rowSums) +
    geom_bar(aes(value), fill = "red", orientation = "y", stat = "identity")

## -----------------------------------------------------------------------------
ggstack(small_mat, "v") +
    ggheatmap() +
    ggheatmap() &
    scale_fill_viridis_c()

## -----------------------------------------------------------------------------
ggstack(small_mat, "v") +
    ggheatmap() +
    scale_fill_viridis_c() +
    hmanno("l") +
    align_dendro(aes(color = .panel), k = 3L) +
    hmanno("r") +
    ggalign(data = rowSums) +
    geom_bar(aes(value, fill = .panel), orientation = "y", stat = "identity") +
    ggheatmap()

## -----------------------------------------------------------------------------
ggstack(small_mat, "v", c(1, 2, 1)) +
    ggheatmap() +
    scale_fill_viridis_c() +
    hmanno("l") +
    align_dendro(aes(color = .panel), k = 3L) +
    hmanno("r") +
    ggalign(data = rowSums) +
    geom_bar(aes(value, fill = .panel), orientation = "y", stat = "identity") +
    ggheatmap()

## -----------------------------------------------------------------------------
ggstack(small_mat, "v") +
    ggheatmap() +
    scale_fill_viridis_c() +
    hmanno("l") +
    align_dendro(aes(color = .panel), k = 3L) +
    hmanno("r") +
    ggalign(data = rowSums) +
    geom_bar(aes(value, fill = .panel), orientation = "y", stat = "identity") +
    ggheatmap(.width = unit(2, "null"))

## -----------------------------------------------------------------------------
ggstack(small_mat, "v") +
    ggheatmap() +
    scale_fill_viridis_c() +
    hmanno("l", size = unit(2, "cm")) +
    align_dendro(aes(color = .panel), k = 3L) +
    hmanno("r") +
    ggalign(data = rowSums) +
    geom_bar(aes(value, fill = .panel), orientation = "y", stat = "identity") +
    ggheatmap()

## -----------------------------------------------------------------------------
ggstack(small_mat, "v") +
    ggheatmap() +
    scale_fill_viridis_c() +
    hmanno("l", size = unit(0.5, "npc")) +
    align_dendro(aes(color = .panel), k = 3L) +
    hmanno("r") +
    ggalign(data = rowSums) +
    geom_bar(aes(value, fill = .panel), orientation = "y", stat = "identity") +
    ggheatmap()

## -----------------------------------------------------------------------------
sessionInfo()

