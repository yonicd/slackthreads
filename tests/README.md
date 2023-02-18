Tests and Coverage
================
18 February, 2023 08:22:15

- <a href="#coverage" id="toc-coverage">Coverage</a>
- <a href="#unit-tests" id="toc-unit-tests">Unit Tests</a>

This output is created by
[covrpage](https://github.com/yonicd/covrpage).

## Coverage

Coverage summary is created using the
[covr](https://github.com/r-lib/covr) package.

| Object                                    | Coverage (%) |
|:------------------------------------------|:------------:|
| slackthreads                              |     100      |
| [R/api.R](../R/api.R)                     |     100      |
| [R/conversations.R](../R/conversations.R) |     100      |

<br>

## Unit Tests

Unit Test summary is created using the
[testthat](https://github.com/r-lib/testthat) package.

| file                                                  |   n | time | error | failed | skipped | warning |
|:------------------------------------------------------|----:|-----:|------:|-------:|--------:|--------:|
| [test-conversations.R](testthat/test-conversations.R) |  16 | 1.24 |     0 |      0 |       0 |       0 |

<details closed>
<summary>
Show Detailed Test Results
</summary>

| file                                                            | context       | test                                                  | status |   n | time |
|:----------------------------------------------------------------|:--------------|:------------------------------------------------------|:-------|----:|-----:|
| [test-conversations.R](testthat/test-conversations.R#L60_L67)   | conversations | Can get conversations                                 | PASS   |   5 | 0.24 |
| [test-conversations.R](testthat/test-conversations.R#L87_L92)   | conversations | Can get replies                                       | PASS   |   3 | 0.36 |
| [test-conversations.R](testthat/test-conversations.R#L113_L118) | conversations | Can get all replies at once to a set of conversations | PASS   |   4 | 0.47 |
| [test-conversations.R](testthat/test-conversations.R#L126_L133) | conversations | Conversations and replies fail gracefully             | PASS   |   4 | 0.17 |

</details>
<details>
<summary>
Session Info
</summary>

| Field    | Value                             |
|:---------|:----------------------------------|
| Version  | R version 4.2.2 (2022-10-31 ucrt) |
| Platform | x86_64-w64-mingw32/x64 (64-bit)   |
| Running  | Windows 10 x64 (build 22621)      |
| Language | English_United States             |
| Timezone | America/Chicago                   |

| Package  | Version |
|:---------|:--------|
| testthat | 3.1.6   |
| covr     | 3.6.1   |
| covrpage | 0.2     |

</details>
<!--- Final Status : pass --->
