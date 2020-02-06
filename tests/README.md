Tests and Coverage
================
06 February, 2020 18:18:45

  - [Coverage](#coverage)
  - [Unit Tests](#unit-tests)

This output is created by
[covrpage](https://github.com/metrumresearchgroup/covrpage).

## Coverage

Coverage summary is created using the
[covr](https://github.com/r-lib/covr) package.

| Object                                    | Coverage (%) |
| :---------------------------------------- | :----------: |
| slackthreads                              |     100      |
| [R/conversations.R](../R/conversations.R) |     100      |

<br>

## Unit Tests

Unit Test summary is created using the
[testthat](https://github.com/r-lib/testthat)
package.

| file                                                  |  n |  time | error | failed | skipped | warning |
| :---------------------------------------------------- | -: | ----: | ----: | -----: | ------: | ------: |
| [test-conversations.R](testthat/test-conversations.R) | 11 | 0.008 |     0 |      0 |       0 |       0 |

<details closed>

<summary> Show Detailed Test Results
</summary>

| file                                                            | context       | test                                                                 | status | n |  time |
| :-------------------------------------------------------------- | :------------ | :------------------------------------------------------------------- | :----- | -: | ----: |
| [test-conversations.R](testthat/test-conversations.R#L26_L29)   | conversations | confirm that our expected channel name still exists: valid channel   | PASS   | 1 | 0.001 |
| [test-conversations.R](testthat/test-conversations.R#L33_L36)   | conversations | confirm that our expected channel name still exists: invalid channel | PASS   | 1 | 0.002 |
| [test-conversations.R](testthat/test-conversations.R#L46)       | conversations | can get conversations: class                                         | PASS   | 1 | 0.001 |
| [test-conversations.R](testthat/test-conversations.R#L50)       | conversations | can get conversations: length                                        | PASS   | 1 | 0.001 |
| [test-conversations.R](testthat/test-conversations.R#L68_L71)   | conversations | can get conversations: result class                                  | PASS   | 1 | 0.000 |
| [test-conversations.R](testthat/test-conversations.R#L75_L78)   | conversations | can get conversations: element channel                               | PASS   | 1 | 0.000 |
| [test-conversations.R](testthat/test-conversations.R#L85_L86)   | conversations | can get replies to a conversation: object class                      | PASS   | 1 | 0.000 |
| [test-conversations.R](testthat/test-conversations.R#L94_L97)   | conversations | can get replies to a conversation: object channel                    | PASS   | 1 | 0.001 |
| [test-conversations.R](testthat/test-conversations.R#L125)      | conversations | conversations and replies fail gracefully: thread length             | PASS   | 1 | 0.001 |
| [test-conversations.R](testthat/test-conversations.R#L129)      | conversations | conversations and replies fail gracefully: thread class              | PASS   | 1 | 0.000 |
| [test-conversations.R](testthat/test-conversations.R#L133_L136) | conversations | conversations and replies fail gracefully: thread channel            | PASS   | 1 | 0.001 |

</details>

<details>

<summary> Session Info </summary>

| Field    | Value                               |
| :------- | :---------------------------------- |
| Version  | R version 3.6.1 (2019-07-05)        |
| Platform | x86\_64-apple-darwin15.6.0 (64-bit) |
| Running  | macOS Mojave 10.14.5                |
| Language | en\_US                              |
| Timezone | America/New\_York                   |

| Package  | Version |
| :------- | :------ |
| testthat | 2.2.1   |
| covr     | 3.3.0   |
| covrpage | 0.0.70  |

</details>

<!--- Final Status : pass --->
