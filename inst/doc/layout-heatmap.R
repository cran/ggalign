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

## ----matrix-------------------------------------------------------------------
ggheatmap(small_mat)

## -----------------------------------------------------------------------------
ggheatmap(small_mat) + geom_point() + scale_fill_viridis_c()

## -----------------------------------------------------------------------------
ggheatmap(small_mat, filling = FALSE)

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
ggheatmap(small_mat) +
  scale_fill_viridis_c() +
  hmanno(height = 1) +
  hmanno("t", size = 2) +
  align_dendro() +
  ggalign(data = rowSums) +
  geom_bar(aes(y = value, fill = .x), stat = "identity")

## -----------------------------------------------------------------------------
ggheatmap(small_mat) +
  scale_fill_viridis_c() +
  hmanno("t", size = 1) +
  align_dendro() +
  ggalign(data = rowSums) +
  geom_bar(aes(y = value, fill = .x), stat = "identity")

## -----------------------------------------------------------------------------
ggheatmap(small_mat) +
  scale_fill_viridis_c() +
  hmanno("t", size = unit(30, "mm")) +
  align_dendro() +
  ggalign(data = rowSums) +
  geom_bar(aes(y = value, fill = .x), stat = "identity")

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
  scale_fill_brewer(palette = "Set1", guide = "none") +
  scale_x_reverse()

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
ggheatmap(small_mat) +
  hmanno(free_labs = NULL) +
  scale_fill_viridis_c() +
  ylab("Heatmap title") +
  hmanno("t", size = unit(30, "mm"), free_labs = "l") +
  align_dendro() +
  ylab("Annotation title")

## -----------------------------------------------------------------------------
ggheatmap(small_mat) +
  scale_fill_viridis_c() +
  hmanno("t", size = unit(30, "mm")) +
  align_dendro() +
  scale_y_continuous(
    expand = expansion(),
    labels = ~ paste("very very long labels", .x)
  ) +
  hmanno("l") +
  align_dendro() +
  scale_x_reverse(expand = expansion())

## -----------------------------------------------------------------------------
ggheatmap(small_mat) +
  scale_fill_viridis_c() +
  hmanno("t", size = unit(30, "mm"), free_spaces = "l") +
  align_dendro() +
  scale_y_continuous(
    expand = expansion(),
    labels = ~ paste("very very long labels", .x)
  ) +
  hmanno("l") +
  align_dendro() +
  scale_x_reverse(expand = expansion())

## -----------------------------------------------------------------------------
sessionInfo()

