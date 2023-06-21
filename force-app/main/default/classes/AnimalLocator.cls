public class AnimalLocator {
    public static String getAnimalNameById(Integer id){
	 Http http = new Http();
        String strResp='';
        HttpRequest request = new HttpRequest();
        System.debug('before ');
        request.setEndpoint('https://th-apex-http-callout.herokuapp.com/animals/'+id);
        request.setMethod('GET');
        HttpResponse response = http.send(request);
        if(response.getStatusCode() == 200) {
            Map<String, Object> results = (Map<String, Object>) JSON.deserializeUntyped(response.getBody());
            System.debug('Mock test');
            System.debug(results);
             Map<String,object> animals = (map<string,object>) results.get('animal');
            System.debug(animals);
            strResp = string.valueof(animals.get('name'));
        }  
          return strResp;
    }
}