/**
* Contains test methods for the CurrencyConverterExtension.
*/
@IsTest(SeeAllData=false)
public class CurrencyConverterTest {
    @IsTest
    static void validate_bitcoin_to_currency(){
        PageReference pageRef = Page.CurrencyConverter;
        Test.setCurrentPage(pageRef);
        Test.setMock(HttpCalloutMock.class, new MockRestBitPlayRestAPIService());
        CurrencyConverterExtension ccxt = new CurrencyConverterExtension(new ApexPages.StandardController(new CurrencyConvertTransaction__c()));
		//Setting up inputs and starting test
		Test.startTest();
        ccxt.bVal = '2.0';
        ccxt.cType = 'B->C';
        ccxt.cur = 'USD';
        ccxt.convert();
        Test.stopTest();
        //Check if the mockservice is setup correctly and the bitcoin is converted to usd
        system.assertEquals(ccxt.curVal, '22.62');
        //Check if the resentTransactions are inserted correctly
        list<CurrencyConvertTransaction__c> rTxs = ccxt.getMyRecentConversions();
        system.assert(rTxs!=null && rTxs.size() == 1);
        system.assert(rTxs[0].Bitcoin__c == double.valueOf('2.0'));
        system.assert(rTxs[0].Currency__c == '22.62');
        system.assert(rTxs[0].CurrencyCode__c == 'USD');
        
    }
    @IsTest
    static void validate_currency_to_bitcoin(){
        PageReference pageRef = Page.CurrencyConverter;
        Test.setCurrentPage(pageRef);
        Test.setMock(HttpCalloutMock.class, new MockRestBitPlayRestAPIService());
        CurrencyConverterExtension ccxt = new CurrencyConverterExtension(new ApexPages.StandardController(new CurrencyConvertTransaction__c()));
		//Setting up inputs and starting test
		Test.startTest();
        ccxt.curVal = '22.62';
        ccxt.cType = 'C->B';
        ccxt.cur = 'USD';
        ccxt.convert();
        system.assertEquals(ccxt.bVal, '2.0');
        Test.stopTest();
        //Check if the mockservice is setup correctly and the bitcoin is converted to usd
        system.assertEquals(ccxt.curVal, '22.62');
        //Check if the resentTransactions are inserted correctly
        list<CurrencyConvertTransaction__c> rTxs = ccxt.getMyRecentConversions();
        system.assert(rTxs!=null && rTxs.size() == 1);
        system.assert(rTxs[0].Bitcoin__c == double.valueOf('2.0'));
        system.assert(rTxs[0].Currency__c == '22.62');
        system.assert(rTxs[0].CurrencyCode__c == 'USD');
    }
    @IsTest
    static void selectOptions(){
       //setting the testdata
       List<CurencyCodes__c> lst = new List<CurencyCodes__c> ();
       lst.add(new CurencyCodes__c(code__c = 'USD',name='US Dollars'));
       lst.add(new CurencyCodes__c(code__c = 'EUR',name='EURO'));
       insert lst;
       CurrencyConverterExtension ccxt = new CurrencyConverterExtension(new ApexPages.StandardController(new CurrencyConvertTransaction__c())); 
       List<SelectOption> sopt = ccxt.getFieldOptions();
       system.assert(sopt!=null && sopt.size()==2);
    }
}
