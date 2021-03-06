context("test-attachment_list.R")

test_that("attachment_list works", {
  sl <- submission_list(
    pid = get_test_pid(),
    fid = get_test_fid(),
    url = get_test_url(),
    un = get_test_un(),
    pw = get_test_pw()
  )

  al <- get_one_submission_attachment_list(
    sl$instance_id[[1]],
    pid = get_test_pid(),
    fid = get_test_fid(),
    url = get_test_url(),
    un = get_test_un(),
    pw = get_test_pw()
  )

  all <- attachment_list(
    sl$instance_id,
    pid = get_test_pid(),
    fid = get_test_fid(),
    url = get_test_url(),
    un = get_test_un(),
    pw = get_test_pw()
  )

  # attachment_list returns a tibble
  testthat::expect_equal(class(al), c("tbl_df", "tbl", "data.frame"))

  # Attachment attributes are the tibble's columns
  cn <- c("name", "exists")
  testthat::expect_equal(names(al), cn)
})

# Tests code
# usethis::edit_file("R/attachment_list.R")
