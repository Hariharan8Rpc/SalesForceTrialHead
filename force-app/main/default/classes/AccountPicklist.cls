public class AccountPicklist {  
    String message='Contact Added Successfully';      
    Public Id selectedAccId{get;set;} 
    Public List<Contact> Conlist{get;set;} 
    public Integer countTotalRecords{get;set;}
    public Integer offSetSize = 0;
    public Integer QueryLimit = 10;
    
    Public List<SelectOption> getAccountNames() {
        System.debug('inside class');
        List<SelectOption> accOptions= new List<SelectOption>();
        system.debug(selectedAccId);
        accOptions.add( new SelectOption('','--Select--'));
        for(Account acc : [select Id,name from Account ] ) {
            accOptions.add(new SelectOption(acc.Id,acc.name));
        }
        return accOptions;
    }
    
    public void refreshContactList(){
        System.debug('in fetch');
        Conlist = new List<Contact>();
        Conlist = [select name,phone,accountId from Contact where Accountid=: selectedAccId ORDER BY Name LIMIT :QueryLimit OFFSET :offSetSize];
    }
    
    //Pagination
    //Constructor
    public AccountPicklist(){
        Conlist = new List<Contact>();
        countTotalRecords = [SELECT count() FROM Contact  where Accountid=: selectedAccId ];
    }    
    
    public boolean getprv(){
        if(offSetSize > 0)
            return false;
        else
            return true;
    }
    
    public boolean getnxt(){
        if(offSetSize + queryLimit < CountTotalRecords)          
            return false;
        else          
            return true;
    }
    
    public PageReference nextbtn(){
        offSetSize += queryLimit ;
        refreshContactList();
        return null;
    }
    
    public PageReference prvbtn(){
        offSetSize -= queryLimit ;
        refreshContactList();
        return null;
    }
    
    public PageReference fstbtn(){
        offSetSize = 0;
        refreshContactList();
        return null;
    }
    
    public PageReference endbtn(){
        offSetSize = countTotalRecords - math.mod(countTotalRecords,queryLimit);
        refreshContactList();
        return null;
    }
    
    //PAginate end
    public void AddContact(){
        System.debug('in  add method' );
        List<Contact> conlist= new List<Contact>();
        for(Integer i=1; i<5; i++)
        {
            Contact con=new Contact(FirstName='test22'+i,LastName='contact'+i ,AccountId=selectedAccId );
            conlist.add(con);
        }
        Database.insert(conlist);
    }
}