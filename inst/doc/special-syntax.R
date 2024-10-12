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
ggheatmap(small_mat) + scale_x_continuous(breaks = c(3, 5))

## ----error=TRUE---------------------------------------------------------------
ggheatmap(small_mat) + scale_x_continuous(breaks = c(3.5, 5))

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
    align_order(index)

## -----------------------------------------------------------------------------
ggheatmap(small_mat) +
    scale_x_continuous(expand = expansion(mult = 0.1)) +
    hmanno("t") +
    align_dendro(aes(color = branch), k = 3L) +
    scale_x_continuous(expand = expansion(mult = 0.1))

## -----------------------------------------------------------------------------
ggheatmap(small_mat) +
    theme(
        axis.text.x = element_text(
            colour = c(rep("red", 4), rep("blue", 5))
        ),
        axis.ticks.x = element_line(
            colour = c(rep("red", 4), rep("blue", 5))
        ),
        axis.ticks.length.x = unit(rep(c(1, 4), times = c(4, 5)), "mm")
    ) +
    hmanno("t") +
    align_dendro(aes(color = branch), k = 3L) +
    scale_y_continuous(expand = expansion()) &
    theme(plot.margin = margin())

## -----------------------------------------------------------------------------
ggheatmap(small_mat) +
    theme(
        axis.text.x = element_text(
            colour = I(c(rep("red", 4), rep("blue", 5)))
        ),
        axis.ticks.x = element_line(
            colour = I(c(rep("red", 4), rep("blue", 5)))
        ),
        axis.ticks.length.x = I(unit(rep(c(1, 4), times = c(4, 5)), "mm"))
    ) +
    hmanno("t") +
    align_dendro(aes(color = branch), k = 3L) +
    scale_y_continuous(expand = expansion()) &
    theme(plot.margin = margin())

## -----------------------------------------------------------------------------
ggheatmap(small_mat) +
    facet_grid(labeller = labeller(.column_panel = function(x) letters[as.integer(x)])) +
    theme(strip.text = element_text()) +
    hmanno("top") +
    align_kmeans(centers = 3L)

## -----------------------------------------------------------------------------
sessionInfo()

