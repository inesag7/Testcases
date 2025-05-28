*** Settings ***
Resource    Preconditions.resource
Library    TicketID    RT-123
Metadata    TestLevel    System
Metadata    Status    Ready
TestDescription    Disable airbags when vehicle is stationary for more than 5 minutes
Author    John Doe
LinkedRequirement    RT-123

*** Variables ***
${VEHICLE_SPEED_SIGNAL    VehicleSpeed
${VEHICLE_SPEED_STATIONARY}    0
${AIRBAG_SIGNAL}    AirbagEnabled
${AIRBAG_DISABLED}    0
${VEHICLE_STATIONARY_TIMEOUT}    300  # 5 minutes in seconds

*** Test Cases ***
RT-123_DisableAirbags_Stationary
    [Setup]    Testcase SetUp
    [Tags]    airbag    vehicle_speed
    Set Signal By Name    ${VEHICLE_SPEED_SIGNAL}    ${VEHICLE_SPEED_STATIONARY}
    Monitor Signal    ${VEHICLE_SPEED_SIGNAL}    ${VEHICLE_STATIONARY_TIMEOUT}
    Check Signal By Name    ${AIRBAG_SIGNAL}    ${AIRBAG_DISABLED}
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