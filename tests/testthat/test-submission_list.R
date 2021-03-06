test_that("submission_list works", {
  sl <- submission_list(
    get_test_pid(),
    get_test_fid(),
    url = get_test_url(),
    un = get_test_un(),
    pw = get_test_pw()
  )
  fl <- form_list(
    get_test_pid(),
    url = get_test_url(),
    un = get_test_un(),
    pw = get_test_pw()
  )
  # submission_list returns a tibble
  testthat::expect_equal(class(sl), c("tbl_df", "tbl", "data.frame"))

  # Submission attributes are the tibble's columns
  cn <- c(
    "instance_id", "submitter_id", "device_id", "created_at", "updated_at"
  )
  testthat::expect_equal(names(sl), cn)

  # Number of submissions (rows) is same as advertised in form_list
  form_list_nsub <- fl %>%
    dplyr::filter(fid == get_test_fid()) %>%
    magrittr::extract2("submissions") %>%
    as.numeric()
  testthat::expect_equal(nrow(sl), form_list_nsub)
})

# Tests
# usethis::edit_file("R/submission_list.R")
