import { LightningElement,track,api } from 'lwc';
import { NavigationMixin } from 'lightning/navigation';
export default class EmployeeProjectNav extends LightningElement{
  @api
  sendEventToParent() {
      const event = new CustomEvent('myevent', {
          detail: {
              message: 'Hello from child component!'
          }
      });
      this.dispatchEvent(event);
  }
   
  @api
  showEmployeeList() {
   const value='employeeList';
    const event = new CustomEvent('showemployeelist', {
      detail: {
          message:value
      }
  });
  this.dispatchEvent(event);
  }
  
  @api
  showProjectList() {
   const value='projectList';
    const event = new CustomEvent('showprojectlist', {
      detail: {
          message:value
      }
  });
  this.dispatchEvent(event);
  }


    // navigateToHome() {
    //     this[NavigationMixin.Navigate]({
    //       type: 'standard__namedPage',
    //       attributes: {
    //         pageName: 'c__EmpProjectHome'
    //       }
    //     });
    // }
    // navigateToEmployeeList() {
    //     this[NavigationMixin.Navigate]({
    //       type: 'standard__namedPage',
    //       attributes: {
    //         componentName: 'c__EmployeeList'
    //       }
    //     });
    // }
    // navToListComponent() {
    //     this[NavigationMixin.Navigate]({
    //         type: 'standard__webPage',
    //         attributes: {
    //          //   componentName: 'c__EmpProjectHome'
    //          url: '/c/c__EmployeeList'
    //         }
    //         // c__EmpProjectHome
    //     });
    // }   navToEmpHomeComponent
    
    // navToEmpListComponent() {
    //     const pageReference = {
    //         type: 'standard__component',
    //         attributes: {
    //             componentName: 'c__EmployeeList' // Replace with the actual name of the target component
    //         },
    //     };
    //     const navigationItem = NavigationMixin(pageReference);
    //     this.dispatchEvent(new CustomEvent('navigate', { detail: navigationItem }));
    // }
    




}