@errors
Feature: Error testing

    @failing
    #should be 400 instead of 500
    Scenario: Empty room size
        Given I start at coords 1 2
        And The patches are at
            | 1 | 0 |
            | 2 | 2 |
            | 2 | 3 |
        And my instruction set is NNESEESWNWW
        When I submit to the endpoint
        Then The response has status code 400

    Scenario: No starting possition
        Given I have a room of size 5 5
        And The patches are at
            | 1 | 0 |
            | 2 | 2 |
            | 2 | 3 |
        And my instruction set is NNESEESWNWW
        When I submit to the endpoint
        Then The response has status code 400

    Scenario: No Patches
        Given I have a room of size 5 5
        And I start at coords 1 2
        And my instruction set is NNESEESWNWW
        When I submit to the endpoint
        Then The response has status code 400

    Scenario: No instruction set
        Given I have a room of size 5 5
        And I start at coords 1 2
        And The patches are at
            | 1 | 0 |
            | 2 | 2 |
            | 2 | 3 |
        When I submit to the endpoint
        Then The response has status code 400

    @failing
    #Shouldn't allow for negative starting possition
    Scenario Outline: Invalid starting coordinates <starting_x>, <starting_y>
        Given I have a room of size 5 5
        And I start at coords <starting_x> <starting_y>
        And The patches are at
            | 1 | 0 |
            | 2 | 2 |
            | 2 | 3 |
        And my instruction set is NNESEESWNWW
        When I submit to the endpoint
        Then The response has status code 400

        Examples:
            | starting_x | starting_y |
            | -1         | 1          |
            | Q          | 1          |
            | 1          | -1         |
            | 1          | Q          |
            | 1.1        | 1.1        |

    @failing
    #Shouldn't allow for negative room size
    Scenario Outline: Invalid room size <room_x> <room_y>
        Given I have a room of size <room_x> <room_y>
        And I start at coords 1 2
        And The patches are at
            | 1 | 0 |
            | 2 | 2 |
            | 2 | 3 |
        And my instruction set is NNESEESWNWW
        When I submit to the endpoint
        Then The response has status code 400

        Examples:
            | room_x | room_y |
            | -5     | 5      |
            | 5      | -5     |
            | A      | 5      |
            | 5      | A      |
            | 1.1    | 1.1    |

    @failing
    #Shouldn't allow for invalid patch possitions
    Scenario Outline: Invalid patch possition <patch_x> <patch_y>
        Given I have a room of size 5 5
        And I start at coords 1 2
        And The patches are at
            | <patch_x> | <patch_y> |
        And my instruction set is NNESEESWNWW
        When I submit to the endpoint
        Then The response has status code 200

        Examples:
            | patch_x | patch_y |
            | -1      | 1       |
            | 1       | -1      |
            | A       | 1       |
            | 1       | A       |
            | 1       | 1.1     |
            | 1.1     | 1       |

    @failing
    #Shouldn't allow for patches out of bounds of the room
    Scenario Outline: Patch out of bounds <patch_x> <patch_y>
        Given I have a room of size 5 5
        And I start at coords 1 2
        And The patches are at
            | <patch_x> | <patch_y> |
        And my instruction set is NNESEESWNWW
        When I submit to the endpoint
        Then The response has status code 400

        Examples:
            | patch_x | patch_y |
            | 6       | 1       |
            | 1       | 6       |
            | 6       | 6       |

    Scenario Outline: Invalid instruction set <instruction_set>
        Given I have a room of size 5 5
        And I start at coords 3 3
        And The patches are at
            | 1 | 0 |
            | 2 | 2 |
            | 2 | 3 |
        And my instruction set is <instruction_set>
        When I submit to the endpoint
        Then The response has status code 400

        Examples:
            | instruction_set |
            | NSWA            |
            | NSW1            |