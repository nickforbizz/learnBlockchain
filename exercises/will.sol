pragma solidity >=0.7.0 <0.9.0;

contract Will{
    address owner;
    uint fortune;
    bool deceased;

    constructor() payable public{
        owner =msg.sender;
        fortune = msg.value;
        deceased = false;
    }


    modifier onlyOwner{
        require(msg.sender == owner);
        _;
    }

    modifier mustBeDeceased{
        require(deceased == true);
        _;
    }

    address payable[] familyWallets;

    mapping(address => uint) inheritance;

    function setInheritance(address payable wallet, uint amt) public {
        familyWallets.push(wallet);
        inheritance[wallet] = amt;
    }

    function payout() private mustBeDeceased {
        for (uint256 index = 0; index < familyWallets.length; index++) {
            familyWallets[index].transfer(inheritance[familyWallets[index]]);
        }
    }

    function hasDeceased() public onlyOwner {
        deceased = true;
        payout();
    }
}