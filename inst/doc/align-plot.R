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
  scale_fill_viridis_c(guide = "none") +
  hmanno("t") +
  ggalign(data = rowSums) +
  geom_point(aes(y = value))

## -----------------------------------------------------------------------------
ggheatmap(small_mat) +
  scale_fill_viridis_c(guide = "none") +
  hmanno("t") +
  align_kmeans(3L) +
  ggalign(plot_data = function(data) subset(data, .panel == 1L)) +
  geom_bar(aes(y = value, fill = .row_names), stat = "identity")

## ----fig.dim = c(5, 10)-------------------------------------------------------
set.seed(1L)
v <- stats::rnorm(50L)
split <- sample(letters[1:2], 50L, replace = TRUE)
ggheatmap(v) +
  scale_fill_viridis_c() +
  theme(strip.text = element_text(), strip.background = element_rect()) +
  hmanno("r") +
  align_group(split) +
  hmanno("t", size = 0.5) +
  ggalign(limits = FALSE) +
  geom_boxplot(aes(.extra_panel, value, fill = .extra_panel),
    # here, we use `print()` to show the underlying data
    data = function(data) {
      print(head(data))
      data
    }
  ) +
  # the default will always use continuous scale, here, we override it, since
  # the panel is a factor variable, we should use discrete scale.
  scale_x_discrete() +
  scale_fill_brewer(palette = "Dark2", name = "branch")

## -----------------------------------------------------------------------------
ggheatmap(small_mat) +
  hmanno("t") +
  align_dendro(aes(color = branch), k = 3L) +
  scale_color_brewer(palette = "Dark2") +
  hmanno("r", size = 0.5) +
  ggalign(limits = FALSE) +
  geom_boxplot(aes(y = .extra_panel, x = value, fill = factor(.extra_panel))) +
  # the default will always use continuous scale, here, we override it, since
  # the panel is a factor variable, we should use discrete scale.
  scale_y_discrete() +
  scale_fill_brewer(palette = "Dark2", name = "branch") +
  theme(axis.text.x = element_text(angle = -60, hjust = 0))

## -----------------------------------------------------------------------------
ggheatmap(small_mat) +
  patch_titles(left = "left patch title", bottom = "bottom patch title") +
  hmanno("t") +
  align_dendro(aes(color = branch), k = 3L) +
  scale_color_brewer(palette = "Dark2") +
  patch_titles(top = "top patch title") +
  hmanno("r", size = 0.5) +
  ggalign(limits = FALSE) +
  geom_boxplot(aes(y = .extra_panel, x = value, fill = factor(.extra_panel))) +
  scale_y_discrete() +
  scale_fill_brewer(palette = "Dark2", name = "branch") +
  theme(axis.text.x = element_text(angle = -60, hjust = 0)) +
  patch_titles(right = "right patch title")

## -----------------------------------------------------------------------------
ggheatmap(small_mat) +
  hmanno("t", size = unit(1, "cm")) +
  align_kmeans(centers = 3L) +
  ggpanel() +
  geom_tile(aes(y = 1L, fill = .panel, color = .panel),
    width = 1L, height = 1L
  ) +
  geom_text(aes(y = 1L, label = .panel),
    data = function(data) {
      aggregate(.x ~ .panel, data, FUN = median)
    }
  )

## -----------------------------------------------------------------------------
sessionInfo()

