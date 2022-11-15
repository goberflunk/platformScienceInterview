@main
Feature: Main testing

    Scenario: Given test
        Given I have a room of size 5 5
        And I start at coords 1 2
        And The patches are at
            | 1 | 0 |
            | 2 | 2 |
            | 2 | 3 |
        And my instruction set is NNESEESWNWW
        When I submit to the endpoint
        Then The response has status code 200
        And The response contains coords 1 3
        And The response contains 1 patches

    @failing
    #If I start on a patch, that patch should be cleaned
    Scenario: Start on patch
        Given I have a room of size 5 5
        And I start at coords 1 1
        And The patches are at
            | 1 | 1 |
        And my instruction set is N
        When I submit to the endpoint
        Then The response has status code 200
        And The response contains coords 1 2
        And The response contains 1 patches

    @failing
    #If two patches are on the same spot, should they both be cleaned?
    Scenario: Two patches in same spot
        Given I have a room of size 5 5
        And I start at coords 2 2
        And The patches are at
            | 1 | 1 |
            | 1 | 1 |
        And my instruction set is SW
        When I submit to the endpoint
        Then The response has status code 200
        And The response contains coords 1 1
        And The response contains 2 patches

    Scenario Outline: Blocked by a wall
        Given I have a room of size 5 5
        And I start at coords <startx> <starty>
        And The patches are at
            | 1 | 1 |
        And my instruction set is <instruction>
        When I submit to the endpoint
        Then The response has status code 200
        And The response contains coords <endx> <endy>
        And The response contains 0 patches

        Examples:
            | startx | starty | instruction | endx | endy |
            | 4      | 4      | N           | 4    | 4    |
            | 4      | 4      | E           | 4    | 4    |
            | 0      | 0      | S           | 0    | 0    |
            | 0      | 0      | W           | 0    | 0    |

    @failing
    Scenario: Patches cleared between runs
        Given I have a room of size 5 5
        And I start at coords 4 4
        And The patches are at
            | 1 | 1 |
        And my instruction set is N
        When I submit to the endpoint
        Then The response has status code 200
        When I have a room of size 5 5
        And I start at coords 2 1
        And The patches are at
            | 1 | 0 |
        And my instruction set is W
        When I submit to the endpoint
        Then The response has status code 200
        And The response contains coords 1 1
        And The response contains 0 patches
