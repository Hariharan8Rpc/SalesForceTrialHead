import { LightningElement ,api, track } from 'lwc';

export default class Postal extends LightningElement {
  postalCode;
  @track myArray = [
    {
      message: 'Hello',
      status: 'Success',
      postalCodes: [
        { code: '123', name: 'ABC', description: 'Some description', district: 'Some district' },
        { code: '456', name: 'DEF', description: 'Another description', district: 'Another district' }
      ]
    },
    {
      message: 'Hi',
      status: 'Failure',
      postalCodes: [
        { code: '789', name: 'GHI', description: 'Yet another description', district: 'Yet another district' },
        { code: '012', name: 'JKL', description: 'One more description', district: 'One more district' }
      ]
    }
  ];

    handlepostalCodeChange(event){
        this.postalCode=event.target.value;
        console.log(this.postalCode);



        
    }

  
    }