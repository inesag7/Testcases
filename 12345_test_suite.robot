*** Settings ***
Resource    Preconditions.resource
Library    DateTime
Metadata
    TicketID           12345
    TestLevel       Integration
    Status           Ready
    TestDescription     Verify Child Safety Alarm functionality
    Author           YourName
    LinkedRequirement    Child Safety Alarm requirement

*** Variables ***
${CHILD_SAFETY_ALARM_CODING}     1
${CHILD_SAFETY_ALARM_SIGNAL}     ChildSafetyAlarm
${CHILD_SAFETY_ALARM_ENABLED}     True
${CHILD_SAFETY_ALARM_CODING_SETUP_TIMEOUT}     5

*** Test Cases ***
Req_Child_Safety_Alarm_Coding_Enable
    [Tags]    Critical    Safety
    [Setup]    Testcase SetUp
    [Teardown]    Testcase TearDown
    # Set up Child Safety Alarm coding
    Set Signal By Name    ${CHILD_SAFETY_ALARM_CODING}    ${CHILD_SAFETY_ALARM_CODING}
    # Wait for setup timeout
    Wait Until Signal Settle    ${CHILD_SAFETY_ALARM_SIGNAL}    ${CHILD_SAFETY_ALARM_ENABLED}    ${SETUP_SAFETY_ALARM_CODING_TIMEOUT}
    # Verify Child Safety Alarm is enabled
    Check Signal By Name    ${CHILD_SAFETY_ALARM_SIGNAL}    ${CHILD_SAFETY_ALARM_ENABLED}

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