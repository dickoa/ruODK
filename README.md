
<!-- README.md is generated from README.Rmd. Please edit that file -->

# ruODK: Client for the ODK Central API <img src="man/figures/ruODK.png" align="right" alt="Are you ODK?" width="120" />

<!-- badges: start -->

[![Project Status: WIP – Initial development is in progress, but there
has not yet been a stable, usable release suitable for the
public.](https://www.repostatus.org/badges/latest/wip.svg)](https://www.repostatus.org/#wip)
[![GitHub
issues](https://img.shields.io/github/issues/dbca-wa/ruodk.svg?style=popout)](https://github.com/dbca-wa/ruODK/issues)
[![Travis build
status](https://travis-ci.org/dbca-wa/ruODK.svg?branch=master)](https://travis-ci.org/dbca-wa/ruODK)
[![AppVeyor build
status](https://ci.appveyor.com/api/projects/status/github/dbca-wa/ruODK?branch=master&svg=true)](https://ci.appveyor.com/project/dbca-wa/ruODK)
[![Coverage
status](https://codecov.io/gh/dbca-wa/ruODK/branch/master/graph/badge.svg)](https://codecov.io/github/dbca-wa/ruODK?branch=master)
<!-- badges: end -->

Especially in these trying times, it is important to ask: “r u ODK?”

[ODK Central](https://docs.opendatakit.org/central-intro/) an Open Data
Kit server alternative to ODK Aggregate. It manages user accounts and
permissions, stores form definitions, and allows data collection clients
like ODK Collect to connect to it for form download and submission
upload.

After data have been captured digitally using ODK Collect, the data are
uploaded and stored in ODK Central. The next step from there is to
extract the data, optionally upload it into another data warehouse, and
then to analyse and generate insight from it.

While data can be retrieved in bulk through the GUI, ODK Central’s API
provides access to its data and functionality through both an OData and
a RESTful API with a comprehensive and interactive
[documentation](https://odkcentral.docs.apiary.io/#reference/odata-endpoints).

`ruODK`’s scope:

  - To wrap all ODK Central API endpoints with a focus on **data
    access**.
  - To provide working examples of interacting with the ODK Central API.
  - To provide convenience helpers for the day to day tasks when working
    with ODK Central data in R: **data munging** the ODK Central API
    output into tidy R formats.

`ruODK`’s use cases:

  - Smaller projects:
      - Data collection: ODK Collect `%>%`
      - Data clearinghouse: ODK Central `%>%`
      - Data analysis and reporting: `Rmd` (ruODK) `%>%`
      - Publishing and dissemination:
        [`ckanr`](https://docs.ropensci.org/ckanr/),
        [`CKAN`](https://ckan.org/)
  - Larger projects:
      - Data collection: ODK Collect `%>%`
      - Data clearinghouse: ODK Central `%>%`
      - ETL pipeline into data warehouses: `Rmd` (ruODK) `%>%`
      - QA: in data warehouse `%>%`
      - Reporting: `Rmd` `%>%`
      - Publishing and dissemination:
        [`ckanr`](https://docs.ropensci.org/ckanr/),
        [`CKAN`](https://ckan.org/)

Out of scope:

  - To wrap “management” API endpoints. The ODK Central GUI already is a
    fantastic interface for the management of users, roles, permissions,
    projects, and forms. In fact, it is a [VueJS
    application](https://github.com/opendatakit/central-frontend/)
    working on the “management” API endpoints of the ODK Central
    backend.
  - To provide extensive data visualisation. We show only minimal
    examples of data visualisation and presentation, mainly to
    illustrate the example data. Once the data is in your hands as tidy
    tibbles… u r ODK\!

## Install

You can install ruODK from GitHub with:

``` r
# install.packages("devtools")
remotes::install_github("dbca-wa/ruODK", dependencies = TRUE)
```

## ODK Central

### ODK Central instance

First, we need an ODK Central instance and some data to play with\!

Either ask in the \[ODK forum\] for an account in the [ODK Central
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
  - Create a Xform, e.g. using ODK Build, or use the provided example
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

## Configure ruODK

For a quick start, run the following chunk with your settings:

``` r
Sys.setenv(ODKC_URL = "https://odkcentral.mydomain.com")
Sys.setenv(ODKC_UN = "me@mail.com")
Sys.setenv(ODKC_PW = ".......")
```

For a more permanent configuration setting, paste the above lines into
your `~/.Rprofile`.

For all available detailed options to configure `ruODK`, read
`vignette("Setup", package = "ruODK")` (online
\[here\]\](<https://dbca-wa.github.io/ruODK/articles/setup.html>)).

## Use ruODK

A quick example using the OData service:

``` r
library(ruODK)

# ODK Central credentials
if (file.exists("~/.Rprofile")) source("~/.Rprofile")
# .RProfile sets ODKC_{URL, UN, PW}

# ODK Central OData service URL
# "https://sandbox.central.opendatakit.org/v1/projects/14/forms/build_Flora-Quadrat-0-2_1558575936.svc"

# Download from ODK Central
proj <- project_list()
proj

meta <- ruODK::get_metadata(
  pid = 1,
  fid = "build_Turtle-Sighting-0-1_1559790020"
)
# listviewer::jsonedit(meta)

data <- ruODK::get_submissions(
  pid = 1,
  fid = "build_Turtle-Sighting-0-1_1559790020"
) %>%
  ruODK::parse_submissions()
data %>% head(.)
```

A more detailed walk-through with some data visualisation examples is
available in the `vignette("odata", package="ruODK")` (online
\[here\]\](<https://dbca-wa.github.io/ruODK/articles/odata.html>)).

See also `vignette("restapi", package="ruODK")` (online
\[here\]\](<https://dbca-wa.github.io/ruODK/articles/api.html>)) for
examples using the alternative RESTful API.

## Contribute

Contributions through [issues](https://github.com/dbca-wa/ruODK/issues)
and PRs are welcome\!

## Release

These steps prepare a new `ruODK` release.

``` r
# Tests
devtools::test()

# Docs
codemetar::write_codemeta("ruODK")
devtools::document(roclets = c("rd", "collate", "namespace"))
usethis::edit_file("inst/CITATION")
rmarkdown::render('README.Rmd',  encoding = 'UTF-8')

# Checks
styler::style_pkg()
spelling::spell_check_package()
goodpractice::goodpractice(quiet = FALSE)
devtools::check()

# Release
usethis::use_version("minor")
usethis::edit_file("NEWS.md")
pkgdown::build_site()

# Vignetts are big
# the repo is small
# so what shall we do
# let's mogrify all
system("find vignettes/attachments/ -maxdepth 2 -type f -exec mogrify -resize 300x200 {} \\;")
vignette_tempfiles <- here::here("vignettes", "attachments")
fs::dir_copy(vignette_tempfiles, here::here("docs/articles/attachments"))
if (fs::dir_exists(vignette_tempfiles)) fs::dir_delete(vignette_tempfiles)

# Git commit and push
```

## Attribution

`ruODK` was developed, and is maintained, by Florian Mayer for the
Western Australian [Department of Biodiversity, Conservation and
Attractions (DBCA)](https://www.dbca.wa.gov.au/). The development was
funded both by DBCA core funding and Offset funding through the [North
West Shelf Flatback Turtle Conservation
Program](https://flatbacks.dbca.wa.gov.au/).

## Citation

To cite package `ruODK` in publications use:

``` r
citation("ruODK")
#> 
#> To cite ruODK in publications use:
#> 
#>   Florian W. Mayer (2019). ruODK: Client for the ODK Central API.
#>   R package version 0.3.1. https://github.com/dbca-wa/ruODK
#> 
#> A BibTeX entry for LaTeX users is
#> 
#>   @Misc{,
#>     title = {ruODK: Client for the ODK Central API},
#>     author = {Florian W. Mayer},
#>     note = {R package version 0.3.1},
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
