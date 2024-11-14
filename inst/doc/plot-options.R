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
ggheatmap(small_mat) +
    # change the default theme of the heatmap body
    plot_theme(plot.background = element_rect(fill = "red"))

## -----------------------------------------------------------------------------
ggheatmap(small_mat, filling = FALSE) +
    geom_tile(aes(fill = value), width = 0.9, height = 0.9) +
    # change the default theme of the heatmap body
    plot_theme(theme_bw(), plot.background = element_rect(fill = "red"))

## -----------------------------------------------------------------------------
ggheatmap(small_mat) +
    # change the plot theme of the heatmap body
    theme(plot.background = element_rect(fill = "blue")) +
    # change the default theme of the heatmap body
    plot_theme(plot.background = element_rect(fill = "red"))

## -----------------------------------------------------------------------------
ggheatmap(small_mat) +
    # Change the active layout to the top annotation
    anno_top() +
    # add a dendrogram to the top annotation
    align_dendro() +
    # add a bar plot to the top annotation
    ggalign(aes(.names, value, fill = factor(.names)), data = rowSums) +
    geom_bar(stat = "identity") -
    # Change the default theme of the top annotation
    # All plots in the top annotation will inherit this default theme
    plot_theme(plot.background = element_rect(fill = "red"))

## -----------------------------------------------------------------------------
ggheatmap(small_mat) +
    # Change the active layout to the top annotation
    anno_top() +
    # add a dendrogram to the top annotation
    align_dendro() +
    # change the plot_theme for the dendrogram plot
    plot_theme(plot.background = element_rect(fill = "blue")) +
    # add a bar plot to the top annotation
    ggalign(aes(.names, value, fill = factor(.names)), data = rowSums) +
    geom_bar(stat = "identity") -
    # Change the default theme of the top annotation
    # All plots in the top annotation will inherit this default theme
    # But the plot-specific options will override these
    plot_theme(plot.background = element_rect(fill = "red"))

## -----------------------------------------------------------------------------
set.seed(1234L)
ggheatmap(small_mat) +
    anno_top() +
    align_kmeans(3L) +
    # we add a bar plot
    ggalign() +
    # we subest the plot data
    plot_data(~ subset(.x, .panel == 1L)) +
    geom_bar(aes(y = value, fill = .row_names), stat = "identity")

## ----fig.dim = c(12, 12)------------------------------------------------------
heatmap_collect_all_guides <- ggheatmap(small_mat, width = 2, height = 2L) +
    scale_fill_viridis_c(name = "I'm from heatmap body") +
    theme(axis.text.x = element_text(angle = -60, hjust = 0)) +
    anno_top() +
    align_dendro(aes(color = branch), k = 3L) +
    scale_color_brewer(
        name = "I'm from top annotation", palette = "Dark2",
        guide = guide_legend(position = "right")
    ) +
    anno_left() +
    align_dendro(aes(color = branch), k = 3L) +
    scale_color_brewer(
        name = "I'm from left annotation", palette = "Dark2",
        guide = guide_legend(position = "top", direction = "vertical")
    ) +
    anno_bottom() +
    align_dendro(aes(color = branch), k = 3L) +
    scale_color_brewer(
        name = "I'm from bottom annotation", palette = "Dark2",
        guide = guide_legend(position = "left")
    ) +
    anno_right() +
    align_dendro(aes(color = branch), k = 3L) +
    scale_color_brewer(
        name = "I'm from right annotation", palette = "Dark2",
        guide = guide_legend(position = "bottom", direction = "vertical")
    ) &
    theme(plot.margin = margin())
heatmap_collect_all_guides

## ----fig.dim = c(12, 12)------------------------------------------------------
heatmap_collect_all_guides +
    # reset the active context to the heatmap layout
    quad_active() -
    # we set global `guides` argument for the heatmap layout
    # we only collect guides in the top and bottom side
    plot_align(guides = "tb")

## ----fig.dim = c(12, 12)------------------------------------------------------
heatmap_collect_all_guides +
    # reset the active context to the heatmap layout
    quad_active() -
    # we set global `guides` argument for the heatmap layout
    # we only collect guides in the top and bottom side
    plot_align(guides = "tb") +
    # `+` apply it to the current active plot
    # for the heatmap body, we collect guide in the right side
    plot_align(guides = "r")

## ----fig.dim = c(12, 12)------------------------------------------------------
heatmap_collect_all_guides +
    # reset the active context to the heatmap layout
    quad_active() -
    # we set global `guides` argument for the heatmap layout
    # we only collect guides in the top and bottom side
    plot_align(guides = "tb") +
    # we ensure the active context is in the bottom annotation
    # By default, it inherits "guides" argument from the heamtap layout, which
    # means it'll collect "guides" in the top and bottom side
    anno_bottom() +
    # for the dendrogram in the bottom annotation, we collect guide in the left side
    plot_align(guides = "l")

## ----fig.dim = c(12, 12)------------------------------------------------------
heatmap_collect_all_guides +
    # reset the active context to the heatmap layout
    quad_active() -
    # we set global `guides` argument for the heatmap layout
    # we only collect guides in the top and bottom side
    plot_align(guides = "tb") +
    # we also collect guides in the left side for the bottom annotation stack
    # layout in the heatmap layout
    anno_bottom(free_guides = "l") +
    # for the dendrogram in the bottom annotation, we collect guide in the left side
    plot_align(guides = "l")

## -----------------------------------------------------------------------------
ggheatmap(small_mat) +
    scale_fill_viridis_c() +
    anno_top(size = unit(30, "mm")) +
    align_dendro() +
    scale_y_continuous(
        expand = expansion(),
        labels = ~ paste("very very long labels", .x)
    ) +
    anno_left(unit(20, "mm")) +
    align_dendro()

## -----------------------------------------------------------------------------
ggheatmap(small_mat) +
    scale_fill_viridis_c() +
    anno_top(size = unit(30, "mm")) -
    plot_align(free_spaces = "l") +
    align_dendro() +
    scale_y_continuous(
        expand = expansion(),
        labels = ~ paste("very long labels", .x)
    ) +
    anno_left(unit(20, "mm")) +
    align_dendro()

## ----fig.dim = c(12, 12)------------------------------------------------------
heatmap_collect_all_guides +
    # we only collect guides in the top and bottom side
    quad_active() -
    plot_align(guides = "tb") +
    # 1. in the bottom annotation stack layout, we collect the legends in the
    #    left side
    # 2. we remove the spaces of the left border in the annotation
    anno_bottom() -
    plot_align(guides = "l", free_spaces = "l")

## -----------------------------------------------------------------------------
ggheatmap(small_mat) +
    scale_fill_viridis_c() +
    ylab("Heatmap title") +
    anno_top(size = unit(30, "mm")) +
    align_dendro() +
    ylab("Annotation title")

## -----------------------------------------------------------------------------
ggheatmap(small_mat) -
    plot_align(free_labs = NULL) +
    scale_fill_viridis_c() +
    ylab("Heatmap title") +
    anno_top(size = unit(30, "mm")) +
    align_dendro() +
    ylab("Annotation title")

## -----------------------------------------------------------------------------
sessionInfo()

