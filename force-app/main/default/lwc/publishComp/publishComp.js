import { LightningElement,track,wire } from 'lwc';
import { CurrentPageReference } from 'lightning/navigation';
import {
    registerListener,
    unregisterListener,
    unregisterAllListeners,
    fireEvent
} from 'c/pubSub';

export default class PublishComp extends LightningElement {
    @track postalCode;
    @track postalCodeDetails;
    @wire(CurrentPageReference) objectReference;

     
    handlePostalCodeChange(event) {
        this.postalCode = event.target.value;
    }
    
      publishEvent(){
        fireEvent(this.objectReference,'EventFromPub',this.postalCode);
    }

}