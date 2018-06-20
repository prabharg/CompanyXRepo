/******************************************************************
*Author: Prabha RG
* Desription:  - This is used as controller extension for CurrencyConverter vfp
* References:  Reffered in Classes
				- CurrencyConverterExtensionTest
*-------------------------------------------------------------------
* 18/06/18    Inital version
********************************************************************/
public class CurrencyConverterExtension {
    
    public CurrencyConverterExtension(ApexPages.StandardController controller) {}//Intentional empty constructor
    
    //SOQL to fetch all the convert transactions for logged in user
    public list<CurrencyConvertTransaction__c> getMyRecentConversions(){
        return [SELECT Bitcoin__c, Currency__c,CurrencyCode__c, Direction__c, CreatedDate  
                FROM CurrencyConvertTransaction__c
                WHERE CreatedById = :USERINFO.getUserId() ORDER BY CreatedDate desc];
    }
    //The currency dropdown on the vfp is fetched from the custom settings
    public List<SelectOption> getFieldOptions(){
        List<SelectOption> fieldOptions = new List<SelectOption>();
        for(CurencyCodes__c curCode : [select code__c, name from CurencyCodes__c Order By code__c]){
            fieldOptions.add(new SelectOption(curCode.code__c, curCode.code__c));
        }
        return fieldOptions;
    }
    //The method is called from the vfp
    public void convert(){
        try{
            hasError = false;
            if('B->C'.equalsIgnoreCase(cType)){
                bVal = String.isEmpty(bVal)?'0':bVal;
                //This makes the actual callout
                curVal = String.valueOf(CurrencyConverterService.convertFromBitcoinToCurrency(double.valueOf(bVal),cur));
            }else{
                curVal = String.isEmpty(curVal)?'0':curVal;
                //this makes the actual callout
                bVal = String.valueOf(CurrencyConverterService.convertFromCurencyToBitcoin(double.valueOf(curVal),cur));
            }
            //insert the transaction record
            insert new CurrencyConvertTransaction__c(Bitcoin__c=double.valueOf(bVal),
                                                     Currency__c=curVal,
                                                     CurrencyCode__c = cur,
                                                     Direction__c=cType);
        }catch(Exception exp){
            system.debug('exp.message -> '+exp.getStackTraceString());
            hasError = true;
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,exp.getMessage()));
        }
    }   
    public String curVal {get;set;}
    public String bVal {get;set;}
    public String cType {get;set;}
    public String cur {get;set;}
    public Boolean hasError {get;set;}
}