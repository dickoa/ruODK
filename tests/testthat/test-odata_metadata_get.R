context("test-odata_metadata_get.R")

test_that("odata_metadata_get works", {
  md <- odata_metadata_get(
    get_test_pid(),
    get_test_fid(),
    url = get_test_url(),
    un = get_test_un(),
    pw = get_test_pw()
  )
  testthat::expect_equal(class(md), "list")
})

# Tests code
# usethis::edit_file("R/odata_metadata_get.R")
