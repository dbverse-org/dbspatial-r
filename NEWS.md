<!-- NEWS.md is maintained by https://cynkra.github.io/fledge, do not edit -->

# dbSpatial 0.0.0.9009 (2024-08-14)

## Features

- Add `show()` method for `dbSpatial` objects.

- Add new `to_dbSpatial()` function  for `{sf}` and `{terra}` object interop.

- Use `VIEW` for file reads.

- Support overwriting `VIEW`.

## Chore

- Add `sfarrow`, `glue` to imports.

- Update generics.

## Docs

- Add dark mode button to pkgdown site.

- Organize pkgdown Reference section.


# dbSpatial 0.0.0.9008 (2024-07-03)

## Docs

- Update docs for `tessellate`


# dbSpatial 0.0.0.9007 (2024-07-03)

## Features

- Add new `tessellate` function (WIP)

- Update `st_extent` to return named character vector

- Change default sql gen to VIEW creation instead of table


# dbSpatial 0.0.0.9006 (2024-03-28)

## Docs

- Update function descriptions.

# dbSpatial 0.0.0.9005 (2024-03-27)

## Features

- Add `spatial_relationship` functions.

- Add new internal functions for `spatial_relationship` functions.

- Use lowercase func names.

## Chore

- Update roxygen and pkgdown reference section.

# dbSpatial 0.0.0.9004 (2024-03-18)

## Chore

- Update README and DESCRIPTION.

# dbSpatial 0.0.0.9003 (2024-03-18)

## Features

- Update constructor function.

- Update ST_ functions to use new constructor.

## Chore

- Update vignettes and class diagram for new constructor.

- Add working examples to ST functions.

<!-- NEWS.md is maintained by https://fledge.cynkra.com, contributors should not edit this file -->

# dbSpatial 0.0.0.9002 (2024-01-02)

## Chore

- Update class diagram.

- Add tictoc to imports.

## Uncategorized

- Merge branch 'main' of https://github.com/Ed2uiz/dbSpatial.


# dbSpatial 0.0.0.9001 (2024-01-02)

## Bug fixes

- Add missing ' in constructor.

- Duckdb spatial extension load error in GHA workflow.

## Features

- Add terra to imports.

- Add dbplyr to imports.

- Add dplyr to imports.

- Add duckdb to imports.

- Add duckdbfs to imports.

## Chore

- Update docs.

- Update pkg info.

- Move index.html to /docs.

- Add license
