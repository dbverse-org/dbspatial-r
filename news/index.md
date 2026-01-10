# Changelog

## dbSpatial 0.0.0.9109 (2025-10-07)

### Breaking Changes

- Removed dbData class definition from dbSpatial package. Now imports
  dbData from dbProject package.

### Features

- **dbProject Integration**: Full integration with `dbProject` package
  and `dbData` base class. `dbSpatial` now inherits from `dbData`
  providing unified database-backed object interface across dbverse
  ecosystem.
- Added
  [`st_as_sf()`](https://r-spatial.github.io/sf/reference/st_as_sf.html)
  S3 method for dbSpatial objects.
- Added [`vect()`](https://rspatial.github.io/terra/reference/vect.html)
  method for converting dbSpatial objects to terra::SpatVector format.

### Chore

- Migrated repository to `dbverse-org` organization from previous
  location.
- Updated all URLs and links to reflect new `dbverse-org` organization
  structure.
- Required DuckDB \>= 1.4.0 (LTS).
- Added `testthat` to Suggests for comprehensive testing infrastructure.
- Updated imports to reflect dbProject dependency.
- Included `dev` branch in GitHub Actions workflow.

### Bug Fixes

- Fixed
  [`.sim_dbSpatial()`](https://dbverse-org.github.io/dbspatial-r/reference/dot-sim_dbSpatial.md)
  function for proper spatial simulation.
- Removed unused extract methods for dbSpatial - functionality now comes
  from `dbProject::dbData` base class.

## dbSpatial 0.0.0.9009 (2024-08-14)

### Features

- Add
  [`show()`](https://dbverse-org.github.io/dbspatial-r/reference/show.md)
  method for `dbSpatial` objects.

- Add new `to_dbSpatial()` function for
  [sf](https://r-spatial.github.io/sf/) and
  [terra](https://rspatial.org/) object interop.

- Use `VIEW` for file reads.

- Support overwriting `VIEW`.

### Chore

- Add `sfarrow`, `glue` to imports.

- Update generics.

### Docs

- Add dark mode button to pkgdown site.

- Organize pkgdown Reference section.

## dbSpatial 0.0.0.9008 (2024-07-03)

### Docs

- Update docs for `tessellate`

## dbSpatial 0.0.0.9007 (2024-07-03)

### Features

- Add new `tessellate` function (WIP)

- Update `st_extent` to return named character vector

- Change default sql gen to VIEW creation instead of table

## dbSpatial 0.0.0.9006 (2024-03-28)

### Docs

- Update function descriptions.

## dbSpatial 0.0.0.9005 (2024-03-27)

### Features

- Add `spatial_relationship` functions.

- Add new internal functions for `spatial_relationship` functions.

- Use lowercase func names.

### Chore

- Update roxygen and pkgdown reference section.

## dbSpatial 0.0.0.9004 (2024-03-18)

### Chore

- Update README and DESCRIPTION.

## dbSpatial 0.0.0.9003 (2024-03-18)

### Features

- Update constructor function.

- Update ST\_ functions to use new constructor.

### Chore

- Update vignettes and class diagram for new constructor.

- Add working examples to ST functions.

## dbSpatial 0.0.0.9002 (2024-01-02)

### Chore

- Update class diagram.

- Add tictoc to imports.

### Uncategorized

- Merge branch ‘main’ of <https://github.com/Ed2uiz/dbSpatial>.

## dbSpatial 0.0.0.9001 (2024-01-02)

### Bug fixes

- Add missing ’ in constructor.

- Duckdb spatial extension load error in GHA workflow.

### Features

- Add terra to imports.

- Add dbplyr to imports.

- Add dplyr to imports.

- Add duckdb to imports.

- Add duckdbfs to imports.

### Chore

- Update docs.

- Update pkg info.

- Move index.html to /docs.

- Add license
