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
ggheatmap(small_mat) + scale_x_continuous(limits = c(0, 0))

## -----------------------------------------------------------------------------
ggheatmap(small_mat) + scale_x_continuous(breaks = NULL)

## -----------------------------------------------------------------------------
ggheatmap(small_mat) + scale_x_continuous()

## -----------------------------------------------------------------------------
no_names <- small_mat
colnames(no_names) <- NULL
ggheatmap(no_names) + scale_x_continuous()

## -----------------------------------------------------------------------------
ggheatmap(small_mat) + scale_x_continuous(breaks = c("column3", "column5"))

## -----------------------------------------------------------------------------
ggheatmap(small_mat) + scale_x_continuous(breaks = 5:6)

## -----------------------------------------------------------------------------
ggheatmap(small_mat) + scale_x_continuous(labels = NULL)

## -----------------------------------------------------------------------------
ggheatmap(small_mat) + scale_x_continuous()

## -----------------------------------------------------------------------------
ggheatmap(small_mat) +
  scale_x_continuous(labels = letters[seq_len(ncol(small_mat))])

## -----------------------------------------------------------------------------
ggheatmap(small_mat) +
  scale_x_continuous(breaks = c(3, 5), labels = c("a", "b"))

## -----------------------------------------------------------------------------
index <- order(colMeans(small_mat))
xlabels <- letters[seq_len(ncol(small_mat))]
print(xlabels[index])

ggheatmap(small_mat) +
  scale_x_continuous(labels = xlabels) +
  hmanno("t") +
  align_reorder()

## -----------------------------------------------------------------------------
ggheatmap(small_mat) +
  scale_x_discrete(breaks = c(3, 5), labels = c("a", "b")) +
  hmanno("t") +
  align_dendro() +
  scale_x_discrete()

## -----------------------------------------------------------------------------
ggheatmap(small_mat) +
  scale_x_discrete(breaks = c(3, 5), labels = c("a", "b")) +
  hmanno("t") +
  align_dendro() +
  scale_x_discrete(expand = expansion(add = 0.5))

## -----------------------------------------------------------------------------
ggheatmap(small_mat) +
  scale_x_discrete(breaks = c(3, 5), labels = c("a", "b")) +
  hmanno("t") +
  align_dendro()

## -----------------------------------------------------------------------------
ggheatmap(small_mat) +
  hmanno("l") +
  ggalign() +
  geom_bar(aes(x = value), stat = "identity") +
  theme(axis.text.x = element_text(angle = -60, hjust = 0))

## -----------------------------------------------------------------------------
ggheatmap(small_mat) +
  hmanno("l") +
  ggalign() +
  geom_bar(aes(x = value), stat = "identity", orientation = "y") +
  theme(axis.text.x = element_text(angle = -60, hjust = 0))

## -----------------------------------------------------------------------------
ggheatmap(small_mat) +
  hmanno("l") +
  ggalign() +
  geom_bar(aes(x = value), stat = "identity") +
  scale_y_discrete() +
  theme(axis.text.x = element_text(angle = -60, hjust = 0))

## -----------------------------------------------------------------------------
ggheatmap(small_mat) +
  facet_grid(labeller = labeller(.column_panel = function(x) letters[as.integer(x)])) +
  theme(strip.text = element_text()) +
  hmanno("top") +
  align_kmeans(centers = 3L)

## -----------------------------------------------------------------------------
sessionInfo()

