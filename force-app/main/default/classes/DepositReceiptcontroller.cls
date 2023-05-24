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
    
    
    public  DepositReceiptcontroller(){
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
    }
}