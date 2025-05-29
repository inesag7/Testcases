*** Settings ***
Resource    Preconditions.resource
Library    DateTime
Metadata
TicketID    123
TestLevel    Ready
TestDescription    Validate Wheel Speed Signal
Author    [Your Name]
LinkedRequirement    requirement_text

*** Variables ***
${WHEEL_SPEED_SIGNAL}    WheelSpeed
${WHEEL_SPEED_VALID}    1
${REUNDANT_SENSOR_SIGNAL}    RedundantSensor
${REUNDANT_SENSOR_MATCH}    1
${MONITOR_TIME}    5

*** Test Cases ***
Validate Wheel Speed Against Redundant Sensor
    [Tags]    wheel_speed    redundant_sensor
    [Setup]    Testcase SetUp
    Set Signal By Name    ${WHEEL_SPEED_SIGNAL}    ${WHEEL_SPEED_VALID}
    Monitor Signal    ${REUNDANT_SENSOR_SIGNAL    ${MONITOR_TIME}
    ${redundant_sensor_value    Get Signal By Name    ${REUNDANT_SENSOR_SIGNAL}
    Should Be Equal    ${redundant_sensor_value}    ${REUNDANT_SENSOR_MATCH}
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