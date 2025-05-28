*** Settings ***
Library           DateTime
Resource          Preconditions.resource
Metadata        TicketID         1234
Metadata        TestLevel        Integration
Metadata        Status          Ready
Metadata        TestDescription  Correlate Lane_Position with Steering_Angle
Metadata        Author          John
Metadata        LinkedRequirement      Correlate Lane_Position_SIGNAL}     LanePosition
Metadata        LinkedRequirement}      Correlate Lane_Position signal with Steering_Angle signal.

*** Variables ***
${LANE_POSITION_SIGNAL}     LanePosition
${STEERING_ANGLE_SIGNAL}    SteeringAngle
${CORRELATED_STATE}         True

*** Test Cases ***
1234_Correlate LanePosition With SteeringAngle
    [Tags]    Integration    Correlation
    [Setup]    Testcase SetUp
    [Teardown]  Testcase TearDown

    # Correlate Lane Position signal with Steering Angle signal
    ${lane_position_signal_value} =    Get Signal By Name    ${LANE_POSITION_SIGNAL}
    Set Signal By Name    ${STEERING_ANGLE_SIGNAL}    ${lane_position_signal_value}
    Wait Signal Change    ${STEERING_ANGLE_SIGNAL}    5
    Check Signal By Name    ${STEERING_ANGLE_SIGNAL}    ${lane_position_signal_value}
    log    Lane Position correlated with Steering Angle successfully

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