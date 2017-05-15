pragma solidity ^0.4.11;

contract Nick {

//stores nicknames
  mapping (bytes32 => address) public nickname;
//stores information if address already has a nickname
  mapping (address => bool) public hasnick;

//return value for UI, because storeNick and deleteNick don't return values (?)
  string returnValue;

//check if Nickname can be stored, if conditions are met, store Nickname
  function storeNick(bytes32 nick) {
    if (nickname[nick] == 0) {
      if (hasnick[msg.sender] == false) {
        nickname[nick]=msg.sender;
        hasnick[msg.sender]=true;
        returnValue="success";
      } else {
        returnValue="has_nick";
      }
    } else {
      returnValue="nick_occupied";
    }
  }

//check if Nickname can be deleted, if conditions are met, delete Nickname
  function deleteNick(bytes32 nick) {
    if (nickname[nick] != msg.sender) {
      if (nickname[nick] == 0) {
        returnValue="nick_vacant";
      } else {
        returnValue="auth_error";
      }
    } else {
      nickname[nick]=0;
      hasnick[msg.sender]=false;
      returnValue="success";
    }
  }

//Function to get address from a Nickname
  function checkNick(bytes32 nick) constant returns (address) {
    return nickname[nick];
  }

  function getReturnValue() constant returns (string) {
    return returnValue;
  }
}