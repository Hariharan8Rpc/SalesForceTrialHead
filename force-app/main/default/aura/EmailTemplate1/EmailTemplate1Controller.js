({
    doInit : function(component, event, helper) {
         console.log("Entered do init");
        var recordId = component.get("v.recordId");
        console.log("record id is----"+ recordId);
        var action = component.get("c.getContactRecord");
        action.setParams({
            "contactId": recordId
            
        });
        
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                  console.log('inside call');
                var contact = response.getReturnValue();
                component.set("v.contactRecord", contact);
            }
        });
        $A.enqueueAction(action);
    },
    
    
	Send : function(component, event, helper) {
        var email=helper._e('txtEmail').value;
        var Subject=helper._e('txtSubject').value;
        var Message=helper._e('txtMessage').value;
       // var Message=component.get("v.myMessage");        
        var regExpEmailformat = /^(([^<>()\[\]\\.,;:\s@"]+(\.[^<>()\[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/; 
        
        if(email==''){
            alert('Email-Id is required');
        }
        else if(Subject==''){
            alert('Subject is required');
        }
        else if(Message==''){
         alert('Message is required');
        }
        else{
            if(!email.match(regExpEmailformat)){
                alert("Invalid Email Id");
            }
            else{
                helper.SendEmail(component);
            }
        }
    },
    
    showSpinner: function(component, event, helper) {        
        component.set("v.Spinner", true); 
    },
    
    hideSpinner : function(component,event,helper){        
        component.set("v.Spinner", false);
	},	
 })