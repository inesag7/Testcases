*** Settings ***
Resource    Preconditions.resource
Library    TicketID=1234    TestLevel=Acceptance    Status=Ready    TestDescription=Correlate Lane Position signal with Steering Angle signal.    Author=Test Engineer    LinkedRequirement=requirement_text: Correlate Lane_Position signal with Steering_Angle signal.

*** Variables ***
${LANE_POSITION_SIGNAL}    LanePositionSignal
${STEERING_ANGLE_SIGNAL}    SteeringAngleSignal
${EXPECTED_CORRELATION}    True

*** Test Cases ***
req1234_Correlate_Lane_Position_Steering_Angle
    [Setup]    Testcase SetUp
    [Teardown]    Testcase TearDown
    [Tags]    Lane_Position    Steering_Angle    Correlation

    # Setup Lane Position and Steering Angle signals
    Set Signal By Name    ${LANE_POSITION_SIGNAL}    ${EXPECTED_CORRELATION}
    Set Signal By Name    ${STEERING_ANGLE_SIGNAL}    ${EXPECTED_CORRELATION}

    # Verify correlation between Lane Position and Steering Angle signals
    Check Signal By Name    ${LANE_POSITION_SIGNAL}    ${EXPECTED_CORRELATION}
    Check Signal By Name    ${STEERING_ANGLE_SIGNAL}    ${EXPECTED_CORRELATION}

    # Monitor signals for 5 seconds to ensure correlation
    Monitor Signal    ${LANE_POSITION_SIGNAL}    5
    Monitor Signal    ${STEERING_ANGLE_SIGNAL}    5

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