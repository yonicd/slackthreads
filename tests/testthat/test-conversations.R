test_that("get_conversations works", {
  # Make sure default values work.
  test_result <- get_conversations()
  expect_s3_class(test_result, c("conversation_tbl", "tbl_df"))

  expected_colnames <- c(
    "channel", "client_msg_id", "type", "text", "user", "ts", "team",
    "blocks", "thread_ts", "reply_count", "reply_users_count", "latest_reply",
    "reply_users", "replies", "subscribed", "subtype", "username",
    "icons", "bot_id", "reactions", "edited", "files", "upload",
    "display_as_bot", "last_read", "attachments", "root", "inviter"
  )

  expect_equal(colnames(test_result), expected_colnames)

  # By default we should get 100 results. Note: This test is slightly unstable,
  # if the default channel for this slack has less than 100 messages available
  # in the most recent 10k messages. Most of the time this should be true,
  # though, and it's worth raising a flag if it isn't.
  expect_equal(nrow(test_result), 100)

  # Check that limits work.
  test_result <- get_conversations(limit = 10)
  expect_s3_class(test_result, c("conversation_tbl", "tbl_df"))
  expect_equal(nrow(test_result), 10)

  # Request a specific channel.
  test_result <- get_conversations(limit = 10, channel = "1_explore_wrangle")
  expect_s3_class(test_result, c("conversation_tbl", "tbl_df"))
  expect_equal(nrow(test_result), 10)

  # If we request a channel that doesn't exist, Slack will throw an error.
  expect_error(
    get_conversations(channel = "not_a_channel"),
    "channel_not_found"
  )
})
