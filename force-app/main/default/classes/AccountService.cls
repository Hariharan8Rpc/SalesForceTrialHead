public with sharing class AccountService {
    public Account createAccount( String accountName, String accountNumber, String tickerSymbol ) {
      Account newAcct = new Account(
        Name = accountName,
        AccountNumber = accountNumber,
        TickerSymbol = tickerSymbol
          
    //    System.debug('sYMBOL'+TicketSymbol);
      );
      return newAcct;
    }
  }
