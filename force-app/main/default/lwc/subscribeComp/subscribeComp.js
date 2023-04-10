import { LightningElement,track,wire } from 'lwc';
import { registerListener, unregisterAllListeners } from 'c/pubSub';
import PostOffice from '@salesforce/apex/PostOfficeEndPoint.getPostOficeInfo';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import { CurrentPageReference } from 'lightning/navigation';
export default class SubscribeComp extends LightningElement {
    @track postalCode;
    @track postalCodeDetails;
    @track messageLog;
    @wire(CurrentPageReference)pageRef;
    connectedCallback(){
        registerListener('EventFromPub',this.handlePublish,this);
    }

    disconnectedCallback(){
        unregisterAllListeners(this);
    }

    handlePublish(objPayload) {
            this.postalCode=objPayload;

        PostOffice({ postalCode: this.postalCode })
            .then(result => {
                if (result && result && result.length > 0) {
                     console.log('Postal Code : ', result);
                  
                    this.postalCodeDetails=result;
                   this.Postal=result;
                   console.log('postalcode b data :  '+JSON.stringify(this.postalCodeDetails));
                  console.log('loca var data;;;' + this.postalCodeDetails);
    
                 this.postalCodeDetails.forEach(item => {
                    this.messageLog=item.Message;
                    console.log(item.Message); // John, Jane
                      console.log('  inside loop'+JSON.stringify(item.PostOffice['Name']));
                });
                    // console.log('Dummy var :'+ this.Postal);
                    this.dispatchEvent(new ShowToastEvent({
                      title: 'Done',
                      message: this.messageLog,
                      variant: 'success'
                  }));
                } else {
                    throw new Error('No post offices found for the given postal code.');
                }
            })
            .catch(error => {
                console.log('Error Occured: ', error);
                this.dispatchEvent(new ShowToastEvent({
                    title: 'Error',
                    message: 'An error occurred while fetching the post office details..'+ this.messageLog,
                    variant: 'error'
                }));
            });
    }
}