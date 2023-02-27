Tests and Coverage
================
27 February, 2023 20:28:13

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
| [test-conversations.R](testthat/test-conversations.R) | 19 | 0.796 |     0 |      0 |       0 |       0 |

<details closed>

<summary> Show Detailed Test Results </summary>

| file                                                            | context       | test                                                  | status | n |  time |
| :-------------------------------------------------------------- | :------------ | :---------------------------------------------------- | :----- | -: | ----: |
| [test-conversations.R](testthat/test-conversations.R#L60_L67)   | conversations | Can get conversations                                 | PASS   | 5 | 0.290 |
| [test-conversations.R](testthat/test-conversations.R#L87_L92)   | conversations | Can get replies                                       | PASS   | 3 | 0.218 |
| [test-conversations.R](testthat/test-conversations.R#L113_L118) | conversations | Can get all replies at once to a set of conversations | PASS   | 7 | 0.222 |
| [test-conversations.R](testthat/test-conversations.R#L141_L148) | conversations | Conversations and replies fail gracefully             | PASS   | 4 | 0.066 |

</details>

<details>

<summary> Session Info </summary>

| Field    | Value                         |                                                                                                                                                                                                                                                                      |
| :------- | :---------------------------- | :------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Version  | R version 4.2.2 (2022-10-31)  |                                                                                                                                                                                                                                                                      |
| Platform | x86\_64-pc-linux-gnu (64-bit) | <a href="https://github.com/yonicd/slackthreads/commit/0e0a717dfb45b2082458e49ee64d54e3d501a3f8/checks" target="_blank"><span title="Built on Github Actions">![](https://github.com/metrumresearchgroup/covrpage/blob/actions/inst/logo/gh.png?raw=true)</span></a> |
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
