*** Settings ***
Library           DateTime
Resource          Preconditions.resource
Metadata
TicketID         AC-001
TestLevel         Integration
Status           Ready
TestDescription   Air Conditioning Turn Off with Engine Stopped
Author           [Your Name]
LinkedRequirement   requirement_text

*** Variables ***
${ENGINE_STATE_SIGNAL}       EngineState
${ENGINE_STOPPED}           0
${AC_STATE_SIGNAL}          AirConditioningState
${AC_OFF_STATE}            0
${DELAY_AFTER_STOP}        2  # seconds

*** Test Cases ***
AC_001_EngineStopped_AirCondOff
    [Tags]  Air Conditioning  Engine State
    [Setup]    Testcase SetUp
    [Teardown]   Testcase TearDown

    # Initialize system
    Set Signal By Name  ${ENGINE_STATE_SIGNAL}  ${ENGINE_RUNNING}  # assume engine running initially

    # Stop the engine
    Set Signal By Name  ${ENGINE_STATE_SIGNAL}  ${ENGINE_STOPPED}
    Wait Signal Change  ${ENGINE_STATE_SIGNAL}  ${DELAY_AFTER_STOP}

    # Verify AC turns off
    Check Signal By Name  ${AC_STATE_SIGNAL}  ${AC_OFF_STATE}

*** Keywords ***
Testcase SetUp
    [Documentation]    Setup steps to run before each test case
    Testcase Setup

Testcase TearDown
    [Documentation]    Teardown steps to run after each test case
    Testcase Teardown

Set Signal By Name
    [Documentation]    Sets the specified signal to given value
    [Arguments]    ${SignalName}    ${Value}
    Set Signal By Name    ${SignalName}    ${Value}

Check Signal By Name
    [Documentation]    Verifies signal matches expected value
    [Arguments]    ${SignalName}    ${ExpectedValue}
    Check Signal By Name    ${SignalName}    ${ExpectedValue}

Wait Signal Change
    [Documentation]    Waits for signal to change within timeout (seconds)
    [Arguments]    ${SignalName}    ${Timeout}
    Wait Signal Change    ${SignalName}    ${Timeout}