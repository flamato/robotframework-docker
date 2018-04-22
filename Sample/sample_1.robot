*** Settings ***
Documentation     Sample Case From https://github.com/Kenith/robotframework-docker
Suite Teardown    Close Browser
Library           SeleniumLibrary  timeout=120

*** Variables ***
${BROWSER}        Chrome
${FF_PROFILE}     ${None}
${RF_URL}         http://robotframework.org/

*** Test Cases ***
Sample Case
   open browser  ${RF_URL}  ${BROWSER}  ff_profile_dir=${FF_PROFILE}
   wait until element is enabled  css:a[href="#libraries"]
   click element  css:a[href="#libraries"]
