*** Settings ***
Library           DateTime
Resource          Preconditions.resource
Metadata
TicketID         ABS-001
TestLevel         Acceptance
Status          Ready
Author           TestAutomation
LinkedRequirement    State Machine for ABS

*** Variables ***
${IDLE_STATE}         Idle
${MONITORING_STATE}     Monitoring
${ACTIVATING_STATE}    Activating
${SPEED_SIGNAL}       VehicleSpeed
${SPEED_VALUE}       1
${SKID_DETECTION_SIGNAL}   SkidDetected
${SKID_DETECTION_VALUE}     1
${EXPECTED_STATE}     ${ACTIVATING_STATE}
${IDLE_TO_MONITORING_TRANSITION_TIMEOUT}    5
${MONITORING_TO_ACTIVATING_TRANSITION_TIMEOUT}    10

*** Test Cases ***
ABS_001_State_Machine_Transitions
    [Tags]    ABS    StateMachine    Transitions
    [Setup]    Testcase SetUp
    [Teardown]    Testcase TearDown

    # Initialize system
    Log    Initializing system...

    # Start in Idle state
    Set Signal By Name    ${SPEED_SIGNAL}    ${SPEED_VALUE}
    Wait Signal Change    ${SPEED_SIGNAL}    ${IDLE_TO_MONITORING_TRANSITION_TIMEOUT}
    Check Signal By Name    ${STATE_SIGNAL}    ${MONITORING_STATE}

    # Transition to Activating state when skid detected
    Set Signal By Name    ${SKID_DETECTION_SIGNAL}    ${SKID_DETECTION_VALUE}
    Wait Signal Change    ${SKID_DETECTION_SIGNAL}    ${MONITORING_TO_ACTIVATING_TRANSITION_TIMEOUT}
    Check Signal By Name    ${STATE_SIGNAL}    ${ACTIVATING_STATE}

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