public class AddPrimaryContact implements Queueable {
	private Contact con;
    private String abbr;
    
   public AddPrimaryContact(Contact records,String abbr1){
		this.con= records;
        this.abbr=abbr1;
    }
        public void execute(QueueableContext context) {
        List<Account> accounts = [select name from account where billingstate=:abbr LIMIT 200];
        List<Contact> contacts = new List<Contact>();
        for (Account acc : accounts) {
           contact con1=con.clone(false,false,false,false);
           contacts.add(con);
        }
        insert contacts;
}    
}