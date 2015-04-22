Feature: Check the basic feature on Google
  In order to make sure Google basic feature is working well
  As a user on Google
  I want to check the basic feature on Google

  @dummytest
  Scenario Outline: Check the search feature on Google
    When the user visit Google web site
    Then the current page should be Google site
    Then the user input <SearchCode1> as search condition and perform search
    Then the page should display the search result for <SearchCode2>
   Examples:
    |SearchCode1|  SearchCode2|
    |Travel    | Travel      |
    |MH370     | MH370       |
    |@^&$%rb   | @^&$%rb     |

   Scenario Outline: Check the login Google+ feature on Google
    When the user visit Google web site
    Then the current page should be Google site
    Then the user clicks +You link
    Then the user input <valid email> and <password> to sign in
    Then the user should log in successfully
    Then the user clicks the profile icon
    Then the user clicks sign out link
    Then the user relogin with the old <valid email> and <password>
   Examples:
     |valid email|password|
     #As this account is my private account, please do change this account when you are testing
     |sunnyyueluan@gmail.com|sunyl111|


    Scenario Outline: Check the log in feature on Google
      When the user visit Google web site
      Then the current page should be Google site
      Then the user clicks sign in link
      Then the user input <valid email> and <password> to sign in
      Then the user should be on signed in page
      Then the user clicks the profile icon
      Then the user clicks sign out link
      Then close the browser

    Examples:
      |valid email|password|
      #As this account is my private account, please do change this account when you are testing
      |sunnyyueluan@gmail.com|111|

     Scenario: test my test
       When the yml file is loaded into the system

