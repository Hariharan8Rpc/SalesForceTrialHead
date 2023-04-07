public class PostalPincodeEndpoint {
    public class PostalPincodeResponse {
        public List<PostalPincodeResult> PostOffice { get; set; }
        public String  Message { get; set; }
    }
    
    public class PostalPincodeResult {
        public String Name { get; set; }
        public String Description { get; set; }
        public String BranchType { get; set; }
        public String DeliveryStatus { get; set; }
        public String Circle { get; set; }
        public String District { get; set; }
        public String Division { get; set; }
        public String Region { get; set; }
        public String State { get; set; }
        public String Country { get; set; }
        public String Pincode { get; set; }
    }
    
    @AuraEnabled(cacheable=true)
    public static PostalPincodeResponse getPostalPincodeInfo(String pincode) {
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint('https://api.postalpincode.in/pincode/' + pincode);
        request.setMethod('GET');
        HttpResponse response = http.send(request);
        
        if (response.getStatusCode() == 200) {
            PostalPincodeResponse result = (PostalPincodeResponse) JSON.deserialize(response.getBody(), PostalPincodeResponse.class);
          system.debug(result);
        //   system.debug(result.PostOffice);
            return result;
        } else {
            return null;
        }
    }
}
