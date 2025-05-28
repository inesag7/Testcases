*** Settings ***
Resource    Preconditions.resource
Library    TicketID    ENG-1234
Metadata    TestLevel    Component
Metadata    Status    Ready
Metadata    TestDescription    Air Conditioning Turn Off
Metadata    Author    Jane Doe
Metadata    LinkedRequirement    requirement_text

*** Variables ***
${ENGINE_STATE_SIGNAL}     EngineState
${ENGINE_STOPPED}        0
${AIRCONDITION_STATE_SIGNAL}     AirConditionState
${AIRCONDITION_OFF}     0

*** ENG-1234_AirConditioning_Off_When_Engine_Stopped
[Documentation]    The air conditioning shall turn off if the engine is stopped
[Tags]    AirConditioning}    EngineState
[Setup]    Testcase SetUp
[Teardown]    Testcase TearDown

    Set Signal By Name    ${ENGINE_STATE_SIGNAL}    ${ENGINE_STOPPED}
    Wait Signal Change    ${AIRCONDITION_STATE_SIGNAL}    2 seconds
    Check Signal By Name    ${AIRCONDITION_STATE_SIGNAL}    ${AIRCONDITION_OFF}

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

Monitor Signal
    [Documentation]    Monitors a signal for specified duration (seconds)
    [Arguments]    ${SignalName}    ${MonitorTime}
    [Timeout]    ${MonitorTime + 10}    # Add buffer to timeout
    Monitor Signal    ${SignalName}    ${MonitorTime}

Get Signal By Name
    [Documentation]    Retrieves current value of the specified signal
    [Arguments]    ${SignalName}
    ${value} =    get_signal_by_name    ${SignalName}
    RETURN    ${value}