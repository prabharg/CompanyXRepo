# Bitcoin - Currency Converter App

This SF app lets the users convert between bitcoin value and another currency value. It also has an intutive UI, which auto converts between currencies when the user keys in the value. 

## Approach & Reasoning

### RestService: (RestBitPlayRestAPIService.cls)
This rest callout class, solves one purpose only i.e. makes an API callout to the endpoint. This doesnt have any other business logic which makes it fully reusable for other business purposes also.

### Service: (CurrencyConverterService.cls)
This service class utilizes the RestService and provides the conversion service. This separation of service from controller, makes it reusable across multiple MVCs.

### Controller Extension: (CurrencyConverterExtension.cls)
This class makes use of the UI mapping and soql needed to pupulate the converted currency. It also provides error handling / and also handles AJAX requests populate recent conversions section in the UI.

### Mock Test: (MockRestBitPlayRestAPIService.cls)
This is a mock service class, which will be used to return static API responses when running testclass. This will always return a static dummy conversion rate of 1 Bitcoin = 11.31 USD. This will be used when setting up unit tests.

### Test Classs: (CurrencyConverterTest.cls)
This unit test class will simulate the exact scenario done by the user. This simulates the below tests.

1. Bitcoin to Currency
Sets Bitcoin value in the UI -> Sets up extension class -> Mocks the request -> covers the 2 service classes -> asserts the conversion response from Mock class -> asserts the recent conversion history.

2. Currency to Bitcoin
Sets Bitcoin value in the UI -> Sets up extension class -> Mocks the request -> covers the 2 service classes -> asserts the conversion response from Mock class -> asserts the recent conversion history.

### Page: (CurrencyConverter.vfp)
This uses Bootstrap & jQuery to give an intutive UI, which auto populates the converted value when the user enters. It also add the recent transaction to the UI without refreshing the page.

## Component Details
### Apex Classes
* RestBitPlayRestAPIService
* CurrencyConverterService
* CurrencyConverterExtension
* CurrencyConverterTest
* MockRestBitPlayRestAPIService

### VF Page
* CurrencyConverter.vfp

### Static Resource
* Bootstrap Css & JS
* jQuery JS

### Custom Settings
* Currencies

### Report
* Quick Currency Report

## Author
* **Prabha RG** - *Initial work*
