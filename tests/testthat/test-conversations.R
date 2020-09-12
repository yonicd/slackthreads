testthat::context('conversations')

info <- slackteams:::get_team_info(token = Sys.getenv('SLACK_API_TOKEN'))
slackteams::add_team(info$team$name,Sys.getenv('SLACK_API_TOKEN'))
slackteams::activate_team('slackr')
channel <- "CNTFB9215"

test_channel <- conversations(channel = channel, limit = 5, max_results = 5)
test_conversations <- conversations(channel = channel, limit = 1, max_results = 5)
test_replies <- conversation_replies(test_conversations[[1]])
test_empty_thread <- replies(ts = "1569458224.000500", channel = channel)

testthat::describe("can get conversations", {
  # All of the specific parameters are tested in slackteams, so we just need to
  # make sure the function returns what we expect.

  it('class',{
    expect_s3_class(test_channel, c("conversations.history", "list"))
  })

  it('length',{
    expect_length(test_channel, 5L)
  })

  it('result class',{
    testthat::expect_s3_class(
      test_channel[[1]],
      c("conversation", "list")
    )
  })

  it('element channel',{
    testthat::expect_identical(
      attr(test_channel[[1]], "channel"),
      channel
    )
  })
})

testthat::describe("can get replies to a conversation", {

  it('object class',{
    testthat::expect_s3_class(test_replies,
                              c("conversations.replies", "list"))
  })

  it('object channel',{
    testthat::expect_identical(
      attr(test_replies, "channel"),
      channel
    )
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
      channel
    )
  })

})

})
