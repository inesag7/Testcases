*** Settings ***
Documentation   Test suite for battery power-saving mode
Resource   Preconditions.resource
Library   DateTime

Metadata
TicketID         BAT-001
TestLevel       Component
Status         Ready
TestDescription   Verify battery enters power-saving mode when charge is below 10%
Author         Test Automation Engineer
LinkedRequirement   The battery shall enter power-saving mode if the charge is below 10%

*** Variables ***
${BATTERY_CHARGE_SIGNAL}     BatteryCharge
${LOW_CHARGE_THRESHOLD}    10
${POWER_SAVING_MODE_SIGNAL}     PowerSavingMode
${EXPECTED_POWER_SAVING_MODE}    True

*** Test Cases ***
BAT_001_Enter_Power_Saving_Mode
    [Tags]    Battery
    [Setup]    Testcase SetUp
    Set Signal By Name    ${BATTERY_CHARGE_SIGNAL}    ${LOW_CHARGE_THRESHOLD - 1}
    Wait Signal Change    ${POWER_SAVING_MODE_SIGNAL}    5
    Check Signal By Name    ${POWER_SAVING_MODE_SIGNAL}    ${EXPECTED_POWER_SAVING_MODE}
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