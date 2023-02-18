# Set up tests. ---------------------------------------------------------------
# While this *could* go into a setup.R file, that makes interactive testing
# annoying. I compromised and put it in a collapsible block at the top of each
# test file.

# To test the API:

# Sys.setenv(SLACK_API_TEST_MODE = "true")

# To capture test data:

# Sys.setenv(SLACK_API_TEST_MODE = "capture")

# To go back to a "normal" mode:

# Sys.unsetenv("SLACK_API_TEST_MODE")

slack_api_test_mode <- Sys.getenv("SLACK_API_TEST_MODE")
withr::defer(rm(slack_api_test_mode))

library(httptest)

# All tests use #slack-r on slackr-test (or a mocked version of it).
slack_test_channel <- "CNTFB9215"
withr::defer(rm(slack_test_channel))

if (slack_api_test_mode == "true" || slack_api_test_mode == "capture") {
  # In these modes we need a real API token. If one isn't set, this should throw
  # an error right away.
  if (Sys.getenv("SLACK_API_TOKEN") == "") {
    stop(
      "No SLACK_API_TOKEN available, cannot test. \n",
      "Unset SLACK_API_TEST_MODE to use mock.")
  }

  if (slack_api_test_mode == "true") {
    # Override the main mock function from httptest, so we use the real API.
    with_mock_api <- force
  } else {
    # This tricks httptest into capturing results instead of actually testing.
    with_mock_api <- httptest::capture_requests
  }
  withr::defer(rm(with_mock_api))
}

# Team setup. ------------------------------------------------------------------

with_mock_api({
  info <- slackteams:::get_team_info()
  slackteams::add_team(info$team$name, Sys.getenv('SLACK_API_TOKEN'))
  slackteams::activate_team('slackr')
})

# Tests. -----------------------------------------------------------------------

# Notes: Some of these are repetetive, but most of the time we'll be using the
# mock, so repetetive tests shouldn't be a huge problem.

test_that("Can get conversations", {
  expect_error(
    with_mock_api({
      test_conversations <- conversations(
        channel = slack_test_channel, limit = 5, max_results = 5
      )
    }),
    NA
  )

  expect_s3_class(test_conversations, c("conversations.history", "list"))
  expect_length(test_conversations, 5L)
  expect_s3_class(
    test_conversations[[1]],
    c("conversation", "list")
  )
  expect_identical(
    attr(test_conversations[[1]], "channel"),
    slack_test_channel
  )
})

test_that("Can get replies", {
  with_mock_api({
    test_conversations <- conversations(
      channel = slack_test_channel, limit = 5, max_results = 5
    )
  })
  expect_error(
    with_mock_api({
      test_replies <- conversation_replies(test_conversations[[1]])
    }),
    NA
  )

  expect_s3_class(
    test_replies,
    c("conversations.replies", "list")
  )
  expect_identical(
    attr(test_replies, "channel"),
    slack_test_channel
  )
})

test_that("Can get all replies at once to a set of conversations", {
  with_mock_api({
    test_conversations <- conversations(
      channel = slack_test_channel, limit = 5, max_results = 5
    )
  })
  with_mock_api({
    test_replies <- conversation_replies(test_conversations[[1]])
  })
  expect_error(
    with_mock_api({
      test_all_replies <- all_conversation_replies(test_conversations)
    }),
    NA
  )

  expect_type(test_all_replies, "list")
  expect_length(test_all_replies, length(test_conversations))
  expect_identical(test_all_replies[[1]], test_replies)
})

test_that("Conversations and replies fail gracefully", {
  expect_error(
    with_mock_api({
      test_empty_thread <- replies(
        ts = "1569458224.000500", channel = slack_test_channel
      )
    }),
    NA
  )

  expect_length(test_empty_thread, 0L)
  expect_s3_class(test_empty_thread, c("conversations.replies", "list"))
  expect_identical(
    attr(test_empty_thread, "channel"),
    slack_test_channel
  )
})
