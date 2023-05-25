public class DepositReceiptcontroller {
    public boolean fixedInterestCheckbox {get;set;}     
    public boolean AdditionPermittedCheckbox{get;set;}
    public boolean variableIntrestCheckedbox{get;set;}
    public boolean automaticallyRenewableCheckedbox{get;set;}
    public boolean singleMaturityCheckedbox{get;set;}
    public boolean callableCheckedbox{get;set;}
    public boolean noticeAccountCheckedbox{get;set;}
    public boolean mailCheckedbox{get;set;}
    public boolean principalCheckedbox{get;set;}
    public boolean paidtoCheckedbox{get;set;}
    public AccountDetail  accDetail{get;set;}
    public List<AccountDetail> accList{get;set;}
    class AccountDetail{
        public Integer accountNumber { get; set; }
        public Integer jraNumber { get; set; }
        public Integer amount { get; set; }
        public String dateOpened { get; set; }
        public Integer term { get; set; }
        public String maturityDate { get; set; }
        public Integer interestRate { get; set; }
        public Integer percentageYield { get; set; }
        public String Address { get; set; }
    }
    
    public  DepositReceiptcontroller(){
        depositReciptDetail();
    }
    
    public void depositReciptDetail(){
        fixedInterestCheckbox=false;   
        AdditionPermittedCheckbox=true;
        variableIntrestCheckedbox=true;
        automaticallyRenewableCheckedbox=true;
        singleMaturityCheckedbox=true;    
        callableCheckedbox=true;
        noticeAccountCheckedbox=false;
        mailCheckedbox=true;
        principalCheckedbox=true;
        paidtoCheckedbox=true;
        list<AccountDetail>acclist1= new list<AccountDetail>();
        for(Integer i=0;i<1;i++){
            AccountDetail account = new AccountDetail();
            account.accountNumber = 12345+i;
            account.jraNumber = 56789;
            account.amount = 1000;
        	Date date1=Date.today();
            account.dateOpened = date1.format();
            account.term = 12;
        	Date date2=Date.today().addMonths(12);
            account.maturityDate = date2.format();
            account.interestRate = 5;
            account.percentageYield = 2;
            account.Address = '123 Main St,Boyce-Codd Normal Form (BCNF), Fourth Normal Form (4NF), ';
            acclist1.add(account);           
            System.debug('account detail'+account);
        }
        System.debug('list  '+acclist1);
        acclist=acclist1;
}
}