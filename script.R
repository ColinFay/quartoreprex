options(
  future.rng.onMisuse = "ignore"
)
future::plan(future::multisession)

for (i in 1:100){
  write(file = sprintf("test%s.qmd", i),
        sprintf("---
title: 'test%s'
---

## Quarto

Quarto enables you to weave together content and executable code into a finished presentation. To learn more about Quarto presentations see <https://quarto.org/docs/presentations/>.
", i)
  )
}

list.files(pattern = "\\.qmd$", full.names = TRUE) |>
  furrr::future_map(
    .progress = TRUE,
    \(x){
      quarto::quarto_render(
        x,
        quiet = FALSE
      )
    }
  )