*** Settings ***
Resource    resource.robot
Library    DateTime
Metadata
    TicketID    123
    TestLevel    Acceptance
    Ready
    TestDescription    Test Airbag Disable based on CP Speed and Duration
    Author    Robot Framework User
    LinkedRequirement    requirement_text:"Input: CP Speed = 0 AND Duration > 5m Output: Airbag_Disable = 1."

*** Variables ***
${CP_SPEED_SIGNAL}    CP Speed
${CP_SPEED_ZERO}    0
${DURATION_SIGNAL}    Duration
${DURATION_THRESHOLD}    5m
${AIRBAG_DISABLE_SIGNAL}    Airbag_Disable
${AIRBAG_DISABLE_STATE}    1
${MONITOR_TIME}    10

*** Test Cases ***
requirement_123_Airbag Disable
    [Tags]    Airbag Disable
    [Setup]    Testcase SetUp
    Set Signal By Name    ${CP_SPEED_SIGNAL}    ${CP_SPEED_ZERO}
    Wait Signal Change    ${DURATION_SIGNAL}    ${DURATION_THRESHOLD}
    Check Signal By Name    ${AIRBAG_DISABLE_SIGNAL    ${AIRBAG_DISABLE_STATE}
    [Teardown]    Testcase TearDown

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

Monitor Signal
    [Documentation]    Monitors a signal for specified duration (seconds)
    [Arguments]    ${SignalName}    ${MonitorTime}
    [Timeout]    ${MonitorTime + 10}    # Add buffer to timeout
    Monitor Signal    ${SignalName}    ${MonitorTime}

Wait Signal Change
    [Documentation]    Waits for signal to change within timeout (seconds)
    [Arguments]    ${SignalName}    ${Timeout}
    Wait Signal Change    ${SignalName}    ${Timeout}

Get Signal By Name
    [Documentation]    Retrieves current value of the specified signal
    [Arguments]    ${SignalName}
    ${value} =    get_signal_by_name    ${SignalName}
    RETURN      ${value}