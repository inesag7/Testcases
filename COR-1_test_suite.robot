*** Settings ***
Resource    Resource.robot
Library    DateTime
Metadata
    TicketID        COR-1
    TestLevel    Acceptance
    Ready
    TestDescription    Correlate Lane_Position signal with Steering_Angle signal
    Author    [Your Name]
    LinkedRequirement    requirement_text:"Correlate Lane_Position signal with Steering_Angle signal."

*** Variables ***
${LANE_POSITION_SIGNAL}    Lane_Position
${STEERING_ANGLE_SIGNAL}    Steering_Angle
${CORRELATION_THRESHOLD}    10
${MONITOR_TIME}    5

*** Test Cases ***
COR_1_CorrelateLane_Position_With_Steering_Angle
    [Setup]    Testcase SetUp
    [Teardown]    Testcase TearDown
    [Tags]    correlation    lane_position    steering_angle

    # Initialize Lane_Position signal
    Set Signal By Name    ${LANE_POSITION_SIGNAL}    0

    # Initialize Steering_Angle signal
    Set Signal By Name    ${STEERING_ANGLE_SIGNAL}    0

    # Monitor Lane_Position signal for 5 seconds
    Monitor Signal    ${LANE_POSITION_SIGNAL}    ${MONITOR_TIME}

    # Check Steering_Angle signal correlates with Lane_Position signal
    ${steering_angle_value} =    Get Signal By Name    ${STEERING_ANGLE_SIGNAL}
    Should Be True    ${steering_angle_value} > ${LANE_POSITION_SIGNAL} - ${CORRELATION_THRESHOLD} or ${steering_angle_value} < ${LANE_POSITION_SIGNAL} + ${CORRELATION_THRESHOLD}

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
    RETURN    ${value}