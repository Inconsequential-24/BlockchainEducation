// SPDX-License-Identifier: MIT 
// StudentRecordContract.sol
pragma solidity ^0.8.0;

contract StudentRecordContract {
    // Struct to store student records
    struct StudentRecord {
        string name;
        uint256 examResult;
        string certification;
        uint256 rollNumber;
        string phoneNumber;
        string studaddress;
        string course;
    }

    // Mapping to store student records by address
    mapping(address => StudentRecord) public studentRecords;

    // Event emitted when a new student record is added
    event StudentRecordAdded(
        address indexed studentAddress,
        string name,
        uint256 examResult,
        string certification,
        uint256 rollNumber,
        string phoneNumber,
        string studaddress,
        string course
    );

    // Function to add a student record
    function addStudentRecord(
        string memory _name,
        uint256 _examResult,
        string memory _certification,
        uint256 _rollNumber,
        string memory _phoneNumber,
        string memory _studaddress,
        string memory _course
    ) public {
        // Store the student record in the mapping
        studentRecords[msg.sender] = StudentRecord(
            _name,
            _examResult,
            _certification,
            _rollNumber,
            _phoneNumber,
            _studaddress,
            _course
        );

        // Emit the event
        emit StudentRecordAdded(
            msg.sender,
            _name,
            _examResult,
            _certification,
            _rollNumber,
            _phoneNumber,
            _studaddress,
            _course
        );
    }

    // Function to get a student record by address
    function getStudentRecord(address _studentAddress)
        public
        view
        returns (
            string memory,
            uint256,
            string memory,
            uint256,
            string memory,
            string memory,
            string memory
        )
    {
        StudentRecord memory record = studentRecords[_studentAddress];
        return (
            record.name,
            record.examResult,
            record.certification,
            record.rollNumber,
            record.phoneNumber,
            record.studaddress,
            record.course
        );
    }
}
