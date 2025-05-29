*** Settings ***
Resource    Preconditions.resource
Library    DateTime
Metadata
TicketID        AUTO-123
TestLevel    Integration
Status        Ready
TestDescription    Airbag Disable based on CP Speed and Duration
Author        test_automation
*** Variables ***
${CP_SPEED}        CP Speed
${CP_SPEED_VALUE}    0
${DURATION}        Duration
${DURATION_VALUE}    5m
${AIRBAG_DISABLE}    Airbag_Disable
${AIRBAG_DISABLE_VALUE}    1
${ TIMEOUT }    10
*** Test Cases ***
AIRBAG_DISABLE_CP_SPEED_0
    [Setup]    Testcase SetUp
    Set Signal By Name    ${CP_SPEED}    ${CP_SPEED_VALUE}
    Set Signal By Name    ${DURATION}    ${DURATION_VALUE}
    Wait Signal Change    ${AIRBAG_DISABLE}    ${TIMEOUT}
    Check Signal By Name    ${AIRBAG_DISABLE}    ${AIRBAG_DISABLE_VALUE}
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