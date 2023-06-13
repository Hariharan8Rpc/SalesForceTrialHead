import { LightningElement } from 'lwc';
import { NavigationMixin } from 'lightning/navigation';
export default class EmployeeProjectNav extends NavigationMixin(LightningElement){
    navigateToHome() {
        this[NavigationMixin.Navigate]({
          type: 'standard__namedPage',
          attributes: {
            pageName: 'c__EmpProjectHome'
          }
        });
    }

    navigateToEmployeeList() {
        this[NavigationMixin.Navigate]({
          type: 'standard__namedPage',
          attributes: {
            componentName: 'c__EmployeeList'
          }
        });
    }


    EmployeeList

    navToHomeComponent() {
        this[NavigationMixin.Navigate]({
            type: 'standard__component',
            attributes: {
                componentName: 'c__EmpProjectHome'
            }
            // c__EmpProjectHome
        });
    }   navToEmpListComponent
    
    navToEmpListComponent() {
        const pageReference = {
            type: 'standard__component',
            attributes: {
                componentName: 'c__EmployeeList' // Replace with the actual name of the target component
            },
        };
        const navigationItem = NavigationMixin(pageReference);
        this.dispatchEvent(new CustomEvent('navigate', { detail: navigationItem }));
    }
    




}