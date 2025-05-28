*** Settings ***
Resource    Preconditions.resource
Metadata    TicketID    BAT-001
Metadata    TestLevel    System
Metadata    Status    Ready
Metadata    Author    Automation Team
Metadata    TestDescription    Battery Power-Saving Mode
Metadata    LinkedRequirement    The battery shall enter power-saving mode if the charge is below 10%.

*** Variables ***
${CHARGE_SIGNAL}    BatteryChargeLevel
${CHARGE_VALUE}    10
${POWER_SAVING_MODE}    1
${TIMEOUT}    5s

*** Test Cases ***
BAT_001_Power_Saving_Mode
    [Setup]    Testcase SetUp
    [Teardown]    Testcase TearDown
    [Tags]    power-saving    battery

    # Set initial charge level
    Set Signal By Name    ${CHARGE_SIGNAL}    ${POWER_SAVING_MODE}

    # Wait for power-saving mode
    Wait Signal    ${CHARGE_SIGNAL}    ${TIMEOUT}

    # Verify power-saving mode
    Check Signal By Name    ${CHARGE_SIGNAL}    ${POWER_SAVING_MODE}

    # Log result
    Log    Battery entered power-saving mode

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
    RETURN    ${value}