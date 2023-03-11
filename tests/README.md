Tests and Coverage
================
11 March, 2023 14:44:53

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
| [test-conversations.R](testthat/test-conversations.R) | 19 | 0.912 |     0 |      0 |       0 |       0 |

<details closed>

<summary> Show Detailed Test Results </summary>

| file                                                            | context       | test                                                  | status | n |  time |
| :-------------------------------------------------------------- | :------------ | :---------------------------------------------------- | :----- | -: | ----: |
| [test-conversations.R](testthat/test-conversations.R#L60_L67)   | conversations | Can get conversations                                 | PASS   | 5 | 0.356 |
| [test-conversations.R](testthat/test-conversations.R#L87_L92)   | conversations | Can get replies                                       | PASS   | 3 | 0.193 |
| [test-conversations.R](testthat/test-conversations.R#L113_L118) | conversations | Can get all replies at once to a set of conversations | PASS   | 7 | 0.279 |
| [test-conversations.R](testthat/test-conversations.R#L141_L148) | conversations | Conversations and replies fail gracefully             | PASS   | 4 | 0.084 |

</details>

<details>

<summary> Session Info </summary>

| Field    | Value                         |                                                                                                                                                                                                                                                                      |
| :------- | :---------------------------- | :------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Version  | R version 4.2.2 (2022-10-31)  |                                                                                                                                                                                                                                                                      |
| Platform | x86\_64-pc-linux-gnu (64-bit) | <a href="https://github.com/yonicd/slackthreads/commit/953d0ef2616d8ac5391a7fff51e60dfa067c3f3d/checks" target="_blank"><span title="Built on Github Actions">![](https://github.com/metrumresearchgroup/covrpage/blob/actions/inst/logo/gh.png?raw=true)</span></a> |
| Running  | Ubuntu 22.04.2 LTS            |                                                                                                                                                                                                                                                                      |
| Language | C                             |                                                                                                                                                                                                                                                                      |
| Timezone | UTC                           |                                                                                                                                                                                                                                                                      |

| Package  | Version |
| :------- | :------ |
| testthat | 3.1.6   |
| covr     | 3.6.1   |
| covrpage | 0.2     |

</details>

<!--- Final Status : pass --->
