Feature: Collect test result data from LRM

  @labrun_test
  Scenario Outline: Collect unfinished and unresovled labruns.
    When the user visits LRM deeplink <url>
    Then all passed labruns should be filtered away
    Then all LRM include <statistic type> assignments should be collected

  Examples:
    |url                                                                             | statistic type  |
#   || Unfinished |
    || Unfinished      |

  @labrun_test
  Scenario Outline: Collect bugs referred in each labrun
    When the user visits LRM deeplink <url>
    Then all bugs referred in each labrun should be collected

    Examples:
    |url|
    ||
