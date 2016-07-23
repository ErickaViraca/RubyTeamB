@api_test
  Feature: Project for API Testing Class (workspace)

    @smoke
    Scenario: Get workspace
      Given I have set a connection to pivotal_tracker API service
      When I send a workspace GET request to
      Then I expect Status code 200

    @smoke
    Scenario: Post workspace
      Given I have set a connection to pivotal_tracker API service
      When I send a workspace POST with the json
      """
      {
        "name":"workspaceTestXYZ"
      }
      """
      Then I expect Status code 200

    @smoke @create_project @delete_project
    Scenario: PUT workspace
      Given I have set a connection to pivotal_tracker API service
      When I send a workspace PUT request to add project
      Then I expect Status code 200

    @smoke
    Scenario: DELETE workspace
      Given I have set a connection to pivotal_tracker API service
      When I send a workspace DELETE request to delete WorkspaceRequest
      Then I expect Status code 204

    @acceptance
    Scenario Outline: Verify than the created workspace was created with the same values inserted.
      Given I have set a connection to pivotal_tracker API service
      When I send a workspace POST request with the json
      """
      {
        "name":"<Name>"
      }
      """
      Then I expect Status code 200
      And I expect the all inserted data workspace are the same
      Examples:
        | Name |
        | workspace-E1 |
        | workspace-E2 |
        | workspace-E3 |

    @acceptance
    Scenario Outline: Verify Kind Workspace
      Given I have set a connection to pivotal_tracker API service
      When I send a workspace POST request with the json
      """
      {
        "name":"<Name>"
      }
      """
      Then I expect Status code 200
      And I expect the kind of workspace is equal to workspace
      Examples:
        | Name |
        | workspace-Kind-E1 |

    @acceptance
    Scenario: Verify the all data type that return the get request to workspace are correct
      Given I have set a connection to pivotal_tracker API service
      When I send a workspace GET request to
      Then I expect Status code 200
      And I expect the all data type returned from workspace request are correct

    @negative
    Scenario: Verify that a workspace cannot be obtained for a non-existent workspace
      Given I have set a connection to pivotal_tracker API service
      When I send a workspace GET request for a workspace 000
      Then I expect Status code 404
      And I expect an error message from workspace

    @negative
    Scenario: Verify that is not possible to add a Workspace with empty value
      Given I have set a connection to pivotal_tracker API service
      When I send a workspace negative POST with the json
    """
      {
        "name":""
      }
    """
      Then I expect Status code 400
      And I expect the workspace error message One or more request parameters was missing or invalid.
      And I expect the workspace error code invalid_parameter
      And I expect the workspace error kind error
      And I expect the workspace error general problem Name can't be blank

    @negative
    Scenario: Verify that is not possible to add a workspace with an attribute different to name and innexistent
      Given I have set a connection to pivotal_tracker API service
      When I send a workspace negative POST with the json
    """
      {
        "namesss":"/*000*/"
      }
    """
      Then I expect Status code 400
      And I expect the workspace error message One or more request parameters was missing or invalid.
      And I expect the workspace error code invalid_parameter
      And I expect the workspace error kind error
      And I expect the workspace error general problem this endpoint requires at least one of the following parameters: name, project_ids


    @negative
    Scenario: Verify that is not possible to edit a workspace sending *0 as id workspace
      Given I have set a connection to pivotal_tracker API service
      When I send a workspace negative PUT with 0 workspace id and with the json
    """
      {
        "name":"Workspace Updated-Negative"
      }
    """
      Then I expect Status code 400
      And I expect the workspace error code invalid_parameter
      And I expect the workspace error kind error
      And I expect the workspace error message One or more request parameters was missing or invalid.

    @negative
    Scenario: Verify that is not possible to delete a non-existing workspace
      Given I have set a connection to pivotal_tracker API service
      When I send a workspace DELETE request with the wrong workspace id /*00*/
      Then I expect Status code 404
      And I expect the workspace error code unfound_resource
      And I expect the workspace error kind error

    @negative
    Scenario: Verify that is not possible to edit a workspace sending an non-existing workspace id
      Given I have set a connection to pivotal_tracker API service
      When I send a workspace negative PUT with */0 workspace id and with the json
    """
      {
        "name":"Workspace Updated-Negative"
      }
    """
      Then I expect Status code 404
      And I expect the workspace error code route_not_found
      And I expect the workspace error kind error
      And I expect the workspace error message The path you requested has no valid endpoint.