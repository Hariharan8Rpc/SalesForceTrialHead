public class ipStack{
	@AuraEnabled
	public String ip{get;set;}	//157.45.183.82
	@AuraEnabled
	public String type{get;set;}//ipv4
	@AuraEnabled
	public String continent_code{get;set;}	//AS
	@AuraEnabled
	public String continent_name{get;set;}	//Asia
	@AuraEnabled
	public String country_code{get;set;}	//IN
	@AuraEnabled
	public String country_name{get;set;}	//India
	@AuraEnabled
	public String region_code{get;set;}	//KA
	@AuraEnabled
	public String region_name{get;set;}	    //Karnataka
	@AuraEnabled
	public String city{get;set;}	//Bengaluru
	@AuraEnabled
	public String zip{get;set;}	//560023
	@AuraEnabled
	public Double latitude{get;set;}//12.973999977111816
	@AuraEnabled
	public Double longitude{get;set;}	//77.55909729003906
/*	public cls_location location;
    
	class cls_location {
		public Integer geoname_id;	//1277333
		public String capital;	//New Delhi
		public cls_languages[] languages;
		public String country_flag;	//https://assets.ipstack.com/flags/in.svg
		public String country_flag_emoji;	//🇮🇳
		public String country_flag_emoji_unicode;	//U+1F1EE U+1F1F3
		public String calling_code;	//91
		public boolean is_eu;
	}
	class cls_languages {
		public String code;	//hi
		public String name;	//Hindi
		public String native;	//हिन्दी
	}
*/
	
   public static ipStack parse(String json){
		return (ipStack) System.JSON.deserialize(json, ipStack.class);
	}
	// @AuraEnabled
    // public static ipStack  iplist1 {get;set;}

    @AuraEnabled(cacheable=true)
    public static ipStack getIpInfo(String ipAddress) {
      //  134.201.250.155 
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        ipStack result =new ipStack();
       String endpoint='http://api.ipstack.com/'+ipAddress+'?access_key=77a75cf9355a039271ee8f8786dd636e';
       //  String endpoint='http://api.ipstack.com/134.201.250.155?access_key=77a75cf9355a039271ee8f8786dd636e';
        request.setEndpoint(endpoint);
        request.setMethod('GET');
        System.debug('endpoint '+ endpoint);
        system.debug('request'+request);
        HttpResponse response = http.send(request);    
		
		if (response.getStatusCode() == 106 && response.getbody() != null ) {
			system.debug('response T '+response.getbody());	  
		}

        if (response.getStatusCode() == 200 && response.getbody() != null ) {
          result = (ipStack) JSON.deserialize(response.getBody(), ipStack.class);
		  
		  system.debug('result '+result);
        }
		
		return result;
		//  else {
        //     return null;
        // }
    }
    public ipStack ipList {get;set;}

	@AuraEnabled
    public static String ipAddress{set;get;}

//	@AuraEnabled(cacheable=true)
 public void search(){
        system.debug('Inside ipController');
        system.debug('ip address inside controller'+ipAddress);
        ipList=(getIpInfo(ipAddress));
        System.debug('iplist Data'+ipList);
    }
}