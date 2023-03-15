pragma solidity >=0.7.0 <0.9.0;


contract Ballot{
    // proposal
    struct Proposal{
        bytes32 name;
        uint voteCount;
    }

    struct Voter{
        bool voted;
        uint vote;
        uint weight;
    }

    Proposal[] public proposals;

    mapping(address => Voter) public voters;

    address public chairperson;

    constructor(bytes32[] memory proposalNames) {

        chairperson = msg.sender;
        voters[chairperson].weight = 1;

        for(uint i=0; i<proposalNames.length; i++){
            proposals.push(Proposal({
                name: proposalNames[i],
                voteCount: 0
            }));
        }
    }


    // func to authenticate voter
    function giveRightToVote(address voter) public{
        require(msg.sender == chairperson, "Only the chairperson can give access to vote");
        require(!voters[voter].voted, "The voter has already voted");
        require(voters[voter].weight == 0);

        voters[voter].weight = 1;
    }

    // func to vote
    function vote(uint proposal) public{
        Voter storage sender = voters[msg.sender];
        require(sender.weight !=0, "Voter does'nt have the right to vote");
        require(!sender.voted, "Voter already voted");

        sender.voted = true;
        sender.vote = proposal;

        proposals[proposal].voteCount = proposals[proposal].voteCount + sender.weight;
    }

    // func to show results
    // 1. winning proposal by interger
    function winningProposal() public view returns(uint winningProposal_){
        uint winningVoteCount = 0;
        for(uint i=0; i<proposals.length; i++){
            if(proposals[i].voteCount > winningVoteCount){
                winningVoteCount = proposals[i].voteCount;
                winningProposal_ = i;
            }
        }
    }

    // 2. winning proposal by Name
    function winningName() public view returns(bytes32 winningName_){
        winningName_ = proposals[winningProposal()].name;
    }
}