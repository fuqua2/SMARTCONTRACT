/**********************************************************************
*These solidity codes have been obtained from Etherscan for extracting
*the smartcontract related info.
*The data will be used by MATRIX AI team as the reference basis for
*MATRIX model analysis,extraction of contract semantics,
*as well as AI based data analysis, etc.
**********************************************************************/
contract BountyEscrow {

  address public admin;

  function BountyEscrow() {
    admin = msg.sender;
  }


  event Bounty(
    address indexed sender,
    uint256 amount
  );

  event Payout(
    address indexed sender,
    address indexed recipient,
    uint256 indexed sequenceNum,
    uint256 amount,
    bool success
  );

  // transfer deposits funds to recipients
  // Gas used in each `send` will be default stipend, 2300
  function payout(address[] recipients, uint256[] amounts) {
    require(admin == msg.sender);
    require(recipients.length == amounts.length);
    for (uint i = 0; i < recipients.length; i++) {
      Payout(
        msg.sender,
        recipients[i],
        i + 1,
        amounts[i],
        recipients[i].send(amounts[i])
      );
    }
  }

  // Use default `send` to receive bounty deposits.
  // Add a log to the tx receipt so we can track.
  function () payable {
    Bounty(msg.sender, msg.value);
  }
}