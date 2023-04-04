// contactEmailForm.js

import { LightningElement, api, wire,track} from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import { getRecord,getFieldValue } from 'lightning/uiRecordApi';
// import { getUserInfo } from 'lightning/uiRecordApi';
import sendmail from '@salesforce/apex/EmailTemplate1.sendEmail';
import getUserEmail from '@salesforce/apex/EmailTemplate1.getUserEmail';
const fields = [
    'Contact.Email','Contact.Name'
];

export default class emailTemplate2 extends LightningElement {
    @api toName;
    @api subject;
    @api recordId;
    @api ccAddress;
    @api bccAddress;
    @api toAddress;
    @api body;
    @api userEmail;
        
    @track emailid ='';

    @track showField = false;

  bodyContent='--------------------Contact Detail----------------';
    showInputField() {
        this.showField = true;
    }

    connectedCallback() {
        getUserEmail()
            .then(result => {
                this.userEmail = result;
                this.bccAddress=result;
                this.emailid=result;
            })
            .catch(error => {
                console.log(error);
            });
    }

    @wire(getRecord, { recordId: '$recordId', fields })
    wiredContact({ error, data }) {
        if (data) {
            console.log('inside');
            this.toName=data.fields.Name.value;
            this.toAddress = data.fields.Email.value;
            this.body=this.bodyContent+ data.fields.Name.value;
            console.log(this.toAddress);
        } else if (error) {
            this.showErrorToast(error);
        }
    }

    items = [
        {
            type: 'avatar',
            href: 'https://mindful-shark-5lad46-dev-ed.trailblaze.lightning.force.com/lightning/r/User/0052w00000FIRThAAP/view',
            label:'hariharangounder1@gmail.com',
            src: 'https://www.lightningdesignsystem.com/assets/images/avatar1.jpg',
            fallbackIconName: 'standard:user',
            variant: 'circle',
            alternativeText: 'User avatar',
            isLink: false,
        }
    ];

handleEmailChange(event){
    this.toAddress = event.target.value;
    console.log(this.toAddress);
} 
handleCcEmailChange(event){
    this.ccAddress=event.target.value;
    console.log(this.ccAddress);
}

handlebccEmailChange(event){
    this.bccAddress=event.target.value;
    console.log(this.bccAddress);
}
handleSubjectChange(event){
    this.subject=event.target.value;
    console.log(this.subject);
}
handleBodyChange(event){
    this.body=event.target.value;
    console.log(this.body);
}

    handleSendEmail() {
        console.log('inside handle mail');
        if (!this.toAddress) {
            this.showErrorToast('Please enter a valid email address for the recipient.');
            return;
        }

        if (!this.subject) {
            this.showErrorToast('Please enter a subject for the email.');
            return;
        }

        if (!this.body || this.body.length < 5) {
            this.showErrorToast('Please enter a message of at least 10 characters.');
            return;
        }
    
     sendmail({email: this.toAddress, Subject: this.subject, ccAddress:this.ccAddress, bccAddress: this.bccAddress,Message: this.body}).then(() => {
                console.log('inside send mail  2');
                console.log(this.toAddress);
                console.log(this.ccAddress);
                console.log(this.subject);
                console.log(this.body);
                console.log('mail function exit');
                this.showSuccessToast();
                this.clearForm();
            })
            .catch((error) => {
                this.showErrorToast(error);
            });
    }

    clearForm() {
        this.toAddress = '';
        this.ccAddress = '';
        this.subject = '';
        this.body = '';
    }

    showSuccessToast() {
        const toastEvent = new ShowToastEvent({
            title: 'Email Sent',
            message: 'Your email was sent successfully.',
            variant: 'success'
        });
        this.dispatchEvent(toastEvent);
    }

    showErrorToast(message) {
        const toastEvent = new ShowToastEvent({
            title: 'Error',
            message,
            variant: 'error'
        });
        this.dispatchEvent(toastEvent);
    }    
}