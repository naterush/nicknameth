pragma solidity ^0.4.11;

contract Nick {

//stores nicknames
  mapping (bytes32 => address) public nickname;
//stores information if address already has a nickname
  mapping (address => bool) public hasnick;
  
//allows web3 to watch for events  
  event RegisterEvent(string outcome);

//check if Nickname can be stored, if conditions are met, store Nickname
  function storeNick(bytes32 nick) {
    if (nickname[nick] == 0) {
      if (hasnick[msg.sender] == false) {
        nickname[nick]=msg.sender;
        hasnick[msg.sender]=true;
        RegisterEvent("success");
      } else {
        RegisterEvent("has_nick");
      }
    } else {
      RegisterEvent("nick_occupied");
    }
  }

//check if Nickname can be deleted, if conditions are met, delete Nickname
  function deleteNick(bytes32 nick) {
    if (nickname[nick] != msg.sender) {
      if (nickname[nick] == 0) {
        RegisterEvent("nick_vacant");
      } else {
        RegisterEvent("auth_error");
      }
    } else {
      nickname[nick]=0;
      hasnick[msg.sender]=false;
      RegisterEvent("success");
    }
  }

//Function to get address from a Nickname
  function checkNick(bytes32 nick) constant returns (address) {
    return nickname[nick];
  }
}
