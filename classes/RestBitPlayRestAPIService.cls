/******************************************************************
*Author: Prabha RG
* Desription:  - Class which has the REST API to query bitPlay API
* References:  Reffered in Classes
				- CurrencyConverterService
*-------------------------------------------------------------------
* 18/06/18    Inital version
********************************************************************/
public class RestBitPlayRestAPIService {
    
    @TestVisible
    private static final String bitPlay_NamedCred  = 'callout:BitPlayRates';
    
	//===================================================
	// Method Which send the HTTP GET Request to fetch the 
	// currency rates from BitPlayRates API
	//===================================================
    public static Map<String,Double> getCurrencyRates(){
        HttpRequest req = new HttpRequest();
        req.setEndpoint(bitPlay_NamedCred);
        req.setMethod('GET');
        Http http = new Http();
        HTTPResponse res = http.send(req);
        List<CurRate> rateList = (List<CurRate>)Json.deserialize(res.getBody(),List<CurRate>.Class);
        return getRateMapFromList(rateList);
    }
    
    private static Map<String,Double> getRateMapFromList(List<CurRate> rateList){
        Map<String,Double> rateMap = new Map<String,Double>();
        for(CurRate rate : rateList){
            rateMap.put(rate.code, rate.rate);
        }
        return rateMap;
    }
    
   //============================================
   //Wrapper class for CurrencyRate Response info
   //============================================
    @TestVisible
    public class CurRate{
    public String code;
    public String name;
    public Double rate;
    }
}