/******************************************************************
*Author: Prabha RG
* Desription:  - This class will retrieve the value of Bitcoin vs A Currency and vice versa
* References:  Reffered in Classes
				- 
*-------------------------------------------------------------------
* 18/06/18    Inital version
********************************************************************/
public class CurrencyConverterService {
    
	private static Map<String,Double> rateMap;
    
    public static Double currencyRateValue(String curCode){
        Double rateForCurrency ;
        if(rateMap == null){
            system.debug('Calling the Rest service');
            rateMap = RestBitPlayRestAPIService.getCurrencyRates();
        }
        curCode = (curCode!=null)? curCode.toUpperCase() : '';
        if (rateMap == null || !rateMap.containsKey(curCode)){
            throw new ConversionException('Unable to retrieve Currency Rates. Please contact Admin');
        }
        rateForCurrency = rateMap.get(curCode);
        return rateForCurrency;
    }
    public static Double convertFromCurencyToBitcoin(Double curValue, String fromCurCode){
        Double convertedValue;
        try{
        	Double rateForCurrency = currencyRateValue(fromCurCode);
            convertedValue = curValue / rateForCurrency;
        }catch(Exception exp){
            throw new ConversionException(exp.getMessage());
        }
        return convertedValue;
    }
    public static Double convertFromBitcoinToCurrency(Double curValue, String ToCurCode){
        Double convertedValue;
        try{
        	Double rateForCurrency = currencyRateValue(ToCurCode);
            convertedValue = curValue * rateForCurrency;
        }catch(Exception exp){
            throw new ConversionException(exp.getMessage());
        }
        return convertedValue;
    }
    public class ConversionException extends Exception{}
}