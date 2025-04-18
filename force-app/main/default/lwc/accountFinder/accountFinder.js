import { LightningElement,wire,api } from 'lwc';
import queryAccountsByRevenue from '@salesforce/apex/AccountListControllerLwc.queryAccountsByRevenue';

export default class AccountFinder extends LightningElement {
    @api annualRevenue=null;
    handleChange(event){
    this.annualRevenue=event.detail.value;
  }

  @wire(queryAccountsByRevenue,{annualRevenue:'$annualRevenue'})
  accounts;
  reset(){
    this.annualRevenue=null;
  }

}