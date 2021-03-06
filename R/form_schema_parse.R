#' Parse a form_schema into a tibble of fields with name, type, and path.
#'
#' \lifecycle{maturing}
#'
#' The `form_schema` is a nested list of lists containing the form definition.
#' The form definition consists of fields (with a type and name), and form
#' groups, which are rendered as separate ODK Collect screens.
#' Form groups in turn can also contain form fields.
#'
#' \code{\link{form_schema_parse}} recursively unpacks the form and extracts the
#' name and type of each field. This information then can be used to inform the
#' user which columns require \code{\link{ru_datetime}},
#' \code{\link{attachment_get}}, or \code{\link{attachment_link}}, respectively.
#'
#' @param fs The output of form_schema as nested list
#' @param path The base path for form fields. Default: "Submissions".
#'   \code{\link{form_schema_parse}} recursively steps into deeper nesting
#'   levels, which are reflected as separate OData tables.
#'   The returned value in `path` reflects the XForm group name, which
#'   translates to separate screens in ODK Collect.
#'   Non-repeating form groups will be flattened out into the main Submissions
#'   table. Repeating groups are available as separate OData tables.
#' @template param-verbose
#' @family restful-api
#' @export
#' @examples
#' \dontrun{
#' # Option 1: in two steps
#' fs <- form_schema(flatten = FALSE) # Default, but shown for clarity
#' fsp <- form_schema_parse(fs)
#'
#' # Option 2: in one go
#' fsp <- form_schema(parse = TRUE)
#'
#' fsp
#'
#' # Attachments: use \\code{\\link{attachment_get}} on each of
#' fsp %>% dplyr::filter(type == "binary")
#'
#' # dateTime: use \\code{\\link{ru_datetime}} on each of
#' fsp %>% dplyr::filter(type == "dateTime")
#'
#' # Point location: will be split into lat/lon/alt/acc
#' fsp %>% dplyr::filter(type == "geopoint")
#' }
form_schema_parse <- function(fs, path = "Submissions", verbose = FALSE) {
  # 00. Recursion airbag
  # if (!(is.list(fs) && "children" %in% names(fs))) return(NULL)

  # 0. Spray R CMD check with WD-40
  type <- name <- children <- NULL

  # 1. Grab next level type/name pairs, append column "path".
  # This does not work recursively - if it did, we'd be done here.
  x <- fs %>%
    rlist::list.select(type, name) %>%
    rlist::list.stack(.) %>%
    dplyr::mutate(path = path)

  if (verbose == TRUE) {
    message(crayon::cyan(
      glue::glue("{clisymbols::symbol$info}\n\nFound fields:\n{str(x)}\n")
    ))
  }


  # 2. Recursively run form_schema_parse over nested elements.
  for (node in fs) {
    # Recursion seatbelt: only step into lists containing "children".
    if (is.list(node) &&
      "children" %in% names(node) &&
      "name" %in% names(node)) {
      for (child in node) {
        if (verbose == TRUE) {
          message(crayon::cyan(
            glue::glue(
              "{clisymbols::symbol$info}\n\nFound child: {child}\n"
            )
          ))
        }

        odata_table_path <- glue::glue("{path}.{node['name']}")
        xxx <- form_schema_parse(child, path = odata_table_path)
        x <- rbind(x, xxx)
      }
    }
  }

  # 3. Return combined type/name pairs as tibble
  if (verbose == TRUE) {
    message(crayon::cyan(
      glue::glue("{clisymbols::symbol$info} Returning data \"{str(x)}\"")
    ))
  }

  x %>% tibble::as_tibble()
}

# Tests
# usethis::edit_file("tests/testthat/test-form_schema_parse.R")
