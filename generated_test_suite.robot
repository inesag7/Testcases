*** Settings ***
Resource    Preconditions.resource
Library    TicketID=lane_position_steering_angle    TestLevel=Integration    Status=Ready    TestDescription=Correlate Lane Position with Steering Angle    Author=TestAutomationEngineer    LinkedRequirement=requirement_text: "Correlate Lane_Position signal with Steering_Angle signal."

*** Variables ***
${LANE_POSITION_SIGNAL}    LanePositionSignal
${LANE_POSITION_VALUE}    1.5
${STEERING_ANGLE_SIGNAL}    SteeringAngleSignal
${STEERING_ANGLE_VALUE}    20.0
${MONITOR_TIME}    5

*** Test Cases ***
lane_position_steering_angle_correlation
    [Tags]    LanePosition    SteeringAngle
    [Setup]    Testcase SetUp
    Correlate Lane Position with Steering Angle
    [Teardown]    Testcase TearDown

*** Keywords ***
Correlate Lane Position with Steering Angle
    Set Signal By Name    ${LANE_POSITION_SIGNAL}    ${LANE_POSITION_VALUE}
    Wait Signal Change    ${STEERING_ANGLE_SIGNAL}    ${MONITOR_TIME}
    Check Signal By Name    ${STEERING_ANGLE_SIGNAL}    ${STEERING_ANGLE_VALUE}
    Log    Lane Position and Steering Angle are correlated

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
    RETURN    ${value}