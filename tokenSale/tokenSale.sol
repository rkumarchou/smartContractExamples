
// To specify what version of compiler this code will compile with
pragma solidity ^0.4.11;



contract tokensale {

  // Declaring the maximum number of tokens available for sale.
  uint public maxTokens = 10000;

  // The number of tokens you can buy for one wei (Solidity converts all unitless values from ethers to wei).
  // We will keep the default currency to be wei. It will get clearer.
  uint public tokenSwap = 10;

  // The number of tokens that have already been sold.
  uint public _supply;

  // mapping is an equivalent to associative array. Here we store balances corresponding
  // to each address that buys tokens.
  mapping (address => uint) _balance;


  // A modifer to check if there are tokens available before the buyTokens function
  // is called.
  modifier isTokenAvailable () {
    require (msg.value*tokenSwap + _supply <= maxTokens);   // require checks the condition and the function that follows,
    _;                                                      // denoted by the '_', is only run if the condition is satisfied.
  }


  // A function to check the ether balance of any address.
  function checkBalance (address _addr) external returns (uint) {
    return _addr.balance;
  }


  // To check the token balance of any address.
  function balanceOf (address _tokenHolder) constant returns (uint) {
    return _balance[_tokenHolder];
  }


  // A function to buy tokens accesible by any address after the ownner starts
  // the token sale. The payable keyword allows the contract to accept ethers
  // from the transactor. The ethers to be deposited is entered as msg.value
  // (which will get clearer when we will call the functions in browser-solidity)
  // and the corresponding tokens are storedt in _balance[msg.sender] mapping.
  // underflows and overflows are checked in the process.
  function buyTokens ()
  payable
  isTokenAvailable {
    uint tokensAmount = msg.value * tokenSwap;    // At this point, msg.value is converted to wei.
    _balance [msg.sender] += tokensAmount;
    _supply += tokensAmount;
  }
}
