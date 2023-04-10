import { LightningElement, api,track,wire} from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import PostOffice from '@salesforce/apex/PostOfficeEndPoint.getPostOficeInfo';

// import message from '@salesforce/apex/PostOfficeEndPoint.cls_PostOffice.message';
// import Name from '@salesforce/apex/PostOfficeEndPoint.cls_PostOffice.Name';{
export default class postOfficePage extends LightningElement {
  @track postalCode;
  @track postalCodeDetails;

  handlePostalCodeChange(event) {
      this.postalCode = event.target.value;
  }

  handleButtonClick() {
    PostOffice({ postalCode: this.postalCode })
        .then(result => {
            if (result && result && result.length > 0) {
                // this.postalCodeDetails = JSON.stringify(result);
            //     const parsedResult = JSON.parse(result);
                console.log('Postal Code : ', result);
            // this.postalCodeDetails = parsedResult[0].PostOffice;
            // console.log('PostOffice Details: ', JSON.stringify(parsedResult[0].PostOffice));
            // console.log('Postal Code : ', parsedResult);
            // console.log('Postal Code Details: ', parsedResult[0].PostOffice);
            
                this.postalCodeDetails=result;
               this.Postal=result;
               console.log('postalcode b data :  '+JSON.stringify(this.postalCodeDetails));
              console.log('loca var data;;;' + this.postalCodeDetails);

             this.postalCodeDetails.forEach(item => {
                console.log(item.Message); // John, Jane
                  console.log('  inside loop'+JSON.stringify(item.PostOffice['Name']));
            });
                // console.log('Dummy var :'+ this.Postal);
                this.dispatchEvent(new ShowToastEvent({
                  title: 'Done',
                  message: 'Results fetched',
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
                message: 'An error occurred while fetching the post office details. Please try again later.',
                variant: 'error'
            }));
        });
}


}