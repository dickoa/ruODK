
<!-- README.md is generated from README.Rmd. Please edit that file -->

# `ruODK`: An R Client for the ODK Central API <img src="man/figures/ruODK.png" align="right" alt="Are you ODK?" width="120" />

<!-- badges: start -->

[![ROpenSci submission
status](https://badges.ropensci.org/335_status.svg)](https://github.com/ropensci/software-review/issues/335)
[![Project Status: Active – The project has reached a stable, usable
state and is being actively
developed.](https://www.repostatus.org/badges/latest/active.svg)](https://www.repostatus.org/#active)
[![Last-changedate](https://img.shields.io/github/last-commit/dbca-wa/ruODK.svg)](https://github.com/dbca-wa/ruODK/commits/master)
[![GitHub
issues](https://img.shields.io/github/issues/dbca-wa/ruodk.svg?style=popout)](https://github.com/dbca-wa/ruODK/issues/)
[![Travis build
status](https://travis-ci.org/dbca-wa/ruODK.svg?branch=master)](https://travis-ci.org/dbca-wa/ruODK)
[![AppVeyor build
status](https://ci.appveyor.com/api/projects/status/github/dbca-wa/ruODK?branch=master&svg=true)](https://ci.appveyor.com/project/dbca-wa/ruODK)
[![Coverage
status](https://codecov.io/gh/dbca-wa/ruODK/branch/master/graph/badge.svg)](https://codecov.io/github/dbca-wa/ruODK?branch=master)
[![Binder](https://mybinder.org/badge_logo.svg)](https://mybinder.org/v2/gh/dbca-wa/urODK/master?urlpath=rstudio)
<!-- badges: end -->

Especially in these trying times, it is important to ask: “ruODK?”

[OpenDataKit](https://opendatakit.org/) (ODK) is a free and open-source
software for collecting, managing, and using data in
resource-constrained environments.

ODK consists of a range of [software packages and
apps](https://opendatakit.org/software/). `ruODK` assumes some
familiarity of its users with the ODK ecosystem and workflows. For a
detailed overview, read the extensive [ODK
documentation](https://docs.opendatakit.org/) and visit the friendly
[ODK forum](https://forum.opendatakit.org/).

[ODK Central](https://docs.opendatakit.org/central-intro/) is a
cloud-based data clearinghouse for digitally captured data, replacing
the older software [ODK
Aggregate](https://docs.opendatakit.org/aggregate-intro/). ODK Central
manages user accounts and permissions, stores form definitions, and
allows data collection clients like [ODK
Collect](https://docs.opendatakit.org/collect-intro/) to connect to it
for form download and submission upload.

![An ODK setup with ODK Build, Central, Collect, and
ruODK](https://www.lucidchart.com/publicSegments/view/952c1350-3003-48c1-a2c8-94bad74cdb46/image.png)

A typical [ODK workflow](https://docs.opendatakit.org/#how-is-odk-used):
An XForm is designed e.g. in [ODK
Build](https://build.opendatakit.org/), [published to ODK
Central](https://docs.opendatakit.org/central-forms/), and downloaded
onto an Android device running ODK Collect. After data have been
captured digitally using [ODK
Collect](https://docs.opendatakit.org/collect-intro/), the data are
uploaded and stored in ODK Central. The next step from there is to
extract the data, optionally upload it into another data warehouse, and
then to analyse and generate insight from it.

While data can be retrieved in bulk through the GUI, ODK Central’s API
provides access to its data and functionality through both an OData and
a RESTful API with a comprehensive and interactive
[documentation](https://odkcentral.docs.apiary.io/#reference/odata-endpoints).

`ruODK` is aimed at the technically minded researcher who wishes to
access and use the data from ODK Central using the programming language
R.

Benefits of using the R ecosystem in combination with ODK:

  - Scalability: Both R and ODK are free and open source software.
    Scaling to many users does not incur license fees.
  - Ubiquity: R is known to many scientists and is widely taught at
    universities.
  - Automation: The entire data access workflow can be automated through
    R scripts.
  - Reproducible reporting (e.g. 
    [Sweave](https://support.rstudio.com/hc/en-us/articles/200552056-Using-Sweave-and-knitr),
    [RMarkdown](https://rmarkdown.rstudio.com/)), interactive web apps
    ([Shiny](https://shiny.rstudio.com/)), workflow scaling
    ([drake](https://docs.ropensci.org/drake/)) and a range of
    integrations with Docker (links coming soon).

`ruODK`’s scope:

  - To wrap all ODK Central API endpoints with a focus on **data
    access**.
  - To provide working examples of interacting with the ODK Central API.
  - To provide convenience helpers for the day to day tasks when working
    with ODK Central data in R: **data munging** the ODK Central API
    output into tidy R formats.

`ruODK`’s use cases:

  - Smaller projects:
    1.  Data collection: ODK Collect
    2.  Data clearinghouse: ODK Central
    3.  Data analysis and reporting: `Rmd` (ruODK)
    4.  Publishing and dissemination:
        [`ckanr`](https://docs.ropensci.org/ckanr/),
        [`CKAN`](https://ckan.org/)
  - Larger projects:
    1.  Data collection: ODK Collect
    2.  Data clearinghouse: ODK Central
    3.  ETL pipeline into data warehouses: `Rmd` (ruODK)
    4.  QA: in data warehouse
    5.  Reporting: `Rmd`
    6.  Publishing and dissemination:
        [`ckanr`](https://docs.ropensci.org/ckanr/),
        [`CKAN`](https://ckan.org/)

Out of scope:

  - To wrap “management” API endpoints. The ODK Central GUI provides a
    comprehensive interface for the management of users, roles,
    permissions, projects, and forms. Behind the scenes, it is a [VueJS
    application](https://github.com/opendatakit/central-frontend/)
    working on the “management” API endpoints of the ODK Central
    backend.
  - To provide extensive data visualisation. We show only minimal
    examples of data visualisation and presentation, mainly to
    illustrate the example data. Once the data is in your hands as tidy
    tibbles… urODK\!

## Install

You can install ruODK from GitHub with:

``` r
if (!requireNamespace("remotes")) {install.packages("remotes")}
remotes::install_github("dbca-wa/ruODK", dependencies = TRUE)
```

## ODK Central

### Access to an ODK Central instance

First, we need an ODK Central instance and some data to play with\!

Either ask in the [ODK forum](https://forum.opendatakit.org/) for an
account in the [ODK Central
Sandbox](https://sandbox.central.opendatakit.org/), or follow the [setup
instructions](https://docs.opendatakit.org/central-intro/) to build and
deploy your very own ODK Central instance.

### ODK Central setup

The ODK Central [user
manual](https://docs.opendatakit.org/central-using/) provides up-to-date
descriptions of the steps below.

  - [Create a web user
    account](https://docs.opendatakit.org/central-users/#creating-a-web-user)
    on an ODK Central instance. Your username will be an email address.
  - [Create a project](https://docs.opendatakit.org/central-projects/)
    and give the web user the relevant permissions.
  - Create an XForm, e.g. using ODK Build, or use the provided example
    forms.
  - [Publish the form](https://docs.opendatakit.org/central-forms/) to
    ODK Central.
  - Collect some data for this form on ODK Collect and let ODK Collect
    submit the finalised forms to ODK Central.

A note on the [included example
forms](https://github.com/dbca-wa/ruODK/tree/master/inst/extdata): The
`.odkbuild` versions can be loaded into [ODK
Build](https://build.opendatakit.org/), while the `.xml` versions can be
imported into ODK Central.

## Configure `ruODK`

Set up `ruODK` with an OData Service URL and credentials of a
read-permitted ODK Central web user.

``` r
ruODK::ru_setup(
  svc = "https://sandbox.central.opendatakit.org/v1/projects/14/forms/build_Flora-Quadrat-0-4_1564384341.svc",
  un = Sys.getenv("ODKC_TEST_UN"),
  pw = Sys.getenv("ODKC_TEST_PW")
)
```

For all available detailed options to configure `ruODK`, read
[`vignette("setup", package =
"ruODK")`](https://dbca-wa.github.io/ruODK/articles/setup.html).

## Use ruODK

A quick example using the OData service:

``` r
library(ruODK)

# List projects
proj <- ruODK::project_list()
proj %>% head() %>% knitr::kable(.)
```

| id | name          | forms | app\_users | created\_at         | updated\_at | last\_submission    | archived |
| -: | :------------ | ----: | ---------: | :------------------ | :---------- | :------------------ | :------- |
|  8 | AmenazasRD    |     0 |          0 | 2019-04-14 06:21:00 | NA          | NA                  | FALSE    |
|  9 | BAFCO Test    |     1 |          1 | 2019-04-19 00:30:45 | NA          | 2019-04-19 01:26:49 | FALSE    |
| 11 | CaVaTeCo      |     2 |          1 | 2019-04-30 06:43:22 | NA          | 2019-04-30 08:07:55 | FALSE    |
| 18 | CherryPatch   |     2 |          1 | 2019-05-27 21:09:33 | NA          | 2019-05-28 17:32:15 | FALSE    |
| 32 | Collect3289v2 |     1 |          2 | 2019-08-07 12:52:56 | NA          | 2019-08-07 13:44:19 | FALSE    |
|  4 | Curso         |     7 |          4 | 2019-02-26 03:55:50 | NA          | 2019-03-21 22:22:57 | FALSE    |

``` r

# List forms of default project
frms <- ruODK::form_list()
frms %>% knitr::kable(.)
```

| name                          | fid                                              | version | state   | submissions | created\_at         | created\_by\_id | created\_by                    | updated\_at         | last\_submission    | hash                             |
| :---------------------------- | :----------------------------------------------- | :------ | :------ | :---------- | :------------------ | --------------: | :----------------------------- | :------------------ | :------------------ | :------------------------------- |
| Flora Quadrat 0.1             | build\_Flora-Quadrat-0-1\_1558330379             |         | closing | 1           | 2019-05-20 05:33:15 |              57 | <florian.mayer@dbca.wa.gov.au> | 2019-05-23 01:46:39 | 2019-05-20 05:44:20 | 4f0036619468ef05b572631b04b94f06 |
| Flora Quadrat 0.2             | build\_Flora-Quadrat-0-2\_1558575936             |         | open    | 2           | 2019-05-23 01:46:08 |              57 | <florian.mayer@dbca.wa.gov.au> | 2019-08-19 07:57:38 | 2019-05-23 03:12:16 | 14e269a2374132392c275117efbe67b6 |
| Flora Quadrat 0.3             | build\_Flora-Quadrat-0-3\_1559119570             |         | open    | 1           | 2019-05-29 08:48:15 |              57 | <florian.mayer@dbca.wa.gov.au> | NA                  | 2019-05-29 08:55:59 | d5a80cefb1895eefcd0cb86a12d8acb4 |
| Flora Quadrat 0.4             | build\_Flora-Quadrat-0-4\_1564384341             |         | open    | 2           | 2019-08-19 07:58:28 |              57 | <florian.mayer@dbca.wa.gov.au> | NA                  | 2019-09-18 08:51:07 | 1bb959d541ac6990e3f74893e38c855b |
| Spotlighting 0.5              | build\_Spotlighting-0-5\_1558320001              |         | closing | 1           | 2019-05-20 02:44:47 |              57 | <florian.mayer@dbca.wa.gov.au> | 2019-05-20 06:30:41 | 2019-05-20 02:58:09 | 3775dcdface98ba3a426739c494123f6 |
| Spotlighting 0.6              | build\_Spotlighting-0-6\_1558333698              |         | open    | 3           | 2019-05-20 06:30:21 |              57 | <florian.mayer@dbca.wa.gov.au> | NA                  | 2019-05-30 07:13:29 | 456daaa9a4f96670e6eef3cf4a7dd0db |
| Spotlighting Survey End 0.3   | build\_Spotlighting-Survey-End-0-3\_1558320208   |         | open    | 2           | 2019-05-20 02:44:38 |              57 | <florian.mayer@dbca.wa.gov.au> | NA                  | 2019-05-30 07:15:53 | 5fdfac8e773834b1267f7ca7e1c9a428 |
| Spotlighting Survey Start 0.3 | build\_Spotlighting-Survey-Start-0-3\_1558320795 |         | open    | 7           | 2019-05-20 02:53:50 |              57 | <florian.mayer@dbca.wa.gov.au> | NA                  | 2019-06-05 01:33:49 | f548a064cca13bca746f3c0b1a8b5a32 |

``` r

# Form details of default form
frmd <- ruODK::form_detail()
frmd %>% knitr::kable(.)
```

| name              | fid                                  | version | state | submissions | created\_at              | created\_by\_id | created\_by                    | updated\_at | last\_submission         | hash                             |
| :---------------- | :----------------------------------- | :------ | :---- | ----------: | :----------------------- | --------------: | :----------------------------- | :---------- | :----------------------- | :------------------------------- |
| Flora Quadrat 0.4 | build\_Flora-Quadrat-0-4\_1564384341 |         | open  |           2 | 2019-08-19T07:58:28.211Z |              57 | <florian.mayer@dbca.wa.gov.au> | NA          | 2019-09-18T08:51:07.481Z | 1bb959d541ac6990e3f74893e38c855b |

``` r

# Form schema
meta <- ruODK::form_schema()
meta
#> [[1]]
#> [[1]]$name
#> [1] "meta"
#> 
#> [[1]]$children
#> [[1]]$children[[1]]
#> [[1]]$children[[1]]$name
#> [1] "instanceID"
#> 
#> [[1]]$children[[1]]$type
#> [1] "string"
#> 
#> 
#> 
#> [[1]]$type
#> [1] "structure"
#> 
#> 
#> [[2]]
#> [[2]]$name
#> [1] "encounter_start_datetime"
#> 
#> [[2]]$type
#> [1] "dateTime"
#> 
#> 
#> [[3]]
#> [[3]]$name
#> [1] "reporter"
#> 
#> [[3]]$type
#> [1] "string"
#> 
#> 
#> [[4]]
#> [[4]]$name
#> [1] "device_id"
#> 
#> [[4]]$type
#> [1] "string"
#> 
#> 
#> [[5]]
#> [[5]]$name
#> [1] "location"
#> 
#> [[5]]$children
#> [[5]]$children[[1]]
#> [[5]]$children[[1]]$name
#> [1] "area_name"
#> 
#> [[5]]$children[[1]]$type
#> [1] "string"
#> 
#> 
#> [[5]]$children[[2]]
#> [[5]]$children[[2]]$name
#> [1] "quadrat_photo"
#> 
#> [[5]]$children[[2]]$type
#> [1] "binary"
#> 
#> 
#> [[5]]$children[[3]]
#> [[5]]$children[[3]]$name
#> [1] "corner1"
#> 
#> [[5]]$children[[3]]$type
#> [1] "geopoint"
#> 
#> 
#> 
#> [[5]]$type
#> [1] "structure"
#> 
#> 
#> [[6]]
#> [[6]]$name
#> [1] "habitat"
#> 
#> [[6]]$children
#> [[6]]$children[[1]]
#> [[6]]$children[[1]]$name
#> [1] "morphological_type"
#> 
#> [[6]]$children[[1]]$type
#> [1] "select1"
#> 
#> 
#> [[6]]$children[[2]]
#> [[6]]$children[[2]]$name
#> [1] "morphological_type_photo"
#> 
#> [[6]]$children[[2]]$type
#> [1] "binary"
#> 
#> 
#> 
#> [[6]]$type
#> [1] "structure"
#> 
#> 
#> [[7]]
#> [[7]]$name
#> [1] "vegetation_stratum"
#> 
#> [[7]]$children
#> [[7]]$children[[1]]
#> [[7]]$children[[1]]$name
#> [1] "nvis_level3_broad_floristic_group"
#> 
#> [[7]]$children[[1]]$type
#> [1] "select1"
#> 
#> 
#> [[7]]$children[[2]]
#> [[7]]$children[[2]]$name
#> [1] "max_height_m"
#> 
#> [[7]]$children[[2]]$type
#> [1] "decimal"
#> 
#> 
#> [[7]]$children[[3]]
#> [[7]]$children[[3]]$name
#> [1] "foliage_cover"
#> 
#> [[7]]$children[[3]]$type
#> [1] "select1"
#> 
#> 
#> [[7]]$children[[4]]
#> [[7]]$children[[4]]$name
#> [1] "dominant_species_1"
#> 
#> [[7]]$children[[4]]$type
#> [1] "string"
#> 
#> 
#> [[7]]$children[[5]]
#> [[7]]$children[[5]]$name
#> [1] "dominant_species_2"
#> 
#> [[7]]$children[[5]]$type
#> [1] "string"
#> 
#> 
#> [[7]]$children[[6]]
#> [[7]]$children[[6]]$name
#> [1] "dominant_species_3"
#> 
#> [[7]]$children[[6]]$type
#> [1] "string"
#> 
#> 
#> [[7]]$children[[7]]
#> [[7]]$children[[7]]$name
#> [1] "dominant_species_4"
#> 
#> [[7]]$children[[7]]$type
#> [1] "string"
#> 
#> 
#> 
#> [[7]]$type
#> [1] "repeat"
#> 
#> 
#> [[8]]
#> [[8]]$name
#> [1] "perimeter"
#> 
#> [[8]]$children
#> [[8]]$children[[1]]
#> [[8]]$children[[1]]$name
#> [1] "corner2"
#> 
#> [[8]]$children[[1]]$type
#> [1] "geopoint"
#> 
#> 
#> [[8]]$children[[2]]
#> [[8]]$children[[2]]$name
#> [1] "corner3"
#> 
#> [[8]]$children[[2]]$type
#> [1] "geopoint"
#> 
#> 
#> [[8]]$children[[3]]
#> [[8]]$children[[3]]$name
#> [1] "corner4"
#> 
#> [[8]]$children[[3]]$type
#> [1] "geopoint"
#> 
#> 
#> [[8]]$children[[4]]
#> [[8]]$children[[4]]$name
#> [1] "mudmap_photo"
#> 
#> [[8]]$children[[4]]$type
#> [1] "binary"
#> 
#> 
#> 
#> [[8]]$type
#> [1] "structure"
#> 
#> 
#> [[9]]
#> [[9]]$name
#> [1] "taxon_encounter"
#> 
#> [[9]]$children
#> [[9]]$children[[1]]
#> [[9]]$children[[1]]$name
#> [1] "field_name"
#> 
#> [[9]]$children[[1]]$type
#> [1] "string"
#> 
#> 
#> [[9]]$children[[2]]
#> [[9]]$children[[2]]$name
#> [1] "photo_in_situ"
#> 
#> [[9]]$children[[2]]$type
#> [1] "binary"
#> 
#> 
#> [[9]]$children[[3]]
#> [[9]]$children[[3]]$name
#> [1] "taxon_encounter_location"
#> 
#> [[9]]$children[[3]]$type
#> [1] "geopoint"
#> 
#> 
#> [[9]]$children[[4]]
#> [[9]]$children[[4]]$name
#> [1] "life_form"
#> 
#> [[9]]$children[[4]]$type
#> [1] "select1"
#> 
#> 
#> [[9]]$children[[5]]
#> [[9]]$children[[5]]$name
#> [1] "voucher_specimen_barcode"
#> 
#> [[9]]$children[[5]]$type
#> [1] "barcode"
#> 
#> 
#> [[9]]$children[[6]]
#> [[9]]$children[[6]]$name
#> [1] "voucher_specimen_label"
#> 
#> [[9]]$children[[6]]$type
#> [1] "string"
#> 
#> 
#> 
#> [[9]]$type
#> [1] "repeat"
#> 
#> 
#> [[10]]
#> [[10]]$name
#> [1] "encounter_end_datetime"
#> 
#> [[10]]$type
#> [1] "dateTime"

# Form submissions
d <- fs::path("docs/articles/attachments/media")   # choose your own
tz <- "Australia/Perth"                            # crikey
data <- ruODK::odata_submission_get(verbose = TRUE, local_dir = d, tz = tz)
data %>% knitr::kable(.)
```

| id                                        | encounter\_start\_datetime | reporter      | device\_id       | encounter\_end\_datetime | submission\_date         | submitter\_id | submitter\_name | instance\_id                              | area\_name               | quadrat\_photo                                    | type\_12 |      x13 |        x14 |        x15 | accuracy\_16 | morphological\_type | morphological\_type\_photo                        | type\_19 |      x20 |        x21 |         x22 | accuracy\_23 | type\_24 |      x25 |        x26 |         x27 | accuracy\_28 | type\_29 |      x30 |        x31 |         x32 | accuracy\_33 | mudmap\_photo                                     | odata\_context                                                                                                              |
| :---------------------------------------- | :------------------------- | :------------ | :--------------- | :----------------------- | :----------------------- | :------------ | :-------------- | :---------------------------------------- | :----------------------- | :------------------------------------------------ | :------- | -------: | ---------: | ---------: | -----------: | :------------------ | :------------------------------------------------ | :------- | -------: | ---------: | ----------: | -----------: | :------- | -------: | ---------: | ----------: | -----------: | :------- | -------: | ---------: | ----------: | -----------: | :------------------------------------------------ | :-------------------------------------------------------------------------------------------------------------------------- |
| uuid:d5e78a78-34db-483d-978f-d9c9a3bc7b69 | 1568794341.147             | Florian Mayer | f73d2e1221ceaa06 | 1568796046.155           | 2019-09-18T08:51:07.481Z | 241           | flora           | uuid:d5e78a78-34db-483d-978f-d9c9a3bc7b69 | Kensington Carpark 01    | docs/articles/attachments/media/1568794395624.jpg | Point    | 115.8846 | \-31.99606 |    6.40451 |        4.288 | mid-slope           | docs/articles/attachments/media/1568794560256.jpg | Point    | 115.8844 | \-31.99623 | \-26.305695 |        4.288 | Point    | 115.8844 | \-31.99615 | \-17.897552 |        4.288 | Point    | 115.8843 | \-31.99610 | \-27.759338 |        4.288 | NA                                                | <https://sandbox.central.opendatakit.org/v1/projects/14/forms/build_Flora-Quadrat-0-4_1564384341.svc/$metadata#Submissions> |
| uuid:529cb189-8bb2-4cf1-9041-dcde716efb4f | 1568786923.257             | Florian Mayer | f73d2e1221ceaa06 | 1568787533.583           | 2019-09-18T06:20:25.780Z | 241           | flora           | uuid:529cb189-8bb2-4cf1-9041-dcde716efb4f | Kensington Planter Box 1 | docs/articles/attachments/media/1568786958640.jpg | Point    | 115.8843 | \-31.99615 | \-17.37241 |        4.288 | flat                | docs/articles/attachments/media/1568787004467.jpg | Point    | 115.8844 | \-31.99620 |  \-8.662476 |        4.288 | Point    | 115.8844 | \-31.99622 |  \-6.266144 |        4.288 | Point    | 115.8844 | \-31.99621 |  \-6.597748 |        4.288 | docs/articles/attachments/media/1568787172983.jpg | <https://sandbox.central.opendatakit.org/v1/projects/14/forms/build_Flora-Quadrat-0-4_1564384341.svc/$metadata#Submissions> |

A more detailed walk-through with some data visualisation examples is
available in the [`vignette("odata",
package="ruODK")`](https://dbca-wa.github.io/ruODK/articles/odata.html).

See also [`vignette("api",
package="ruODK")`](https://dbca-wa.github.io/ruODK/articles/api.html)
for examples using the alternative RESTful
API.

## Try ruODK

[![Binder](https://mybinder.org/badge_logo.svg)](https://mybinder.org/v2/gh/dbca-wa/urODK/master?urlpath=rstudio)
will launch a disposable, hosted RStudio instance with `ruODK` installed
and the companion package [`urODK`](https://github.com/dbca-wa/urODK)
opened as starting point for a hands-on workshop or instant demo of
`ruODK` usage.

Create a new RMarkdown workbook from `ruODK` template “ODK Central via
OData” and follow the instructions within.

## Contribute

Contributions through [issues](https://github.com/dbca-wa/ruODK/issues)
and PRs are welcome\!

See the [contributing
guide](https://dbca-wa.github.io/ruODK/CONTRIBUTING.html) on best
practices and further readings for code contributions.

## Attribution

`ruODK` was developed, and is maintained, by Florian Mayer for the
Western Australian [Department of Biodiversity, Conservation and
Attractions (DBCA)](https://www.dbca.wa.gov.au/). The development was
funded both by DBCA core funding and Offset funding through the [North
West Shelf Flatback Turtle Conservation
Program](https://flatbacks.dbca.wa.gov.au/).

To cite package `ruODK` in publications use:

``` r
citation("ruODK")
#> 
#> To cite ruODK in publications use:
#> 
#>   Florian W. Mayer (2019). ruODK: Client for the ODK Central API.
#>   R package version 0.6.6. https://github.com/dbca-wa/ruODK
#> 
#> A BibTeX entry for LaTeX users is
#> 
#>   @Misc{,
#>     title = {ruODK: Client for the ODK Central API},
#>     author = {Florian W. Mayer},
#>     note = {R package version 0.6.6},
#>     year = {2019},
#>     url = {https://github.com/dbca-wa/ruODK},
#>   }
```

## Acknowledgements

The Department of Biodiversity, Conservation and Attractions (DBCA)
respectfully acknowledges Aboriginal people as the traditional owners of
the lands and waters it manages.

One of the Department’s core missions is to conserve and protect the
value of the land to the culture and heritage of Aboriginal people.

This software was created both as a contribution to the ODK ecosystem
and for the conservation of the biodiversity of Western Australia, and
in doing so, caring for country.

## Package functionality

There are several other R packages interacting with the ODK ecosystem,
and/or
[OData](https://www.odata.org/).

### Comparison of ODK related software packages (non-ODK core)

| Package                         | [`ruODK`](https://dbca-wa.github.io/ruODK/)                                                                                                                                                                                                                                                                                                                                                                                            | [`odkr`](https://validmeasures.org/odkr/)                                                                                                                                                                                                            | [`odk`](https://cran.r-project.org/package=odk)                                                                     | [`odkmeta`](https://github.com/nap2000/odkmeta)                                                                                        | [`koboloadeR`](https://unhcr.github.io/koboloadeR/docs/index.html)                                                                                                                                                                                                                                                                                                                                                                   | [Pentaho Kettle tutorial](https://github.com/schemetrica/automating-data-delivery-odk-central)                                                                                                           |
| ------------------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------- | -------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Elevator pitch                  | “[ckanr](https://github.com/ropensci/ckanr) for ODK Central”                                                                                                                                                                                                                                                                                                                                                                           | “Drive ODK Briefcase through R”                                                                                                                                                                                                                      | “Export ODK Aggregate to SPSS”                                                                                      | “Export ODK Aggregate to STATA”                                                                                                        | “Metapackage for extended ODK ecosystem”                                                                                                                                                                                                                                                                                                                                                                                             | “What ruODK does, but as GUI”                                                                                                                                                                            |
| Last commit                     | [![Last-changedate](https://img.shields.io/github/last-commit/dbca-wa/ruODK.svg)](https://github.com/dbca-wa/ruODK/commits/master)                                                                                                                                                                                                                                                                                                     | [![Last-changedate](https://img.shields.io/github/last-commit/validmeasures/odkr.svg)](https://github.com/validmeasures/odkr/commits/master)                                                                                                         | Nov 2017                                                                                                            | [![Last-changedate](https://img.shields.io/github/last-commit/nap2000/odkmeta.svg)](https://github.com/nap2000/odkmeta/commits/master) | [![Last-changedate](https://img.shields.io/github/last-commit/unhcr/koboloadeR.svg)](https://github.com/unhcr/koboloadeR/commits/master)                                                                                                                                                                                                                                                                                             | [![Last-changedate](https://img.shields.io/github/last-commit/schemetrica/automating-data-delivery-odk-central.svg)](https://github.com/schemetrica/automating-data-delivery-odk-central/commits/master) |
| Website                         | [![](https://img.shields.io/static/v1?label=code&message=GitHub&color=brightgreen)](https://github.com/dbca-wa/ruODK) [![docs](https://img.shields.io/static/v1?label=docs&message=pkgdown&color=brightgreen)](https://dbca-wa.github.io/ruODK/)                                                                                                                                                                                       | [![](https://img.shields.io/static/v1?label=code&message=GitHub&color=brightgreen)](https://github.com/validmeasures/odkr) [![docs](https://img.shields.io/static/v1?label=docs&message=pkgdown&color=brightgreen)](https://validmeasures.org/odkr/) | [![docs](https://img.shields.io/static/v1?label=docs&message=rdrr.io&color=brightgreen)](https://rdrr.io/cran/odk/) | [![](https://img.shields.io/static/v1?label=code&message=GitHub&color=brightgreen)](https://github.com/nap2000/odkmeta)                | [![](https://img.shields.io/static/v1?label=code&message=GitHub&color=brightgreen)](https://github.com/unhcr/koboloadeR) [![docs](https://img.shields.io/static/v1?label=docs&message=pkgdown&color=brightgreen)](https://unhcr.github.io/koboloadeR/docs/index.html)                                                                                                                                                                | [![](https://img.shields.io/static/v1?label=code&message=GitHub&color=brightgreen)](https://github.com/schemetrica/automating-data-delivery-odk-central)                                                 |
| Test coverage                   | [![Travis build status](https://travis-ci.org/dbca-wa/ruODK.svg?branch=master)](https://travis-ci.org/dbca-wa/ruODK) [![AppVeyor build status](https://ci.appveyor.com/api/projects/status/github/dbca-wa/ruODK?branch=master&svg=true)](https://ci.appveyor.com/project/dbca-wa/ruODK) [![Coverage status](https://codecov.io/gh/dbca-wa/ruODK/branch/master/graph/badge.svg)](https://codecov.io/github/dbca-wa/ruODK?branch=master) | [![codecov](https://codecov.io/gh/validmeasures/odkr/branch/master/graph/badge.svg)](https://codecov.io/gh/validmeasures/odkr)                                                                                                                       | ❌                                                                                                                   | ❌                                                                                                                                      | [![Travis build status](https://travis-ci.org/unhcr/koboloadeR.svg?branch=gh-pages)](https://travis-ci.org/unhcr/koboloadeR) [![AppVeyor Build Status](https://ci.appveyor.com/api/projects/status/github/unhcr/koboloadeR?branch=gh-pages&svg=true)](https://ci.appveyor.com/project/unhcr/koboloadeR) [![codecov](https://codecov.io/gh/unhcr/koboloadeR/branch/gh-pages/graph/badge.svg)](https://codecov.io/gh/unhcr/koboloadeR) | NA                                                                                                                                                                                                       |
| Working examples                | README, 3 vignettes, pkgdown, Rmd templates                                                                                                                                                                                                                                                                                                                                                                                            | README, pkgdown                                                                                                                                                                                                                                      | CRAN PDF                                                                                                            | README                                                                                                                                 | README, 9 vignettes, shiny apps, pkgdown                                                                                                                                                                                                                                                                                                                                                                                             | Tutorial with screenshots                                                                                                                                                                                |
| Available on CRAN               | ❌ not yet                                                                                                                                                                                                                                                                                                                                                                                                                              | ❌                                                                                                                                                                                                                                                    | [![version](http://www.r-pkg.org/badges/version/odk)](https://CRAN.R-project.org/package=odk)                       | ❌                                                                                                                                      | ❌                                                                                                                                                                                                                                                                                                                                                                                                                                    | NA                                                                                                                                                                                                       |
| Technologies                    | Tidyverse R, XForms                                                                                                                                                                                                                                                                                                                                                                                                                    | Base R                                                                                                                                                                                                                                               | Base R                                                                                                              | Stata                                                                                                                                  | R metapackage, XlsForms                                                                                                                                                                                                                                                                                                                                                                                                              | Pentaho Kettle GUI                                                                                                                                                                                       |
| External dependencies           | None                                                                                                                                                                                                                                                                                                                                                                                                                                   | Java, ODK Briefcase                                                                                                                                                                                                                                  | SPSS                                                                                                                | Stata                                                                                                                                  | Java, ODK Briefcase, wraps `odkr`                                                                                                                                                                                                                                                                                                                                                                                                    | [Pentaho Kettle](http://www.ibridge.be/), Java                                                                                                                                                           |
| Affiliation                     | [DBCA WA](https://www.dbca.wa.gov.au/science) / [ROpenSci prospectus](https://github.com/ropensci/software-review/issues/335)                                                                                                                                                                                                                                                                                                          | [Valid Measues](https://github.com/validmeasures)                                                                                                                                                                                                    | [Muntashir-Al-Arefin](https://stackoverflow.com/users/8875690/muntashir-al-arefin)                                  | [ODK core developer Matt White](https://github.com/matthew-white)                                                                      | [UNHCR](https://github.com/unhcr)                                                                                                                                                                                                                                                                                                                                                                                                    | [Schemetrica](https://github.com/schemetrica)                                                                                                                                                            |
| Covers ODK Central OData API    | ✅                                                                                                                                                                                                                                                                                                                                                                                                                                      | ❌                                                                                                                                                                                                                                                    | ❌                                                                                                                   | ❌                                                                                                                                      | ❌                                                                                                                                                                                                                                                                                                                                                                                                                                    | ✅                                                                                                                                                                                                        |
| Covers ODK Central REST API     | ✅                                                                                                                                                                                                                                                                                                                                                                                                                                      | ❌                                                                                                                                                                                                                                                    | ❌                                                                                                                   | ❌                                                                                                                                      | ❌                                                                                                                                                                                                                                                                                                                                                                                                                                    | ❌                                                                                                                                                                                                        |
| Covers ODK Central bulk export  | ✅                                                                                                                                                                                                                                                                                                                                                                                                                                      | ❌                                                                                                                                                                                                                                                    | ❌                                                                                                                   | ❌                                                                                                                                      | ❌                                                                                                                                                                                                                                                                                                                                                                                                                                    | ✅                                                                                                                                                                                                        |
| Covers ODK Central OpenRosa API | ❌ no need, gets all data through OData/REST API                                                                                                                                                                                                                                                                                                                                                                                        | ✅ via ODK Briefcase                                                                                                                                                                                                                                  | ❌                                                                                                                   | ❌                                                                                                                                      | ✅ via ODK Briefcase                                                                                                                                                                                                                                                                                                                                                                                                                  | ✅                                                                                                                                                                                                        |
| Data post-processing            | ✅                                                                                                                                                                                                                                                                                                                                                                                                                                      | ✅                                                                                                                                                                                                                                                    | ❌                                                                                                                   | ❌                                                                                                                                      | ✅                                                                                                                                                                                                                                                                                                                                                                                                                                    | ✅                                                                                                                                                                                                        |
| Data visualisation examples     | ✅                                                                                                                                                                                                                                                                                                                                                                                                                                      | ❌                                                                                                                                                                                                                                                    | ❌                                                                                                                   | ❌                                                                                                                                      | ✅                                                                                                                                                                                                                                                                                                                                                                                                                                    | ❌                                                                                                                                                                                                        |

In summary:

`ruODK` provides a dependency-free interface to ODK Central.

`koboloadeR` is a metapackage containing lots of ancillary packages,
with some heavy dependencies on Java and ODK Briefcase (which in turn
can access ODK Central). Although built around the XlsForm standard and
paradigm, `koboloadeR` is well worth exploring as a larger context to
data wrangling in the ODK ecosystem.

Schemetrica’s tutorial illustrates data ETL from ODK Central and
deserves a special mention, as it is both very recent and aimed
specifically against ODK Central. The GUI paradigm of Pentaho Kettle
addresses a different audience to the scripting paradigm of `ruODK`. It
should be mentioned that Kettle’s composable data manipulation steps can
be used for many other use cases apart from ODK
Central.

### Comparison of OData related R packages

| Package                                         | [`ruODK`](https://dbca-wa.github.io/ruODK/)                                                                                                                                                                                                                                                                                                                                                                                            | [`odataR`](https://github.com/HanOostdijk/odataR)                                                                                            | [`cbsodataR`](https://github.com/edwindj/cbsodataR)                                                                                                                                                                                                                                                                                                                                          | [`OData`](https://cran.r-project.org/web/packages/OData/index.html)                                                                   | [OData JDBC R tutorial](https://www.cdata.com/kb/tech/odata-jdbc-r.rst)                                                               |
| ----------------------------------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | -------------------------------------------------------------------------------------------------------------------------------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------- |
| Elevator pitch                                  | “[ckanr](https://github.com/ropensci/ckanr) for ODK Central”                                                                                                                                                                                                                                                                                                                                                                           | “OData client for <https://opendata.cbs.nl> (and similar)”                                                                                   | “OData client for <https://www.cbs.nl>”                                                                                                                                                                                                                                                                                                                                                      | “Minimal OData example”                                                                                                               | “Minimal RJDBC example”                                                                                                               |
| Last commit                                     | [![Last-changedate](https://img.shields.io/github/last-commit/dbca-wa/ruODK.svg)](https://github.com/dbca-wa/ruODK/commits/master)                                                                                                                                                                                                                                                                                                     | [![Last-changedate](https://img.shields.io/github/last-commit/HanOostdijk/odataR.svg)](https://github.com/HanOostdijk/odataR/commits/master) | [![Last-changedate](https://img.shields.io/github/last-commit/edwindj/cbsodataR.svg)](https://github.com/edwindj/cbsodataR/commits/master)                                                                                                                                                                                                                                                   | Dec 2016                                                                                                                              | ❓                                                                                                                                     |
| Website                                         | [![](https://img.shields.io/static/v1?label=code&message=GitHub&color=brightgreen)](https://github.com/dbca-wa/ruODK) [![docs](https://img.shields.io/static/v1?label=docs&message=pkgdown&color=brightgreen)](https://dbca-wa.github.io/ruODK/)                                                                                                                                                                                       | [![](https://img.shields.io/static/v1?label=code&message=GitHub&color=brightgreen)](https://github.com/HanOostdijk/odataR)                   | [![docs](https://img.shields.io/static/v1?label=code&message=CRAN&color=green)](https://cran.r-project.org/web/packages/cbsodataR/) [![](https://img.shields.io/static/v1?label=code&message=GitHub&color=brightgreen)](https://github.com/edwindj/cbsodataR) [![docs](https://img.shields.io/static/v1?label=docs&message=pkgdown&color=brightgreen)](https://edwindj.github.io/cbsodataR/) | [![](https://img.shields.io/static/v1?label=code&message=CRAN&color=green)](https://cran.r-project.org/web/packages/OData/index.html) | [![docs](https://img.shields.io/static/v1?label=docs&message=html&color=brightgreen)](https://www.cdata.com/kb/tech/odata-jdbc-r.rst) |
| Test coverage                                   | [![Travis build status](https://travis-ci.org/dbca-wa/ruODK.svg?branch=master)](https://travis-ci.org/dbca-wa/ruODK) [![AppVeyor build status](https://ci.appveyor.com/api/projects/status/github/dbca-wa/ruODK?branch=master&svg=true)](https://ci.appveyor.com/project/dbca-wa/ruODK) [![Coverage status](https://codecov.io/gh/dbca-wa/ruODK/branch/master/graph/badge.svg)](https://codecov.io/github/dbca-wa/ruODK?branch=master) | ❌                                                                                                                                            | [![Travis-CI Build Status](https://travis-ci.org/edwindj/cbsodataR.png?branch=master)](https://travis-ci.org/edwindj/cbsodataR) [![AppVeyor Build Status](https://ci.appveyor.com/api/projects/status/github/edwindj/cbsodatar?branch=master)](https://ci.appveyor.com/project/edwindj/cbsodatar)                                                                                            | ❌                                                                                                                                     | ❌                                                                                                                                     |
| Targets ODK Central                             | ✅                                                                                                                                                                                                                                                                                                                                                                                                                                      | ❌                                                                                                                                            | ❌                                                                                                                                                                                                                                                                                                                                                                                            | ❌                                                                                                                                     | ❌                                                                                                                                     |
| Works with ODK Central                          | ✅                                                                                                                                                                                                                                                                                                                                                                                                                                      | ❓                                                                                                                                            | ❓                                                                                                                                                                                                                                                                                                                                                                                            | ❌                                                                                                                                     | ❌                                                                                                                                     |
| Data wrangling helpers for post-processing      | ✅                                                                                                                                                                                                                                                                                                                                                                                                                                      | some                                                                                                                                         | some                                                                                                                                                                                                                                                                                                                                                                                         | ❌                                                                                                                                     | ❌                                                                                                                                     |
| Actively maintained to work against ODK Central | ✅                                                                                                                                                                                                                                                                                                                                                                                                                                      | ❌                                                                                                                                            | ❌                                                                                                                                                                                                                                                                                                                                                                                            | ❌                                                                                                                                     | ❌                                                                                                                                     |
| Technologies                                    | R, httr, xml2, tidyr, purrr                                                                                                                                                                                                                                                                                                                                                                                                            | R, jsonlite, tidyverse                                                                                                                       | R, tidyverse                                                                                                                                                                                                                                                                                                                                                                                 | R, XML, RJSONIO                                                                                                                       | R, RJDBC, Java                                                                                                                        |
| External dependencies                           | ✅ None                                                                                                                                                                                                                                                                                                                                                                                                                                 | ✅ None                                                                                                                                       | ✅ None                                                                                                                                                                                                                                                                                                                                                                                       | ✅ None                                                                                                                                | ❌ JDBC, Java                                                                                                                          |
| Available on CRAN                               | ❌                                                                                                                                                                                                                                                                                                                                                                                                                                      | ❌                                                                                                                                            | [![version](http://www.r-pkg.org/badges/version/cbsodataR)](https://CRAN.R-project.org/package=cbsodataR)                                                                                                                                                                                                                                                                                    | [![version](http://www.r-pkg.org/badges/version/OData)](https://CRAN.R-project.org/package=OData)                                     | ❌                                                                                                                                     |

In summary:

`ruODK` is the only R package explicitly aimed at ODK Central, both its
OData and the RESTful API, and provide context and helpers around
specific recurring data wrangling tasks.

Wrangling OData output boils down to handling HTTP requests, navigating
nested lists (from XML) and rectangling them into tidy data.

The value of OData lies in its self-descriptive nature, which allows
tools to introspect the data structures and types. Whereas GUI-driven
tools like MS PowerBI use this introspection to assist users in
wrangling their own data, `ruODK` aims to lower the barrier to the
R-literate user, and reduce the data wrangling to simple, extensible
steps in line with tidyverse’s data wrangling paradigm. Providing this
functionality in a pure R environment allows to automate the data
extraction, transformation, and reporting pipeline, and therefore
provide reproducible reporting.
