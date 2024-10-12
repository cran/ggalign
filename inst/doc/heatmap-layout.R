## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

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

## ----eval=rlang::is_installed("ragg")-----------------------------------------
ggheatmap(small_mat, filling = FALSE) +
  ggrastr::rasterise(geom_tile(aes(fill = value)), dev = "ragg")

## ----eval=rlang::is_installed("ragg")-----------------------------------------
ggrastr::rasterise(ggheatmap(small_mat), dev = "ragg")

## -----------------------------------------------------------------------------
ggheatmap(small_mat) +
  hmanno("t") +
  align_kmeans(3L)

## -----------------------------------------------------------------------------
ggheatmap(small_mat) +
  theme(axis.text.x = element_text(angle = -60, hjust = 0)) +
  hmanno("r") +
  align_dendro(k = 3L) +
  geom_point(aes(color = factor(branch)))

## -----------------------------------------------------------------------------
ggheatmap(small_mat, .height = 2) +
  scale_fill_viridis_c() +
  hmanno("t") +
  align_dendro()

## -----------------------------------------------------------------------------
ggheatmap(small_mat) +
  hmanno(position = NULL, height = 2) +
  scale_fill_viridis_c() +
  hmanno("t") +
  align_dendro()

## -----------------------------------------------------------------------------
ggheatmap(small_mat) +
  scale_fill_viridis_c() +
  hmanno("t", size = 1) +
  align_dendro()

## -----------------------------------------------------------------------------
ggheatmap(small_mat) +
  scale_fill_viridis_c() +
  hmanno("t", size = unit(30, "mm")) +
  align_dendro()

## -----------------------------------------------------------------------------
ggheatmap(small_mat) +
  scale_fill_viridis_c() +
  hmanno("l", size = 0.2) +
  ggalign(data = rowSums, aes(x = value), size = unit(10, "mm")) +
  geom_bar(
    aes(y = .y, fill = factor(.y)),
    stat = "identity",
    orientation = "y"
  ) +
  scale_fill_brewer(palette = "Set1", guide = "none")

## ----fig.dim = c(12, 12)------------------------------------------------------
heatmap_with_four_side_guides <- ggheatmap(small_mat) +
  scale_fill_viridis_c(name = "I'm from heatmap body") +
  theme(axis.text.x = element_text(angle = -60, hjust = 0)) +
  hmanno("t") +
  align_dendro(aes(color = branch), k = 3L) +
  scale_color_brewer(
    name = "I'm from top annotation", palette = "Dark2",
    guide = guide_legend(position = "right")
  ) +
  hmanno("l") +
  align_dendro(aes(color = branch), k = 3L) +
  scale_color_brewer(
    name = "I'm from left annotation", palette = "Dark2",
    guide = guide_legend(position = "top")
  ) +
  hmanno("b") +
  align_dendro(aes(color = branch), k = 3L) +
  scale_color_brewer(
    name = "I'm from bottom annotation", palette = "Dark2",
    guide = guide_legend(position = "left")
  ) +
  hmanno("r") +
  align_dendro(aes(color = branch), k = 3L) +
  scale_color_brewer(
    name = "I'm from right annotation", palette = "Dark2",
    guide = guide_legend(position = "bottom")
  ) &
  theme(plot.margin = margin())
heatmap_with_four_side_guides

## ----heatmap-guides-tb, fig.dim = c(12, 12), fig.cap="Heatmap collect top and bottom guides only"----
heatmap_with_four_side_guides +
  # the heatmap layout only collect guide legends in the top and bottom
  hmanno(guides = "tb")

## ----fig.dim = c(12, 12)------------------------------------------------------
heatmap_with_four_side_guides +
  # the left annotation won't collecte the guide legends
  hmanno("l", guides = NULL)

## ----fig.dim = c(12, 12)------------------------------------------------------
heatmap_with_four_side_guides +
  # the heatmap layout only collect guide legends in the top and bottom
  hmanno(guides = "tb") +
  # we override the layout `guides` argument and collect the right guide
  # legend for the heatmap body
  hmanno(free_guides = "r")

## ----fig.dim = c(12, 12)------------------------------------------------------
heatmap_with_four_side_guides +
  # the heatmap layout only collect guide legends in the top and bottom
  hmanno(guides = "tb") +
  # we collect the right guide legend for the right annotation in the heatmap layout
  hmanno("t", free_guides = "r") +
  # we collect the left guide legend for the bottom annotation in the heatmap layout
  hmanno("b", free_guides = "l")

## -----------------------------------------------------------------------------
ggheatmap(small_mat) +
  scale_fill_viridis_c() +
  theme(axis.text.x = element_text(angle = -60, hjust = 0)) +
  hmanno("t") +
  # we won't collect any guide legends from the dendrogram plot
  align_dendro(aes(color = branch), k = 3L, free_guides = NULL) +
  align_dendro(aes(color = branch), k = 3L, free_guides = NULL) &
  scale_color_brewer(
    palette = "Dark2",
    guide = guide_legend(position = "bottom")
  )

## -----------------------------------------------------------------------------
ggheatmap(small_mat) +
  scale_fill_viridis_c() +
  hmanno("t", size = unit(30, "mm")) +
  align_dendro() +
  scale_y_continuous(
    expand = expansion(),
    labels = ~ paste("very very long labels", .x)
  ) +
  hmanno("l", unit(20, "mm")) +
  align_dendro()

## -----------------------------------------------------------------------------
ggheatmap(small_mat) +
  scale_fill_viridis_c() +
  hmanno("t", size = unit(30, "mm"), free_spaces = "l") +
  align_dendro() +
  scale_y_continuous(
    expand = expansion(),
    labels = ~ paste("very very long labels", .x)
  ) +
  hmanno("l", unit(20, "mm")) +
  align_dendro()

## ----fig.dim = c(12, 12)------------------------------------------------------
heatmap_with_four_side_guides +
  hmanno(guides = "tb") + # we set the `guides` argument here
  hmanno("t", free_spaces = "r") + # we remove the right border spaces
  hmanno("b", free_spaces = "l") # we remove the left border spaces

## -----------------------------------------------------------------------------
ggheatmap(small_mat) +
  scale_fill_viridis_c() +
  hmanno("t", size = unit(30, "mm")) +
  align_dendro(free_labs = "l") +
  scale_y_continuous(
    expand = expansion(),
    labels = ~ paste("very very long labels", .x)
  ) +
  hmanno("l", unit(20, "mm")) +
  align_dendro()

## -----------------------------------------------------------------------------
ggheatmap(small_mat) +
  scale_fill_viridis_c() +
  ylab("Heatmap title") +
  hmanno("t", size = unit(30, "mm")) +
  align_dendro() +
  ylab("Annotation title")

## -----------------------------------------------------------------------------
ggheatmap(small_mat) +
  hmanno(free_labs = NULL) +
  scale_fill_viridis_c() +
  ylab("Heatmap title") +
  hmanno("t", size = unit(30, "mm")) +
  align_dendro() +
  ylab("Annotation title")

## -----------------------------------------------------------------------------
sessionInfo()

