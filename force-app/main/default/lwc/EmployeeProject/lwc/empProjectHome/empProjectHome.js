import { LightningElement,track } from 'lwc';
	
import { NavigationMixin } from 'lightning/navigation';

export default class EmpProjectHome extends LightningElement {
    @track enableComponent;

    @track showEmployeeListPage=false;
    @track showProjectListPage=false;
    @track message;

  //   handleChildEvent(event) {
  //     const message = event.detail.message;
  //     this.message=message;
  //     console.log('Received message from child component: ' + message);
  //     // Process the event data or trigger actions as needed
  // }


  handleCompChange(event) {
      const message=event.detail.message;
      this.enableComponent=message;
      this.message=message;
      console.log('in parent  '+message +'vgbhnjhbgvfcd'+this.enableComponent);
      this.selectOption();   
    }

    selectOption() {
        switch (this.enableComponent) {
          case 'employeeList':
            console.log("in parent switch  "+this.enableComponent);
            this.showEmployeeListPage=true;
            this.showProjectListPage=false;
            break;
          case 'projectList':
            this.showEmployeeListPage=false;
            this.showProjectListPage=true;
            break;
          default:
            this.showEmployeeListPage=false;
            this.showProjectListPage=false;
            break;
        }
      }

}