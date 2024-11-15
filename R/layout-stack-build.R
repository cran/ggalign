#' @export
ggalign_build.StackLayout <- function(x) {
    stack_build(default_layout(x)) %||% align_plots()
}

#' @param extra_layout layout parameters of the axis vertically with the stack.
#' @importFrom grid unit.c
#' @importFrom rlang is_empty is_string
#' @noRd
stack_build <- function(stack, controls = stack@controls, extra_layout = NULL) {
    direction <- stack@direction
    position <- .subset2(stack@heatmap, "position")

    plots <- stack@plots

    # we remove the plot without actual plot area
    keep <- vapply(plots, function(plot) {
        # we remove align objects without plot area
        !is_align(plot) || !is.null(.subset2(plot, "plot"))
    }, logical(1L), USE.NAMES = FALSE)
    plots <- .subset(plots, keep)
    if (is_empty(plots)) return(NULL) # styler: off

    # we reorder the plots based on the `order` slot
    plot_order <- vapply(plots, function(plot) {
        if (is_layout(plot)) {
            .subset2(plot@plot_active, "order")
        } else {
            .subset2(.subset2(plot, "active"), "order")
        }
    }, integer(1L), USE.NAMES = FALSE)
    plots <- .subset(plots, make_order(plot_order))

    # build the stack
    patches <- stack_patch(direction)
    has_top <- FALSE
    has_bottom <- FALSE

    # for `free_spaces`, if we have applied it in the whole stack layout
    # we shouln't use it for a single plot. Otherwise, the guide legends
    # collected by the layout will overlap with the plot axis.
    # this occurs in the annotation stack (`position` is not `NULL`).
    stack_spaces <- .subset2(.subset2(controls, "plot_align"), "free_spaces")
    remove_spaces <- is_string(stack_spaces) && !is.null(position)
    layout <- set_layout_params(stack@layout)

    for (plot in plots) {
        if (is_align(plot) || is_free(plot)) {
            cur_controls <- inherit_controls(
                .subset2(plot, "controls"), controls
            )
            if (remove_spaces) {
                cur_spaces <- .subset2(
                    .subset2(controls, "cur_controls"), "free_spaces"
                )
                if (is_string(cur_spaces)) {
                    cur_spaces <- setdiff_position(cur_spaces, stack_spaces)
                    if (nchar(cur_spaces) == 0L) cur_spaces <- NULL
                    cur_controls$controls["free_spaces"] <- list(cur_spaces)
                }
            }
            if (is_align(plot)) {
                patch <- align_build(plot,
                    panel = .subset2(layout, "panel"),
                    index = .subset2(layout, "index"),
                    controls = cur_controls,
                    extra_layout = extra_layout
                )
                patches <- stack_patch_add_center_plot(
                    patches,
                    .subset2(patch, "plot"),
                    .subset2(patch, "size")
                )
            } else if (is_free(plot)) {
                patch <- free_build(plot, cur_controls)
                patches <- stack_patch_add_center_plot(
                    patches,
                    .subset2(patch, "plot"),
                    .subset2(patch, "size")
                )
            }
        } else if (is_quad_layout(plot)) {
            patch <- quad_build(plot, inherit_controls(plot@controls, controls))
            quad_plots <- .subset2(patch, "plots")
            patches <- stack_patch_add_quad(
                patches, quad_plots,
                .subset2(patch, "sizes")
            )
            if (is_horizontal(direction)) {
                has_top <- has_top || !is.null(.subset2(quad_plots, "top"))
                has_bottom <- has_bottom ||
                    !is.null(.subset2(quad_plots, "bottom"))
            } else {
                has_top <- has_top || !is.null(.subset2(quad_plots, "left"))
                has_bottom <- has_bottom ||
                    !is.null(.subset2(quad_plots, "right"))
            }
        }
    }
    if (is_empty(.subset2(patches, "plots"))) return(NULL) # styler: off
    titles <- stack@titles
    align_plots(
        !!!.subset2(patches, "plots"),
        design = area(
            .subset2(patches, "t"),
            .subset2(patches, "l"),
            .subset2(patches, "b"),
            .subset2(patches, "r")
        ),
        widths = switch_direction(
            direction,
            do.call(unit.c, attr(patches, "sizes")),
            stack@sizes[c(has_top, TRUE, has_bottom)]
        ),
        heights = switch_direction(
            direction,
            stack@sizes[c(has_top, TRUE, has_bottom)],
            do.call(unit.c, attr(patches, "sizes"))
        ),
        guides = .subset2(.subset2(controls, "plot_align"), "guides"),
        theme = stack@theme
    ) + layout_title(
        title = .subset2(titles, "title"),
        subtitle = .subset2(titles, "subtitle"),
        caption = .subset2(titles, "caption")
    )
}

make_order <- function(order) {
    l <- length(order)
    index <- seq_len(l)

    # for order not set by user, we use heuristic algorithm to define the order
    need_action <- is.na(order)
    if (all(need_action)) { # shorthand for the usual way, we don't set any
        return(index)
    } else if (all(!need_action)) { # we won't need do something special
        return(order(order))
    }

    # 1. for outliers, we always put them in the two tail
    # 2. for order has been set and is not the outliers,
    #    we always follow the order
    # 3. non-outliers were always regarded as the integer index
    used <- as.integer(order[!need_action & order >= 1L & order <= l])

    # we flatten user index to continuous integer sequence
    sequence <- vec_unrep(used) # key is the sequence start
    start <- .subset2(sequence, "key")
    end <- pmin(
        start + .subset2(sequence, "times") - 1L,
        vec_c(start[-1L] - 1L, l) # the next start - 1L
    )
    used <- .mapply(function(s, e) s:e, list(s = start, e = end), NULL)

    # following index can be used
    unused <- vec_set_difference(index, unlist(used, FALSE, FALSE))

    # we assign the candidate index to the order user not set.
    order[need_action] <- unused[seq_len(sum(need_action))]

    # make_order(c(NA, 1, NA)): c(2, 1, 3)
    # make_order(c(NA, 1, 3)): c(2, 1, 3)
    # make_order(c(NA, 1, 3, 1)): c(2, 4, 3, 1)
    order(order)
}

stack_patch <- function(direction) {
    ans <- list(
        t = integer(), l = integer(), b = integer(), r = integer(),
        plots = list()
    )
    structure(ans, direction = direction, align = 1L, sizes = list())
}

stack_patch_add_plot <- function(area, plot, t, l, b = t, r = l) {
    area$t <- c(.subset2(area, "t"), t)
    area$l <- c(.subset2(area, "l"), l)
    area$b <- c(.subset2(area, "b"), b)
    area$r <- c(.subset2(area, "r"), r)
    area$plots <- c(.subset2(area, "plots"), list(plot))
    area
}

#' @importFrom rlang is_empty
stack_patch_add_center_plot <- function(area, plot, size) {
    if (is.null(plot)) {
        return(area)
    }
    if (is_horizontal(attr(area, "direction"))) {
        r_border <- .subset2(area, "r")
        if (is_empty(r_border)) r_border <- 0L
        l <- max(r_border) + 1L
        t <- attr(area, "align")
    } else {
        b_border <- .subset2(area, "b")
        if (is_empty(b_border)) b_border <- 0L
        t <- max(b_border) + 1L
        l <- attr(area, "align")
    }
    attr(area, "sizes") <- c(attr(area, "sizes"), list(size))
    stack_patch_add_plot(area, plot, t, l)
}

#' @importFrom grid unit.c unit
stack_patch_add_quad <- function(area, plots, sizes) {
    if (is_horizontal(attr(area, "direction"))) {
        area <- stack_patch_add_center_plot(
            area,
            .subset2(plots, "left"),
            .subset2(sizes, "left")
        )
        area <- stack_patch_add_center_plot(
            area,
            .subset2(plots, "main"),
            .subset2(.subset2(sizes, "main"), "width")
        )
        l <- max(.subset2(area, "r"))
        if (!is.null(top <- .subset2(plots, "top"))) {
            if (attr(area, "align") == 1L) {
                area$t <- .subset2(area, "t") + 1L
                area$b <- .subset2(area, "b") + 1L
                attr(area, "align") <- attr(area, "align") + 1L
            }
            if (!is_null_unit(size <- .subset2(sizes, "top"))) {
                attr(top, "vp")$height <- size
            }
            area <- stack_patch_add_plot(area, top, t = 1L, l = l)
        }
        if (!is.null(bottom <- .subset2(plots, "bottom"))) {
            if (!is_null_unit(size <- .subset2(sizes, "bottom"))) {
                attr(bottom, "vp")$height <- size
            }
            area <- stack_patch_add_plot(area, bottom,
                t = attr(area, "align") + 1L, l = l
            )
        }
        area <- stack_patch_add_center_plot(
            area,
            .subset2(plots, "right"),
            .subset2(sizes, "right")
        )
    } else {
        area <- stack_patch_add_center_plot(
            area,
            .subset2(plots, "top"),
            .subset2(sizes, "top")
        )
        area <- stack_patch_add_center_plot(
            area,
            .subset2(plots, "main"),
            .subset2(.subset2(sizes, "main"), "height")
        )
        t <- max(.subset2(area, "b"))
        if (!is.null(left <- .subset2(plots, "left"))) {
            if (attr(area, "align") == 1L) {
                area$l <- .subset2(area, "l") + 1L
                area$r <- .subset2(area, "r") + 1L
                attr(area, "align") <- attr(area, "align") + 1L
            }
            if (!is_null_unit(size <- .subset2(sizes, "left"))) {
                attr(left, "vp")$width <- size
            }
            area <- stack_patch_add_plot(area, left, t = t, l = 1L)
        }
        if (!is.null(right <- .subset2(plots, "right"))) {
            if (!is_null_unit(size <- .subset2(sizes, "right"))) {
                attr(right, "vp")$width <- size
            }
            area <- stack_patch_add_plot(area, right,
                t = t, l = attr(area, "align") + 1L
            )
        }
        area <- stack_patch_add_center_plot(
            area,
            .subset2(plots, "bottom"),
            .subset2(sizes, "bottom")
        )
    }
    area
}
