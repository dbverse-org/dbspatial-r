# Class Structure

## Class Structure

The `dbSpatial` package is designed to work with spatial geometries in a
DuckDB table. The package builds on the [DuckDB spatial
extension](https://duckdb.org/docs/extensions/spatial.html).

`dbSpatial` objects adopt the S4 class system and represent spatial
`geometries` in a DuckDB table. The
[dbSpatial](https://github.com/dbverse-org/dbspatial-r) package consists
of methods for constructing `dbSpatial` objects from various data
sources, as well as various spatial operations for working with these
data.

`dbSpatial` provides methods for reading/writing `dbSpatial` objects
from/to data.frames, S3 and S4 spatial-related objects (e.g. objects
from [sf](https://r-spatial.github.io/sf/) or
[terra](https://rspatial.org/)), and [several other spatial
files](https://duckdb.org/docs/extensions/spatial.html#st_read--read-spatial-data-from-files)
that are supported by the DuckDB spatial extension.

The runnable example below is evaluated only when the `duckdb` package
is available in the check environment.

### Minimal example

``` r

library(dbSpatial)

con <- DBI::dbConnect(duckdb::duckdb(), ":memory:")
DBI::dbExecute(con, "SET threads = 1")
#> [1] 0
coords <- data.frame(id = 1:3, x = c(0, 1, 2), y = c(0, 1, 2))

pts <- dbSpatial(
  conn = con,
  name = "class_structure_points",
  value = coords,
  x_colName = "x",
  y_colName = "y",
  overwrite = TRUE
)

class(pts)
#> [1] "dbSpatial"
#> attr(,"package")
#> [1] "dbSpatial"
pts
#> # Class:    dbSpatial 
#> # Source:   SQL [?? x 4]
#> # Database: DuckDB 1.5.2 [unknown@Linux 6.17.0-1015-azure:R 4.6.0/:memory:]
#>      id     x     y geom       
#>   <int> <dbl> <dbl> <chr>      
#> 1     1     0     0 POINT (0 0)
#> 2     2     1     1 POINT (1 1)
#> 3     3     2     2 POINT (2 2)

DBI::dbDisconnect(con, shutdown = TRUE)
```

[![’’](https://mermaid.ink/img/pako:eNp9U-9r2zAQ_VeEPu2Hq0WzYreiDAqFfRqMpmwwDOFsyYlaWQqSPJaZ_O-TnTSN1jb6cr73jnfHu_OAGysk5rjR4P2tgpWDrjKVMdBJv4FGotub-xs0jBiKb6pDkQkK9LJVWvphz4zvIyJ-vUnylbQP3poEI2Sf7lJVtzjI2vpBNiEVDtI54Hzs_COS1r1B3oGP2Sn5VdkQLOerKX63ygR_jtfblTVJhW-jdvvqzMpcdLKzbpsMKyAAad3o4Qs4QK2f4Elsl_ot6icbtKrRcNrsSCXNGmsMR6JvHkW9HJNoj0od_w26l3xa5Sk8NuWRdM0aTiy7QIv75Yd371Hbm0nqedoxHCZObgBdE_LleT6O7iSITz-dCrIy_-_1bPHR0LNVOMOddB0oEW93cqPCYS07WWEeP4VsodehwnHWWAp9sIutaTBvQXuZ4X4TVyEP535EN2B-WRvz4Pp9ivmA_2BO53NCP5c5ZSUr2JzRywxvIzyjJC-KGWOsmFNWFMUuw38nhRkp6RWlRcnKvLzKZ3mGpVDxar8dfrcx7P4BMZQVSg?type=png)](https://mermaid.live/edit#pako:eNp9U-9r2zAQ_VeEPu2Hq0WzYreiDAqFfRqMpmwwDOFsyYlaWQqSPJaZ_O-TnTSN1jb6cr73jnfHu_OAGysk5rjR4P2tgpWDrjKVMdBJv4FGotub-xs0jBiKb6pDkQkK9LJVWvphz4zvIyJ-vUnylbQP3poEI2Sf7lJVtzjI2vpBNiEVDtI54Hzs_COS1r1B3oGP2Sn5VdkQLOerKX63ygR_jtfblTVJhW-jdvvqzMpcdLKzbpsMKyAAad3o4Qs4QK2f4Elsl_ot6icbtKrRcNrsSCXNGmsMR6JvHkW9HJNoj0od_w26l3xa5Sk8NuWRdM0aTiy7QIv75Yd371Hbm0nqedoxHCZObgBdE_LleT6O7iSITz-dCrIy_-_1bPHR0LNVOMOddB0oEW93cqPCYS07WWEeP4VsodehwnHWWAp9sIutaTBvQXuZ4X4TVyEP535EN2B-WRvz4Pp9ivmA_2BO53NCP5c5ZSUr2JzRywxvIzyjJC-KGWOsmFNWFMUuw38nhRkp6RWlRcnKvLzKZ3mGpVDxar8dfrcx7P4BMZQVSg)
