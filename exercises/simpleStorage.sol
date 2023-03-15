pragma solidity >=0.7.0 <0.9.0;

contract simpleStorage{

    uint storeData;

    // set data func
    function set(uint i) public{
        storeData = i;
    }


    // get data func
    function set() public view returns(uint){
        return storeData;
    }

}