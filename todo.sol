//SPDX-License-Identifier:MIT
pragma solidity ^0.8.10;

contract Todo {
    address owner;
    /*
    Create struct called task 
    The struct has 3 fields : id,title,Completed
    Choose the appropriate variable type for each field.

    */
    struct task {
        uint256 id;
        string title;
        bool Completed;
    }

    ///Create a counter to keep track of added tasks
    uint256 counter;
    /*
    create a mapping that maps the counter created above with the struct taskcount
    key should of type integer
    */
    mapping(uint256 => task) public tasks;

    /*
    Define a constructor
    the constructor takes no arguments
    Set the owner to the creator of the contract
    Set the counter to  zero
    */
    constructor() {
        owner = msg.sender;
        counter = 0;
    }

    /*

    Define 2 events
    taskadded should provide information about the title of the task and the id of the task
    taskcompleted should provide information about task status and the id of the task
    */
    event TaskAdded(string title, uint256 taskId);
    event TaskCompleted(bool status, uint256 taskId);

    /*
        Create a modifier that throws an error if the msg.sender is not the owner.
    */
    modifier onlyOwner(address _owner) {
        require(owner == _owner, "ToDo: Not Allowed.");
        _;
    }

    /*
    Define a function called addTask()
    This function allows anyone to add task
    This function takes one argument , title of the task
    Be sure to check :
    taskadded event is emitted
     */
    function addTask(string memory _title) public returns (bool) {
        emit TaskAdded(_title, counter);
        tasks[counter] = task({id: counter, title: _title, Completed: false});
        counter = counter + 1;
        return true;
    }

    /*Define a function  to get total number of task added in this contract*/
    function totalTask() public view returns (uint256) {
        return counter;
    }

    /**
    Define a function gettask()
    This function takes 1 argument ,task id and 
    returns the task name ,task id and status of the task
     */
    function gettask(
        uint256 _taskId
    ) public view returns (string memory, uint256, bool) {
        require(_taskId < counter && _taskId >= 0, "ToDo: Invalid Task Id");
        return (tasks[_taskId].title, _taskId, tasks[_taskId].Completed);
    }

    /**Define a function marktaskcompleted()
    This function takes 1 argument , task id and 
    set the status of the task to completed 
    Be sure to check:
    taskcompleted event is emitted
     */
    function marktaskcompleted(uint256 _taskId) public onlyOwner(msg.sender) {
        tasks[_taskId].Completed = true;
        emit TaskCompleted(tasks[_taskId].Completed, _taskId);
    }
}
