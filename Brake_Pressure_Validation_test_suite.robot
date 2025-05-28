*** Settings ***
Resource    Preconditions.resource
Library    DateTime
Metadata
    TicketID    Brake_Pressure_Validation
    TestLevel    Unit
    Status    Ready
    TestDescription    Validate Brake_Pressure signal against a redundant sensor.
    Author    Automated Test Engineer
    LinkedRequirement    requirement_text:Validate Brake_Pressure signal against a redundant sensor.

*** Variables ***
${BRAKE_PRESSURE_SIGNAL}    Brake_Pressure
${REUNDANT_SENSOR_SIGNAL}    Redundant_Sensor_Signal
${EXPECTED_SIGNAL_VALUE}    1.0
${MONITOR_TIME}    5
${TIMEOUT}    10

*** Test Cases ***
Brake_Pressure_Signal_Validation
    [Tags]    Brake_Pressure_Signal    Redundant_Sensor
    [Setup]    Testcase SetUp
    Set Signal By Name    ${BRAKE_PRESSURE_SIGNAL    ${EXPECTED_SIGNAL_VALUE}
    Monitor Signal    ${REUNDANT_SENSOR_SIGNAL}    ${MONITOR_TIME}
    Check Signal By Name    ${REUNDANT_SENSOR_SIGNAL}    ${EXPECTED_SIGNAL_VALUE}
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