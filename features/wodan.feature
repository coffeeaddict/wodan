Feature: Process monitoring
  In order to keep track of my processes
  As an administrator
  I want a monitoring tool

  Scenario: Running 'system' daemon
    Given a running daemon: foo
    When I start a task for: foo
    Then 'foo' should still be running
    And wodan should say 'foo' is 'OK'
