## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
    collapse = TRUE,
    comment = "#>"
)

## ----setup--------------------------------------------------------------------
library(ggalign)

## ----setup_data---------------------------------------------------------------
set.seed(123)
small_mat <- matrix(rnorm(56), nrow = 8)
rownames(small_mat) <- paste0("row", seq_len(nrow(small_mat)))
colnames(small_mat) <- paste0("column", seq_len(ncol(small_mat)))

## -----------------------------------------------------------------------------
# Initialize the heatmap; by default, no active annotation will be set.
# The active layout is the heatmap layout, and the active plot in the layout is
# the main plot.
ggheatmap(small_mat) +
    # Add elements to the main plot
    scale_fill_viridis_c() +
    # Change the active layout to the left annotation
    anno_left(size = 0.2) +
    # Add a dendrogram in the left annotation
    align_dendro() +
    # Change the active layout to the right annotation
    anno_right(size = 0.2) +
    # Add a dendrogram in the right annotation
    align_dendro()

## -----------------------------------------------------------------------------
stack_alignh(small_mat) +
    # the dendrogram will be added to the stack
    align_dendro() +
    # Add elements to the dendrogram
    geom_point() +
    # add a heamtap layout to the stack
    ggheatmap() +
    # the active layout is the heamtap layout
    # so following elements will be added to the heatmap layout
    theme(axis.text.x = element_text(angle = -60, hjust = 0)) +
    anno_right() +
    align_dendro()

## -----------------------------------------------------------------------------
# Initialize the heatmap with color scales and annotations.
ggheatmap(small_mat) +
    scale_fill_viridis_c() +
    anno_left(size = 0.2) +
    # Add a dendrogram in the left annotation and split the dendrogram into 3 groups
    align_dendro(aes(color = branch), k = 3L) +
    anno_right(size = 0.2) +
    # Add a dendrogram in the right annotation and split the dendrogram into 3 groups
    align_dendro(aes(color = branch), k = 3L) &
    # Set color scale for all plots
    scale_color_brewer(palette = "Dark2")

## -----------------------------------------------------------------------------
# Initialize the heatmap
ggheatmap(small_mat) +
    scale_fill_viridis_c() +
    anno_left(size = 0.2) +
    align_dendro(aes(color = branch), k = 3L) +
    anno_right(size = 0.2) +
    align_dendro(aes(color = branch), k = 3L) +
    # Remove any active annotation
    quad_active() -
    # Set color scale for all plots, since the active layout is the `ggheatmap()`/`quad_layout()`
    scale_color_brewer(palette = "Dark2")

## -----------------------------------------------------------------------------
ggheatmap(small_mat) +
    scale_fill_viridis_c() +
    anno_left(size = 0.2) +
    align_dendro(aes(color = branch), k = 3L) +
    align_dendro(aes(color = branch), k = 3L) -
    # Modify the the color scales of all plots in the left annotation
    scale_color_brewer(palette = "Dark2")

## -----------------------------------------------------------------------------
stack_alignv(small_mat) +
    align_dendro() +
    ggtitle("I'm from the parent stack") +
    ggheatmap() +
    # remove any active context
    stack_active() +
    align_dendro() +
    ggtitle("I'm from the parent stack") -
    # Modify the the color scales of all plots in the stack layout except the heatmap layout
    scale_color_brewer(palette = "Dark2") -
    # set the background of all plots in the stack layout except the heatmap layout
    theme(plot.background = element_rect(fill = "red"))

## -----------------------------------------------------------------------------
ggheatmap(small_mat) +
    scale_fill_viridis_c() +
    anno_left(size = 0.2) +
    align_dendro(aes(color = branch), k = 3L) +
    # Change the active layout to the left annotation
    anno_top(size = 0.2) +
    align_dendro(aes(color = branch), k = 3L) +
    anno_bottom(size = 0.2) +
    align_dendro(aes(color = branch), k = 3L) -
    # Modify the color scale of all plots in the bottom and the opposite annotation
    # in this way, the `main` argument by default would be `TRUE`
    with_quad(scale_color_brewer(palette = "Dark2", name = "Top and bottom"))

## -----------------------------------------------------------------------------
ggheatmap(small_mat) +
    scale_fill_viridis_c() +
    anno_left(size = 0.2) +
    align_dendro(aes(color = branch), k = 3L) +
    anno_top(size = 0.2) +
    align_dendro(aes(color = branch), k = 3L) +
    anno_bottom(size = 0.2) +
    align_dendro(aes(color = branch), k = 3L) -
    # Modify the background of all plots in the left and top annotation
    with_quad(theme(plot.background = element_rect(fill = "red")), "tl")

## -----------------------------------------------------------------------------
ggheatmap(small_mat) +
    scale_fill_viridis_c() +
    anno_left(size = 0.2) +
    align_dendro(aes(color = branch), k = 3L) +
    anno_top(size = 0.2) +
    align_dendro(aes(color = branch), k = 3L) +
    anno_bottom(size = 0.2) +
    align_dendro(aes(color = branch), k = 3L) -
    # Modify the background of all plots
    with_quad(theme(plot.background = element_rect(fill = "red")), NULL)

## -----------------------------------------------------------------------------
stack_alignv(small_mat) +
    align_dendro() +
    ggtitle("I'm from the parent stack") +
    ggheatmap() +
    anno_top() +
    align_dendro() +
    ggtitle("I'm from the nested heatmap") +
    # remove any active context
    stack_active() +
    align_dendro() +
    ggtitle("I'm from the parent stack") -
    # Modify the the color scales of all plots in the stack layout except the heatmap layout
    scale_color_brewer(palette = "Dark2") -
    # set the background of all plots in the stack layout (including plots in the heatmap layout)
    with_quad(theme(plot.background = element_rect(fill = "red")))

## -----------------------------------------------------------------------------
sessionInfo()

