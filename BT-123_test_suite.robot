*** Settings ***
Resource    Preconditions.resource
Library    DateTime
Metadata
    TicketID    BT-123
    TestLevel    Component
    Status    Ready
    TestDescription    Power-saving mode for battery charge below 10%
    Author    John Doe
    LinkedRequirement    Requirement 1: Battery Power-Saving Mode

*** Variables ***
${BATTERY_CHARGE}    BatteryCharge
${CHARGE_VALUE}    10***
${POWER_SAVING_MODE}    PowerSavingMode
${EXPECTED_STATE}    Enabled

*** Test Cases ***
BT_123_Battery_PowerSaving_Mode
    [Tags]    PowerSavingMode    Battery
    [Setup]    Testcase SetUp
    [Teardown]    Testcase TearDown
    # Initialize battery charge input
    Set Signal By Name    ${BATTERY_CHARGE}    ${CHARGE_VALUE}
    # Validate transition to power saving mode
    Wait Signal Change    ${POWER_SAVING_MODE}    5
    # Verify expected power saving mode state
    Check Signal By Name    ${POWER_SAVING_MODE}    ${EXPECTED_STATE}

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

Wait Signal Change
    Waits for signal to change within timeout (seconds)
    [Arguments]    ${SignalName}    ${Timeout}
    Wait Signal Change    ${SignalName}    ${Timeout}

Get Signal By Name
    [Documentation]    Retrieves current value of the specified signal
    [Arguments]    ${SignalName}
    ${value} =    get_signal_by_name    ${SignalName}
    RETURN      ${value}
Monitor Signal
    [Documentation]    Monitors a signal for specified duration (seconds)
    [Arguments]    ${SignalName}    ${MonitorTime}
    [Timeout]    ${MonitorTime + 10}    # Add buffer to timeout
    Monitor Signal    ${SignalName}    ${MonitorTime}