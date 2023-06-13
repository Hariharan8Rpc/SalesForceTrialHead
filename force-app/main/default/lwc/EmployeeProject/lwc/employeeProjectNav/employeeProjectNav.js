import { LightningElement,track } from 'lwc';
import { NavigationMixin } from 'lightning/navigation';
export default class EmployeeProjectNav extends NavigationMixin(LightningElement){

      showEmployeeList() {
        value='employeeList';
        const valueChangeEvent = new CustomEvent('valuechange', { detail: value });
        console.log("employeelist+++ "+valueChangeEvent);
        this.dispatchEvent(valueChangeEvent);
      }
      showProjectList() {
        value='projectList';
        const valueChangeEvent = new CustomEvent('valuechange', { detail: value });
        console.log("projectList +++ "+valueChangeEvent);
        this.dispatchEvent(valueChangeEvent);
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