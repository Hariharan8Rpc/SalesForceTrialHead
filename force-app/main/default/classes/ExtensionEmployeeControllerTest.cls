@isTest
private class ExtensionEmployeeControllerTest {
    @isTest
    static void testExtensionEmployeeController() {
        // Create test data
        Employee__c employee = new Employee__c(Name = 'Test Employee');
        insert employee;

        Project__c project = new Project__c(Name = 'Test Project');
        insert project;

        EmployeeProject__c empProject = new EmployeeProject__c(
            Employee__c = employee.Id,
            Project__c = project.Id
        );
        insert empProject;

        ExtensionEmployeeController controller = new ExtensionEmployeeController();
        controller.EmployeeSearchId = employee.Id;
        controller.editId = employee.Id;

        // Test getEmployees()
        Test.startTest();
        controller.getEmployees();
        Test.stopTest();
        System.assert(!controller.empProject.isEmpty());

        // Test GetEmployeesproject()
        List<Project__c> projects = controller.GetEmployeesproject(employee.Id);
        System.assertEquals(1, projects.size());

        // Test getProjectsRelatedToEmployee()
        Test.startTest();
        controller.getProjectsRelatedToEmployee();
        Test.stopTest();
        System.assert(controller.flag);
        System.assertNotEquals(null, controller.SingleEmplist);
        System.assertNotEquals(null, controller.SingleEmplist.employee);
        System.assertNotEquals(null, controller.SingleEmplist.addr);
        System.assertNotEquals(null, controller.SingleEmplist.projects);

        // Test GetAllProjects()
        Test.startTest();
        controller.GetAllProjects();
        Test.stopTest();
        System.assertNotEquals(null, controller.projectsList);

        // Test getEmployeesRelatedToProject()
        Test.startTest();
        controller.getEmployeesRelatedToProject();
        Test.stopTest();
        System.assert(controller.flag1);
        System.assertNotEquals(null, controller.empInProject);

        // Test redirectToEditPage()
        Test.startTest();
        PageReference editPage = controller.redirectToEditPage();
        Test.stopTest();
        System.assert(editPage.getUrl().contains(employee.Id));

        // Test deleteRecords()
        Test.startTest();
        PageReference empPage = controller.deleteRecords();
        Test.stopTest();
        System.assert(empPage.getUrl().contains('EmployeesPage'));
    }

    @isTest
    static void testGetProjectsRelatedToEmployee() {
        // Create test data
        Employee__c employee = new Employee__c(Name = 'Test Employee');
        insert employee;

        Project__c project = new Project__c(Name = 'Test Project');
        insert project;

        EmployeeProject__c empProject = new EmployeeProject__c(
            Employee__c = employee.Id,
            Project__c = project.Id
        );
        insert empProject;

        ExtensionEmployeeController controller = new ExtensionEmployeeController();
        controller.EmployeeSearchId = employee.Id;

        // Test getProjectsRelatedToEmployee()
        Test.startTest();
        controller.getProjectsRelatedToEmployee();
        Test.stopTest();

        System.assert(controller.flag);
        System.assertNotEquals(null, controller.SingleEmplist);
        System.assertNotEquals(null, controller.SingleEmplist.employee);
        System.assertNotEquals(null, controller.SingleEmplist.addr);
        System.assertNotEquals(null, controller.SingleEmplist.projects);
    }

    @isTest
    static void testGetEmployeesRelatedToProject() {
        // Create test data
        Employee__c employee = new Employee__c(Name = 'Test Employee');
        insert employee;

        Project__c project = new Project__c(Name = 'Test Project');
        insert project;

        EmployeeProject__c empProject = new EmployeeProject__c(
            Employee__c = employee.Id,
            Project__c = project.Id
        );
        insert empProject;

        ExtensionEmployeeController controller = new ExtensionEmployeeController();
        controller.EmployeeSearchId = project.Id;

        // Test getEmployeesRelatedToProject()
        Test.startTest();
        controller.getEmployeesRelatedToProject();
        Test.stopTest();

        System.assert(controller.flag1);
        System.assertNotEquals(null, controller.empInProject);
    }

    // Include the other test methods from the previous version of the test class
     @isTest
    static void testDeleteRecordsWithNoAddress() {
        Employee__c employee = new Employee__c(Name = 'Test Employee');
        insert employee;

        ExtensionEmployeeController controller = new ExtensionEmployeeController();
        controller.EmployeeSearchId = employee.Id;

        Test.startTest();
        PageReference empPage = controller.deleteRecords();
        Test.stopTest();
        // Add assertions for the expected behavior when there is no address associated with the employee
    }
    
        @isTest
    static void testConstructor() {
        Test.startTest();
        ExtensionEmployeeController controller = new ExtensionEmployeeController();
        Test.stopTest();
        // Add assertions for the expected behavior of the constructor
    }

    @isTest
    static void testRedirectToEditPageWithNullEditId() {
        ExtensionEmployeeController controller = new ExtensionEmployeeController();
        Test.startTest();
        controller.editId = null;
        PageReference editPage = controller.redirectToEditPage();
        Test.stopTest();
        // Add assertions for the expected behavior when editId is null
    }
}