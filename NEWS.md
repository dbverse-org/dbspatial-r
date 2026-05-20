<!-- NEWS.md is maintained by https://fledge.cynkra.com, contributors should not edit this file -->

# dbSpatial 0.1.1 (2026-05-20)

## Documentation

- Add method references to `DESCRIPTION`.

- Add missing `\value{}` sections for exported conversion and accessor methods.

- Remove internal `:::` usage from user-facing examples.

- Replace inappropriate `\dontrun{}` examples with `\donttest{}` examples.

# dbSpatial 0.0.0.9110 (2026-01-13)

## Bug fixes

- Make st_join VIEW names unique.

- Generate polygons for sim_dbSpatial.

- Add `options` concept to pkgdown.

- Export dbSpatial S4 Class.

- .st_spatial_join internal.

- Remove double geometry columns in dbSpatial-casted objects.

## Features

- Sf::st_geometrytype().

- Add \$ method for dbSpatial.

- Refactor spatial predicates via st_join.

- Suport for select `sf` generics.

- Add measurement methods (st_area, st_length, st_perimeter).

  - st_area (sf generic): compute area of polygons
  - st_length (sf generic): compute length of linestrings
  - st_perimeter (sf generic): compute perimeter of polygons

- Add geometry operation methods (st_buffer, st_centroid, st_simplify).

  - st_buffer (sf generic): compute buffer zones around geometries
  - st_centroid (sf generic): compute geometry centroids
  - st_simplify (sf generic): simplify geometries
  - Warn on unsupported sf arguments

- Add geometry output format methods (st_as_text, st_as_geojson).

  - Add st_as_text to convert geometry to WKT string
  - Add st_as_geojson to convert geometry to GeoJSON

- Add coordinate accessor methods (st_x, st_y, st_npoints).

  - Add st_x, st_y to extract point coordinates
  - Add st_npoints to count geometry points
  - Add shared .st_mutate_geom utility for accessor pattern

- Add show function for dbSpatial.

- Add coerce methods from dbSpatial to `SpatVector` and `sf`.

- `dbProject` and `dbData` integration.

- Vect().

- St_as_sf.

## Chore

- Clean up predicate docs and roxygen concepts.

- Breaking change: remove st_difference and st_distance.

- Add `methods` to Imports and update Collates.

- Remove redundant slots in dbSpatial class definition.

- Remove docs/ from version control.

- Bump version to 0.0.0.9109.

- Fix `gh_pages`.

- Require duckdb \>= 1.4.0.

- Remove dbData references.

- Migrate to dbverse-org.

- Update URLs to dbverse-org organization.

- Add testthat.

- Update imports.

- Include `dev` in gha.

- Update docs.

- Update license.

## Documentation

- Add missing topics to pkgdown reference.

- Wrap vect examples in dontrun.

- Fix broken example calls.

- Update spatial_operations.Rmd vignette.

- Update pkgdown config.

- Add global options.

- Update global options documentation.

- Rebuild roxygen.

- Add package global options.

- Document global package options.

- Update.

## Code style

- Apply air formatting to dbspatial-r.

## Refactoring

- Clean up constructor logic and add missing documentation.

- Simplify st_translate implementation.

- Rename scalar functions.

  - st_extent → st_bbox (sf generic)
  - st_geometrytype → st_geometry_type (sf generic)
  - st_isvalid → st_is_valid (sf generic)

- Consolidate spatial predicates.

- Centralize internal type check funcs in `dbProject`a.

- Remove unused extract methods for dbSpatial.

- S3 method `st_as_sf()` for `dbSpatial` obj.

- Update st_as_sf method to S3.

## Testing

- Switch predicate usage to st_join.

- Add basic tests.

## Breaking changes

- Breaking change: remove st_difference and st_distance.


# dbSpatial 0.0.0.9109 (2025-10-07)

## Breaking Changes

- Removed dbData class definition from dbSpatial package. Now imports dbData from dbProject package.

## Features

- **dbProject Integration**: Full integration with `dbProject` package and `dbData` base class. `dbSpatial` now inherits from `dbData` providing unified database-backed object interface across dbverse ecosystem.
- Added `st_as_sf()` S3 method for dbSpatial objects.
- Added `vect()` method for converting dbSpatial objects to terra::SpatVector format.

## Chore

- Migrated repository to `dbverse-org` organization from previous location.
- Updated all URLs and links to reflect new `dbverse-org` organization structure.
- Required DuckDB >= 1.4.0 (LTS).
- Added `testthat` to Suggests for comprehensive testing infrastructure.
- Updated imports to reflect dbProject dependency.
- Included `dev` branch in GitHub Actions workflow.

## Bug Fixes

- Fixed `.sim_dbSpatial()` function for proper spatial simulation.
- Removed unused extract methods for dbSpatial - functionality now comes from `dbProject::dbData` base class.

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
