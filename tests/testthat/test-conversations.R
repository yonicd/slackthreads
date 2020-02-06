tf <- tempfile()
on.exit(unlink(tf))

write.dcf(data.frame(
  channel = '#r',
  api_token = Sys.getenv('SLACK_API_TOKEN'),
  incoming_webhook_url = Sys.getenv('SLACK_WEBHOOK'),
  stringsAsFactors = FALSE),file = tf)

slackteams::load_team_dcf('r4ds',file = tf)
slackteams::activate_team('r4ds')
channel <- "5_general_r_help"

test_channel <- conversations(channel = channel, limit = 5, max_results = 5)
test_conversations <- conversations(channel = channel, limit = 1, max_results = 5)
test_replies <- conversation_replies(test_conversations[[1]])
test_empty_thread <- replies(ts = "1579727108.059200", channel = channel)
#test_uncontacted <- conversations(channel = "@jimrothstein")

# This test is here to help us diagnose the case where something changed in
# the R4DS slack.

testthat::describe("confirm that our expected channel name still exists", {

  it('valid channel',{
    testthat::expect_equal(
      validate_channel(channel),
      "C6VCZPGPR"
    )
  })

  it('invalid channel',{
    testthat::expect_error(
      validate_channel("this_is_not_a_channel"),
      regexp = 'Unknown channel.'
    )
  })

})

testthat::describe("can get conversations", {
  # All of the specific parameters are tested in slackteams, so we just need to
  # make sure the function returns what we expect.

  it('class',{
    expect_s3_class(test_channel, c("conversations.history", "list"))
  })

  it('length',{
    expect_length(test_channel, 5L)
  })

  # it('attr channel',{
  #   testthat::expect_identical(
  #     attr(test_channel, "channel"),
  #     threads:::validate_channel(channel)
  #   )
  # })

  # it('element names',{
  #   testthat::expect_identical(
  #     names(test_channel[[1]]),
  #     c("client_msg_id","type", "text", "user", "ts", 'team','attachments', "blocks", "thread_ts", "reply_count", "reply_users_count", "latest_reply", "reply_users", "replies", "subscribed")
  #   )
  # })

  it('result class',{
    testthat::expect_s3_class(
      test_channel[[1]],
      c("conversation", "list")
    )
  })

  it('element channel',{
    testthat::expect_identical(
      attr(test_channel[[1]], "channel"),
      validate_channel(channel)
    )
  })
})

testthat::describe("can get replies to a conversation", {

  it('object class',{
    testthat::expect_s3_class(test_replies,
                              c("conversations.replies", "list"))
  })

  # it('object length',{
  #   testthat::expect_length(test_replies, 1L)
  # })

  it('object channel',{
    testthat::expect_identical(
      attr(test_replies, "channel"),
      validate_channel(channel)
    )
  })

  # it('element names',{
  #   testthat::expect_identical(
  #     names(test_replies[[1]]),
  #     c("client_msg_id", "type", "text", "user", "ts", 'team', 'blocks', "thread_ts", "parent_user_id")
  #   )
  # })

  # it('element class',{
  #   testthat::expect_s3_class(
  #     test_replies[[1]],
  #     c("reply", "list")
  #   )
  # })

  # it('element channel',{
  #   testthat::expect_identical(
  #     attr(test_replies[[1]], "channel"),
  #     validate_channel(channel)
  #   )
  # })
})

testthat::describe("conversations and replies fail gracefully", {

  it('thread length',{
    testthat::expect_length(test_empty_thread, 0L)
  })

  it('thread class',{
    testthat::expect_s3_class(test_empty_thread, c("conversations.replies", "list"))
  })

  it('thread channel',{
    testthat::expect_identical(
      attr(test_empty_thread, "channel"),
      validate_channel(channel)
    )
  })

  # I've never had a private convo with this randomly selected member. We can
  # swap this to something less fragile if you have ideas.

  # it('thread length',{
  #   testthat::expect_length(test_uncontacted, 0)
  # })
  #
  # it('thread class',{
  #   testthat::expect_s3_class(test_uncontacted, c("conversations.history", "list"))
  # })
  #
  # it('thread channel',{
  #   testthat::expect_identical(
  #     attr(test_uncontacted, "channel"),
  #     "DKWLLRXA6"
  #   )
  # })

})
