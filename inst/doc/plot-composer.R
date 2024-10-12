## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----setup--------------------------------------------------------------------
library(ggalign)

## -----------------------------------------------------------------------------
p_right <- ggplot(mtcars) +
  geom_point(aes(hp, wt, colour = mpg)) +
  patch_titles("right") +
  labs(color = "right")
p_top <- p_right +
  patch_titles("top") +
  scale_color_continuous(
    name = "top",
    guide = guide_colorbar(position = "top")
  )
p_left <- p_right +
  patch_titles("left") +
  scale_color_continuous(
    name = "left",
    guide = guide_colorbar(position = "left")
  )
p_bottom <- p_right +
  patch_titles("bottom") +
  scale_color_continuous(
    name = "bottom",
    guide = guide_colorbar(position = "bottom")
  )
align_plots(p_right, p_bottom, p_top, p_left, guides = "tlbr")

## -----------------------------------------------------------------------------
align_plots(
  free_guide(p_right, NULL),
  free_guide(p_bottom, NULL),
  free_guide(p_top, NULL),
  free_guide(p_left, NULL),
  guides = "tlbr"
)

## -----------------------------------------------------------------------------
align_plots(
  free_guide(p_right, "r"),
  free_guide(p_bottom, "b"),
  free_guide(p_top, "t"),
  free_guide(p_left, "l")
)

## -----------------------------------------------------------------------------
sessionInfo()

