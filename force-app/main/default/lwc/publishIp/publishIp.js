import { LightningElement ,track} from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import getIpDetail from '@salesforce/apex/ipStack.getIpInfo';
export default class PublishIp extends LightningElement {
 @track ipAddress;
 @track list;
 @track mapMarkers;
    handleipChange(event) {
        this.ipAddress = event.target.value;
        console.log('ipaddress'+this.ipAddress);
    }

    handleButtonClick() {
        getIpDetail({ ipAddress: this.ipAddress})
            .then(result => {
                console.log('IP List : ', result);    
              //  this.list=result;
                if (result) {
                    console.log('IP List 1: ', result);                
                    this.list=result;
                    this.dispatchEvent(new ShowToastEvent({
                      title: 'Done',
                      message: 'Results fetched',
                      variant: 'success'
                  }));
                 this.mapMarkers = [
                    {
                        location: {
                            Latitude: this.list.latitude,
                            Longitude: this.list.longitude,
                        },
                    },
                ];
                } else {
                    throw new Error(' error .');
                }
            })
            .catch(error => {
                console.log('ip listavalues in result'+result);
                console.log('Error Occured: ', error);
                this.dispatchEvent(new ShowToastEvent({
                    title: 'Error',
                    message: 'An error occurred while fetching IP Detail Please try again later.',
                    variant: 'error'
                }));
            });
    }
}