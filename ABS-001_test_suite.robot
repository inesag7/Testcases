*** Settings ***
Resource    Preconditions.resource
Library    DateTime
Metadata
    TicketID          ABS-001
    TestLevel          Component
    Status            Ready
    TestDescription   Verify ABS State Machine Transitions
    Author           Your Name
    LinkedRequirement  State Machine for ABS: States - Idle, Monitoring, Activating}; Transitions - Idle -> Monitoring (when speed > 0), Monitoring -> Activating (when skid detected)

*** Variables ***
${SPEED_SIGNAL}         VehicleSpeed
${SKID_DETECTED_SIGNAL}    SkidDetected
${ABS_STATE_SIGNAL}    ABSState
${TRANSITION_TIMEOUT}    5
${MONITOR_TIME}      10
${EXPECTED_IDLE_STATE}   0
${EXPECTED_MONITORING_STATE}    1
${EXPECTED_ACTIVATING_STATE} 2

*** Test Cases ***
ABS_State_Machine_Transitions
    [Tags]    ABS    SkidDetection
    [Setup]    Testcase SetUp
    [Teardown]    Testcase TearDown

    # Start in idle state
    ${initial_state} =    Get Signal By Name    ${ABS_STATE_SIGNAL}
    Should Be Equal    ${initial_state}    ${EXPECTED_IDLE_STATE}

    # Transition to monitoring state when speed > 0
    Set Signal By Name    ${SPEED_SIGNAL}    10
    Wait Signal Change    ${ABS_STATE_SIGNAL}    ${TRANSITION_TIMEOUT}
    ${monitoring_state} =    Get Signal By Name    ${ABS_STATE_SIGNAL}
    Should Be Equal    ${monitoring_state}    ${EXPECTED_MONITORING_STATE}

    # Transition to activating state when skid detected
    Set Signal By Name    ${SKID_DETECTED_SIGNAL}    1
    Wait Signal Change    ${ABS_STATE_SIGNAL}    ${TRANSITION_TIMEOUT}
    ${activating_state} =    Get Signal By Name    ${ABS_STATE_SIGNAL}
    Should Be Equal    ${activating_state}    ${EXPECTED_ACTIVATING_STATE}

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