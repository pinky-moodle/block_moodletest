@block @block_moodletest
Feature: Block moodle test
  In order to list course modules along with course module id and created date
  As a manager
  I can add moodle test block in a course

Background:
    Given the following "users" exist:
      | username | firstname | lastname | email | idnumber |
      | teacher1 | Teacher | 1 | teacher1@example.com | T1 |
      | student1 | Student | 1 | student1@example.com | S1 |
    And the following "courses" exist:
      | fullname | shortname | category |
      | Course 1 | C1 | 0 |
    And the following "course enrolments" exist:
      | user | course | role |
      | teacher1 | C1 | editingteacher |
      | student1 | C1 | student |
    And the following "activities" exist:
      | activity   | name                   | intro                         | course | idnumber    |
      | assign     | Test assignment name   | Test assignment description   | C1     | assign1     |
      | book       | Test book name         | Test book description         | C1     | book1       |
      | chat       | Test chat name         | Test chat description         | C1     | chat1       |
      | choice     | Test choice name       | Test choice description       | C1     | choice1     |
      | data       | Test database name     | Test database description     | C1     | data1       |
      | folder     | Test folder name       | Test folder description       | C1     | folder1     |
      | forum      | Test forum name        | Test forum description        | C1     | forum1      |
      | lesson     | Test lesson name       | Test lesson description       | C1     | lesson1     |
      | lti        | Test lti name          | Test lti description          | C1     | lti1        |
      | page       | Test page name         | Test page description         | C1     | page1       |
      | quiz       | Test quiz name         | Test quiz description         | C1     | quiz1       |
      | scorm      | Test scorm name        | Test scorm description        | C1     | scorm1      |
      | url        | Test url name          | Test url description          | C1     | url1        |
      | workshop   | Test workshop name     | Test workshop description     | C1     | workshop1   |

  Scenario: Add Moodle test block in a course
    Given I log in as "admin"
    And I am on "Course 1" course homepage with editing mode on
    And I add the "Moodle test block" block
    And I click on "Test assignment name" "link" in the "Moodle test block" "block"
    Then I should see "Test assignment name"
    And I should see "Grading summary"
    And I am on "Course 1" course homepage
    And I click on "Test chat name" "link" in the "Moodle test block" "block"
    And I should see "Test chat description"
    And I should see "Click here to enter the chat now"
    And I am on "Course 1" course homepage
    And I click on "Test choice name" "link" in the "Moodle test block" "block"
    And I should see "Test choice description"
    And I am on "Course 1" course homepage
    And I click on "Test database name" "link" in the "Moodle test block" "block"
    And I should see "Test database description"
    And I am on "Course 1" course homepage
    And I click on "Test forum name" "link" in the "Moodle test block" "block"
    And I should see "Test forum name"
    And I should see "Add a new discussion topic"
    And I am on "Course 1" course homepage
    And I click on "Test lti name" "link" in the "Moodle test block" "block"
    And I should see "Test lti name"
    And I am on "Course 1" course homepage
    And I click on "Test quiz name" "link" in the "Moodle test block" "block"
    And I should see "Test quiz description"
    And I should see "Edit quiz"
    And I am on "Course 1" course homepage
    And I click on "Test scorm name" "link" in the "Moodle test block" "block"
    And I should see "Test scorm name"
    And I am on "Course 1" course homepage
    And I click on "Test lesson name" "link" in the "Moodle test block" "block"
    And I should see "Test lesson name"
    And I am on "Course 1" course homepage
    And I click on "Test workshop name" "link" in the "Moodle test block" "block"
    And I should see "Test workshop name"
    And I log out

    When I log in as "teacher1"
    And I am on "Course 1" course homepage with editing mode on
    And I add the "Moodle test block" block
    And I click on "Test assignment name" "link" in the "Moodle test block" "block"
    Then I should see "Test assignment name"
    And I should see "Grading summary"
    And I log out

  Scenario: View Moodle test block as student
    Given the following "blocks" exist:
      | blockname      | contextlevel | reference |
      | moodletest        | Course       | C1   |
    And I log in as "student1"
    And I am on "Course 1" course homepage
    Then I should see "Moodle test block"
    And I click on "Test assignment name" "link" in the "Moodle test block" "block"
    Then I should see "Test assignment description"
    And I should see "Submission status"
    And I am on "Course 1" course homepage
    And I click on "Test forum name" "link" in the "Moodle test block" "block"
    And I should see "Test forum description"
    And I should see "Add a new discussion topic"
    And I log out

  Scenario: Moodle test block can not be added to other than course page
    When I log in as "admin"
    And I press "Customise this page"
    Then the add block selector should not contain "Moodle test block" block
    And I log out
    Then I log in as "teacher1"
    And I press "Customise this page"
    Then the add block selector should not contain "Moodle test block" block
    And I log out

