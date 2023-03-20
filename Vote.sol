// SPDX-License-Identifier: Unlicensed
pragma solidity ^0.8.10;

contract cityPoll {
    struct City {
        string cityName;
        uint256 vote;
        //you can add city details if you want
    }

    mapping(uint256 => City) public cities; //mapping city Id with the City ctruct - cityId should be uint256
    mapping(address => bool) hasVoted; //mapping to check if the address/account has voted or not

    address owner;
    uint256 public cityCount = 0; // number of city added
    event CityAdded(uint256 cityId, string name);
    event CityVoted(uint256 cityId, string name, address voterAddress);

    constructor() {
        owner = msg.sender;

        //TODO set contract caller as owner
        //TODO set some intitial cities.
    }

    modifier onlyOwner(address _owner) {
        require(owner == _owner, "Vote: Not allowed");
        _;
    }

    function addCity(string memory _name) public onlyOwner(msg.sender) {
        cityCount++;
        cities[cityCount] = City({cityName: _name, vote: 0});
        emit CityAdded(cityCount, _name);
        //  TODO: add city to the CityStruct
    }

    function voteCity(uint256 _cityId) public {
        require(hasVoted[msg.sender] == false, "Vote: Already Voted");
        cities[_cityId].vote++;
        hasVoted[msg.sender] = true;
        emit CityVoted(_cityId, cities[_cityId].cityName, msg.sender);
        //TODO Vote the selected city through cityID
    }

    function getCity(uint256 _cityId) public view returns (string memory) {
        return cities[_cityId].cityName;
        // TODO get the city details through cityID
    }

    function getVote(uint256 _cityId) public view returns (uint256) {
        return cities[_cityId].vote;
        // TODO get the vote of the city with its ID
    }
}
