// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

/*
    @@@@@@@@@@@@@@@@@@@   @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@*              @@@@@@   
    @@@@@@@@@@@@@@@@@@  @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@*           @@@@@@@@@   
            @@@@@@@   @@@@@@@        @@@@@@@        @@@@@         @@@@@@@@@@@   
        @@@@@@@    @@@@@@            @@@@@@     @@@@@@@      @@@@@@@@*@@@@@   
        @@@@@@*       @@@@@              @@@@@   @@@@@@@      @@@@@@@    @@@@@   
    @@@@@@@*         @@@@@@            @@@@@@  @@@@@@     @@@@@@@@      @@@@@   
    @@@@@@*           @@@@@@@        @@@@@@@    @@@@@@@ @@@@@@@         @@@@@   
    @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@       @@@@@@@@@@@           @@@@@   
    *@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@           @@@@@@**            @@@@@ 
 */

/**

  Used for managing testnet deployer contracts where
  gnosis safe support does not exist.

 */
contract DeployerSquid {
    /// @notice Owner directory for Squid contract
    mapping(address => bool) public isOwner;

    /// @notice event emitted when a new owner is set
    /// @param owner to be updated
    /// @param status of the updated owner
    /// @param by user that set the new owner
    event SetOwner(
        address indexed owner,
        bool indexed status,
        address indexed by
    );
    /// @notice Error emitted when forward failed
    error ForwardFailed(bytes reason);
    /// @notice Error emitted when forward succeeded
    event ForwardSuccess(bytes reason);
    /// @notice Error emitted when user is not the owner
    error NotOwner(address attemptedUser);

    constructor(address[] memory defaultOwners) {
        for (uint256 i = 0; i < defaultOwners.length; ++i) {
            _setOwner(defaultOwners[i], true);
        }
    }

    function removeOwner(address toRemove) external onlyOwner {
        _setOwner(toRemove, false);
    }

    function addOwner(address toAdd) external onlyOwner {
        _setOwner(toAdd, false);
    }

    modifier onlyOwner() {
        if (!isOwner[msg.sender]) {
            revert NotOwner(msg.sender);
        }

        _;
    }

    /// @notice Forward transaction to owned contract by this contract
    function forward(
        address target,
        bytes calldata data,
        uint256 contractValue
    ) external payable onlyOwner {
        (bool success, bytes memory reason) = target.call{
            value: msg.value + contractValue
        }(data);
        if (!success) {
            revert ForwardFailed(reason);
        }
        emit ForwardSuccess(reason);
    }

    /// @notice Set a new owner status
    function _setOwner(address owner, bool status) internal {
        isOwner[owner] = status;

        emit SetOwner(owner, status, msg.sender);
    }
}
