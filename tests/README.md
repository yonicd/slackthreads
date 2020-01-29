Tests and Coverage
================
29 January, 2020 03:20:58

  - [Coverage](#coverage)
  - [Unit Tests](#unit-tests)

This output is created by
[covrpage](https://github.com/metrumresearchgroup/covrpage).

## Coverage

Coverage summary is created using the
[covr](https://github.com/r-lib/covr) package.

| Object                                    | Coverage (%) |
| :---------------------------------------- | :----------: |
| threads                                   |     100      |
| [R/conversations.R](../R/conversations.R) |     100      |
| [R/utils.R](../R/utils.R)                 |     100      |

<br>

## Unit Tests

Unit Test summary is created using the
[testthat](https://github.com/r-lib/testthat) package.

| file                                                  |  n |  time | error | failed | skipped | warning |
| :---------------------------------------------------- | -: | ----: | ----: | -----: | ------: | ------: |
| [test-conversations.R](testthat/test-conversations.R) | 17 | 0.142 |     0 |      0 |       0 |       0 |

<details closed>

<summary> Show Detailed Test Results </summary>

| file                                                            | context       | test                                                                 | status | n |  time |
| :-------------------------------------------------------------- | :------------ | :------------------------------------------------------------------- | :----- | -: | ----: |
| [test-conversations.R](testthat/test-conversations.R#L26_L29)   | conversations | confirm that our expected channel name still exists: valid channel   | PASS   | 1 | 0.030 |
| [test-conversations.R](testthat/test-conversations.R#L33_L36)   | conversations | confirm that our expected channel name still exists: invalid channel | PASS   | 1 | 0.017 |
| [test-conversations.R](testthat/test-conversations.R#L46)       | conversations | can get conversations: class                                         | PASS   | 1 | 0.001 |
| [test-conversations.R](testthat/test-conversations.R#L50)       | conversations | can get conversations: length                                        | PASS   | 1 | 0.000 |
| [test-conversations.R](testthat/test-conversations.R#L54_L57)   | conversations | can get conversations: attr channel                                  | PASS   | 1 | 0.001 |
| [test-conversations.R](testthat/test-conversations.R#L61_L64)   | conversations | can get conversations: element names                                 | PASS   | 1 | 0.002 |
| [test-conversations.R](testthat/test-conversations.R#L68_L71)   | conversations | can get conversations: result class                                  | PASS   | 1 | 0.001 |
| [test-conversations.R](testthat/test-conversations.R#L75_L78)   | conversations | can get conversations: element channel                               | PASS   | 1 | 0.001 |
| [test-conversations.R](testthat/test-conversations.R#L85_L86)   | conversations | can get replies to a conversation: object class                      | PASS   | 1 | 0.000 |
| [test-conversations.R](testthat/test-conversations.R#L90)       | conversations | can get replies to a conversation: object length                     | PASS   | 1 | 0.001 |
| [test-conversations.R](testthat/test-conversations.R#L94_L97)   | conversations | can get replies to a conversation: object channel                    | PASS   | 1 | 0.001 |
| [test-conversations.R](testthat/test-conversations.R#L101_L104) | conversations | can get replies to a conversation: element names                     | PASS   | 1 | 0.084 |
| [test-conversations.R](testthat/test-conversations.R#L108_L111) | conversations | can get replies to a conversation: element class                     | PASS   | 1 | 0.000 |
| [test-conversations.R](testthat/test-conversations.R#L115_L118) | conversations | can get replies to a conversation: element channel                   | PASS   | 1 | 0.001 |
| [test-conversations.R](testthat/test-conversations.R#L125)      | conversations | conversations and replies fail gracefully: thread length             | PASS   | 1 | 0.000 |
| [test-conversations.R](testthat/test-conversations.R#L129)      | conversations | conversations and replies fail gracefully: thread class              | PASS   | 1 | 0.001 |
| [test-conversations.R](testthat/test-conversations.R#L133_L136) | conversations | conversations and replies fail gracefully: thread channel            | PASS   | 1 | 0.001 |

</details>

<details>

<summary> Session Info </summary>

| Field    | Value                               |                                                                                                                                                                                                                                                                 |
| :------- | :---------------------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Version  | R version 3.6.2 (2019-12-12)        |                                                                                                                                                                                                                                                                 |
| Platform | x86\_64-apple-darwin15.6.0 (64-bit) | <a href="https://github.com/yonicd/threads/commit/0797914a2fc02242aea36a6fcb305f0eea254b57/checks" target="_blank"><span title="Built on Github Actions">![](https://github.com/metrumresearchgroup/covrpage/blob/actions/inst/logo/gh.png?raw=true)</span></a> |
| Running  | macOS Catalina 10.15.2              |                                                                                                                                                                                                                                                                 |
| Language | en\_US                              |                                                                                                                                                                                                                                                                 |
| Timezone | UTC                                 |                                                                                                                                                                                                                                                                 |

| Package  | Version |
| :------- | :------ |
| testthat | 2.3.1   |
| covr     | 3.3.2   |
| covrpage | 0.0.71  |

</details>

<!--- Final Status : pass --->
