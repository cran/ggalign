params <-
list(mode = "release", release = "https://yunuuuu.github.io/ggalign", 
    devel = "https://yunuuuu.github.io/ggalign/dev")

## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
    collapse = TRUE,
    comment = "#>"
)

## ----echo=FALSE---------------------------------------------------------------
mode <- params$mode
url <- params[[mode]]

## ----setup_data---------------------------------------------------------------
set.seed(123)
small_mat <- matrix(rnorm(81), nrow = 9)
rownames(small_mat) <- paste0("row", seq_len(nrow(small_mat)))
colnames(small_mat) <- paste0("column", seq_len(ncol(small_mat)))

## ----matrix-------------------------------------------------------------------
library(ggalign)
ggheatmap(small_mat)

## -----------------------------------------------------------------------------
ggheatmap(small_mat) + geom_point() + scale_fill_viridis_c()

## -----------------------------------------------------------------------------
ggheatmap(small_mat, filling = "raster")

## -----------------------------------------------------------------------------
ggheatmap(small_mat, filling = "tile")

## -----------------------------------------------------------------------------
ggheatmap(small_mat, filling = NULL) +
    geom_tile(aes(fill = value), color = "black", width = 0.9, height = 0.9)

## -----------------------------------------------------------------------------
set.seed(123)
ggheatmap(matrix(runif(360L), nrow = 20L), filling = NULL) +
    geom_pie(aes(angle = value * 360, fill = value))

## ----eval=rlang::is_installed("ragg")-----------------------------------------
ggheatmap(small_mat, filling = FALSE) +
    ggrastr::rasterise(geom_tile(aes(fill = value)), dev = "ragg")

## ----eval=rlang::is_installed("ragg")-----------------------------------------
ggrastr::rasterise(ggheatmap(small_mat), dev = "ragg")

## -----------------------------------------------------------------------------
ggheatmap(small_mat) +
    # we set the active context to the top annotation
    anno_top() +
    # we split the observations into 3 groups by kmeans
    align_kmeans(3L)

## -----------------------------------------------------------------------------
ggheatmap(small_mat) +
    # in the heatmap body, we set the axis text theme
    theme(axis.text.x = element_text(angle = -60, hjust = 0)) +
    # we set the active context to the right annotation
    anno_right() +
    # in the right annotation, we add a dendrogram
    align_dendro(k = 3L) +
    # in the dendrogram, we add a point layer
    geom_point(aes(color = factor(branch)))

## -----------------------------------------------------------------------------
ggheatmap(small_mat) +
    # we set the active context to the top annotation
    anno_top() +
    # we split the observations into 3 groups by kmeans
    align_kmeans(3L) +
    # remove any active annotation
    quad_active() +
    # set fill color scale for the heatmap body
    scale_fill_viridis_c()

## -----------------------------------------------------------------------------
ggheatmap(small_mat) +
    # we set the active context to the top annotation
    quad_switch("t") +
    # we split the observations into 3 groups by kmeans
    align_kmeans(3L) +
    # remove any active annotation
    quad_switch() +
    # set fill color scale for the heatmap body
    scale_fill_viridis_c()

## -----------------------------------------------------------------------------
ggheatmap(small_mat) +
    # we set the active context to the top annotation
    hmanno("t") +
    # we split the observations into 3 groups by kmeans
    align_kmeans(3L) +
    # remove any active annotation
    hmanno() +
    # set fill color scale for the heatmap body
    scale_fill_viridis_c()

## -----------------------------------------------------------------------------
ggheatmap(small_mat, height = 2) +
    scale_fill_viridis_c() +
    anno_top() +
    align_dendro()

## -----------------------------------------------------------------------------
ggheatmap(small_mat) +
    quad_active(height = 2) +
    scale_fill_viridis_c() +
    anno_top() +
    align_dendro()

## -----------------------------------------------------------------------------
ggheatmap(small_mat) +
    scale_fill_viridis_c() +
    anno_top(size = 1) +
    align_dendro()

## -----------------------------------------------------------------------------
ggheatmap(small_mat) +
    scale_fill_viridis_c() +
    anno_top(size = unit(30, "mm")) +
    align_dendro()

## -----------------------------------------------------------------------------
ggheatmap(small_mat) +
    scale_fill_viridis_c() +
    anno_left(size = 0.2) +
    ggalign(data = rowSums, aes(x = value), size = unit(10, "mm")) +
    geom_bar(
        aes(y = .y, fill = factor(.y)),
        stat = "identity", orientation = "y"
    ) +
    scale_fill_brewer(palette = "Set1", guide = "none")

## -----------------------------------------------------------------------------
sessionInfo()

