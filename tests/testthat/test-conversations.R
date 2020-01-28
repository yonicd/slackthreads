slackteams::load_teams()
slackteams::activate_team("r4ds")

channel <- "5_general_r_help"

test_that("confirm that our expected channel name still exists", {
  # This test is here to help us diagnose the case where something changed in
  # the R4DS slack.
  expect_error(
    validate_channel(channel),
    NA
  )

  expect_error(
    validate_channel("this_is_not_a_channel"),
    "Unknown channel."
  )
})

test_that("can get conversations", {
  # All of the specific parameters are tested in slackteams, so we just need to
  # make sure the function returns what we expect.

  test_result <- conversations(channel = channel, max_results = 2)
  expect_s3_class(test_result, c("conversations.history", "list"))
  expect_length(test_result, 2)
  expect_identical(
    attr(test_result, "channel"),
    validate_channel(channel)
  )

  expect_identical(
    names(test_result[[1]]),
    c("type", "text", "files", "upload", "blocks", "user", "display_as_bot",
      "ts", "client_msg_id", "thread_ts", "reply_count", "reply_users_count",
      "latest_reply", "reply_users", "replies", "subscribed")
  )
  expect_s3_class(
    test_result[[1]],
    c("conversation", "list")
  )
  expect_identical(
    attr(test_result[[1]], "channel"),
    validate_channel(channel)
  )
})

test_that("can get replies to a conversation", {
  test_conversations <- conversations(channel = channel, max_results = 1)
  test_replies <- conversation_replies(test_conversations[[1]])
  expect_s3_class(test_replies, c("conversations.replies", "list"))
  expect_length(test_replies, 5)
  expect_identical(
    attr(test_replies, "channel"),
    validate_channel(channel)
  )

  expect_identical(
    names(test_replies[[1]]),
    c("type", "text", "files", "upload", "blocks", "user", "display_as_bot",
      "ts", "client_msg_id", "thread_ts", "parent_user_id", "reactions")
  )
  expect_s3_class(
    test_replies[[1]],
    c("reply", "list")
  )
  expect_identical(
    attr(test_replies[[1]], "channel"),
    validate_channel(channel)
  )
})

test_that("conversations and replies fail gracefully", {
  empty_thread <- replies(ts = "1579727108.059200", channel = channel)
  expect_length(empty_thread, 0)
  expect_s3_class(empty_thread, c("conversations.replies", "list"))
  expect_identical(
    attr(empty_thread, "channel"),
    validate_channel(channel)
  )

  # I've never had a private convo with this randomly selected member. We can
  # swap this to something less fragile if you have ideas.
  uncontacted <- conversations(channel = "@jimrothstein")
  expect_length(uncontacted, 0)
  expect_s3_class(uncontacted, c("conversations.history", "list"))
  expect_identical(
    attr(uncontacted, "channel"),
    "DKWLLRXA6"
  )
})
