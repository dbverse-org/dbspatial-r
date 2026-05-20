# Base function for spatial joins

Internal base function for spatial joins.

## Usage

``` r
.st_spatial_join(
  g1,
  g1_geomName = "geom",
  g1_cols_keep = "all",
  g2,
  g2_geomName = "geom",
  g2_cols_keep = "all",
  overwrite = FALSE,
  name,
  st_name,
  extra_args = NULL,
  ...
)
```

## Arguments

- g1:

  A
  [`dbSpatial`](https://dbverse-org.github.io/dbspatial-r/reference/dbSpatial.md)
  object.

- g1_geomName:

  `character`. The `geometry` column name in `g1`. Default: "geom".

- g1_cols_keep:

  `character vector`. The column names in `g1` to keep. Default: "all".

- g2:

  A
  [`dbSpatial`](https://dbverse-org.github.io/dbspatial-r/reference/dbSpatial.md)
  object.

- g2_geomName:

  `character`. The `geometry` column name in `g2`. Default: "geom".

- g2_cols_keep:

  `character vector`. The column names in `g2` to keep. Default: "all".

- overwrite:

  `logical`. If `TRUE`, overwrite existing table. Default: `FALSE`.

- name:

  `character`. The name of the output table.

- st_name:

  `character`. The name of the spatial join function to use.

- ...:

  Additional arguments passed to `duckdb::dbSendQuery()`.

## Value

`dbSpatial` object

## Details

Returns a VIEW of the spatial join. Must compute to save results.
