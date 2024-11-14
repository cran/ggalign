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
    anno_top() +
    ggalign(data = rowSums) +
    geom_point(aes(y = value))

## -----------------------------------------------------------------------------
ggheatmap(small_mat) +
    anno_top(size = unit(1, "cm")) +
    align_kmeans(centers = 3L) +
    ggalign(data = NULL) +
    plot_data(~ aggregate(.x ~ .panel, .x, FUN = median)) +
    geom_tile(aes(y = 1L, fill = .panel, color = .panel)) +
    geom_text(aes(y = 1L, label = .panel))

## ----fig.dim = c(5, 10)-------------------------------------------------------
set.seed(1L)
v <- stats::rnorm(50L)
split <- sample(letters[1:2], 50L, replace = TRUE)
ggheatmap(v) +
    scale_fill_viridis_c() +
    theme(strip.text = element_text(), strip.background = element_rect()) +
    anno_right() +
    align_group(split) +
    anno_top(size = 0.5) +
    ggalign(limits = FALSE) +
    geom_boxplot(aes(.extra_panel, value, fill = .extra_panel),
        # here, we use `print()` to show the underlying data
        data = function(data) {
            print(head(data))
            data
        }
    ) +
    scale_fill_brewer(palette = "Dark2", name = "branch")

## -----------------------------------------------------------------------------
ggheatmap(small_mat) +
    theme(axis.text.x = element_text(angle = -60, hjust = 0)) +
    anno_top() +
    align_dendro(aes(color = branch), k = 3L) +
    scale_color_brewer(palette = "Dark2") +
    anno_right(size = 0.5) +
    ggalign(limits = FALSE) +
    geom_boxplot(aes(y = .extra_panel, x = value, fill = factor(.extra_panel))) +
    scale_fill_brewer(palette = "Dark2", name = "branch")

## -----------------------------------------------------------------------------
ggheatmap(small_mat) +
    patch_titles(left = "left patch title", bottom = "bottom patch title") +
    theme(axis.text.x = element_text(angle = -60, hjust = 0)) +
    anno_top() +
    align_dendro(aes(color = branch), k = 3L) +
    scale_color_brewer(palette = "Dark2") +
    patch_titles(top = "top patch title") +
    anno_right(size = 0.5) +
    ggalign(limits = FALSE) +
    geom_boxplot(aes(y = .extra_panel, x = value, fill = factor(.extra_panel))) +
    scale_fill_brewer(palette = "Dark2", name = "branch") +
    patch_titles(right = "right patch title")

## -----------------------------------------------------------------------------
ggheatmap(small_mat) +
    anno_top() +
    ggfree(aes(wt, mpg), data = mtcars) +
    geom_point()

## -----------------------------------------------------------------------------
ggside(mpg, aes(displ, hwy, colour = class)) -
    geom_point(size = 2) +
    anno_top(size = 0.3) +
    ggfree() +
    geom_density(aes(displ, y = after_stat(density), colour = class), position = "stack") +
    anno_right(size = 0.3) +
    ggfree() +
    geom_density(aes(x = after_stat(density), hwy, colour = class),
        position = "stack"
    ) +
    theme(axis.text.x = element_text(angle = 90, vjust = .5))

## -----------------------------------------------------------------------------
ggheatmap(small_mat) +
    anno_top() +
    ggfree(data = ggplot(mtcars, aes(wt, mpg))) +
    geom_point()

## -----------------------------------------------------------------------------
ggheatmap(small_mat) +
    anno_top() +
    ggplot(mtcars, aes(wt, mpg)) +
    geom_point()

## -----------------------------------------------------------------------------
library(grid)
ggheatmap(small_mat) +
    anno_top() +
    # `ggwrap()` will create a `ggplot` object, we use `ggfree` to add it into the layout
    ggfree(data = ggwrap(rectGrob(gp = gpar(fill = "goldenrod")), align = "full"))

## -----------------------------------------------------------------------------
ggheatmap(small_mat) +
    anno_top() +
    ggfree(data = ggwrap(rectGrob(gp = gpar(fill = "goldenrod")), align = "full")) +
    # we can then add any inset grobs (the same as ggwrap, it can take any objects
    # which can be converted to a `grob`)
    inset(rectGrob(gp = gpar(fill = "steelblue")), align = "panel") +
    inset(textGrob("Here are some text", gp = gpar(color = "black")),
        align = "panel"
    )

## -----------------------------------------------------------------------------
sessionInfo()

