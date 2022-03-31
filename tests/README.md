Tests and Coverage
================
13 August, 2020 20:21:40

  - [Coverage](#coverage)
  - [Unit Tests](#unit-tests)

This output is created by
[covrpage](https://github.com/yonicd/covrpage).

## Coverage

Coverage summary is created using the
[covr](https://github.com/r-lib/covr) package.

| Object                                    | Coverage (%) |
| :---------------------------------------- | :----------: |
| slackthreads                              |     100      |
| [R/api.R](../R/api.R)                     |     100      |
| [R/conversations.R](../R/conversations.R) |     100      |

<br>

## Unit Tests

Unit Test summary is created using the
[testthat](https://github.com/r-lib/testthat) package.

| file                                                  |  n |  time | error | failed | skipped | warning |
| :---------------------------------------------------- | -: | ----: | ----: | -----: | ------: | ------: |
| [test-conversations.R](testthat/test-conversations.R) | 11 | 0.049 |     0 |      0 |       0 |       0 |

<details closed>

<summary> Show Detailed Test Results </summary>

| file                                                          | context       | test                                                                 | status | n |  time |
| :------------------------------------------------------------ | :------------ | :------------------------------------------------------------------- | :----- | -: | ----: |
| [test-conversations.R](testthat/test-conversations.R#L20_L23) | conversations | confirm that our expected channel name still exists: valid channel   | PASS   | 1 | 0.030 |
| [test-conversations.R](testthat/test-conversations.R#L27_L30) | conversations | confirm that our expected channel name still exists: invalid channel | PASS   | 1 | 0.011 |
| [test-conversations.R](testthat/test-conversations.R#L40)     | conversations | can get conversations: class                                         | PASS   | 1 | 0.001 |
| [test-conversations.R](testthat/test-conversations.R#L44)     | conversations | can get conversations: length                                        | PASS   | 1 | 0.001 |
| [test-conversations.R](testthat/test-conversations.R#L48_L51) | conversations | can get conversations: result class                                  | PASS   | 1 | 0.001 |
| [test-conversations.R](testthat/test-conversations.R#L55_L58) | conversations | can get conversations: element channel                               | PASS   | 1 | 0.002 |
| [test-conversations.R](testthat/test-conversations.R#L65_L66) | conversations | can get replies to a conversation: object class                      | PASS   | 1 | 0.000 |
| [test-conversations.R](testthat/test-conversations.R#L70_L73) | conversations | can get replies to a conversation: object channel                    | PASS   | 1 | 0.001 |
| [test-conversations.R](testthat/test-conversations.R#L79)     | conversations | conversations and replies fail gracefully: thread length             | PASS   | 1 | 0.000 |
| [test-conversations.R](testthat/test-conversations.R#L83)     | conversations | conversations and replies fail gracefully: thread class              | PASS   | 1 | 0.001 |
| [test-conversations.R](testthat/test-conversations.R#L87_L90) | conversations | conversations and replies fail gracefully: thread channel            | PASS   | 1 | 0.001 |

</details>

<details>

<summary> Session Info </summary>

| Field    | Value                             |
| :------- | :-------------------------------- |
| Version  | R version 4.0.2 (2020-06-22)      |
| Platform | x86\_64-apple-darwin17.0 (64-bit) |
| Running  | macOS Catalina 10.15.6            |
| Language | en\_US                            |
| Timezone | America/New\_York                 |

| Package  | Version |
| :------- | :------ |
| testthat | 2.3.2   |
| covr     | 3.5.0   |
| covrpage | 0.0.70  |

</details>

<!--- Final Status : pass --->
