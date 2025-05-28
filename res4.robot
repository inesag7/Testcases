*** Settings ***
Resource          Preconditions.resource
Library           DateTime

Metadata
    TicketID           AUT-123
    TestLevel          Component
    Status             Ready
    TestDescription   Verify rear window lock feature enablement based on coding CP RearWindowLock
    Author             Test Automation Team
    LinkedRequirement  The rear window lock feature is enabled only if coding CP RearWindowLock = 1.

*** Variables ***
${REAR_WINDOW_LOCK_FEATURE}     RearWindowLockFeature
${CP_REAR_WINDOW_LOCK}         CPRearWindowLock
${CP_REAR_WINDOW_LOCK_ENABLED}  1
${REAR_WINDOW_LOCK_ENABLED_STATE}  Enabled

*** Test Cases ***
AUT-123_RearWindowLock_Enabled
    [Tags]  RearWindowLock  FeatureEnablement
    [Setup]  Testcase SetUp
    [Teardown]  Testcase TearDown
    Set Signal By Name  ${CP_REAR_WINDOW_LOCK}  ${CP_REAR_WINDOW_LOCK_ENABLED}
    Wait Until Signal Is  ${REAR_WINDOW_LOCK_FEATURE}  ${REAR_WINDOW_LOCK_ENABLED_STATE}
    [Teardown]  Set Signal By Name  ${CP_REAR_WINDOW_LOCK}  0

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

Wait Until Signal Is
    [Documentation]    Waits until signal matches expected value within timeout (seconds)
    [Arguments]    ${SignalName}    ${ExpectedValue}    ${Timeout}
    Wait Until Signal Is    ${SignalName}    ${ExpectedValue}    ${Timeout}