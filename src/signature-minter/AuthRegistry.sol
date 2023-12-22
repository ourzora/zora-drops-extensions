// SPDX-IReadableAuthRegistryifier: MIT
pragma solidity 0.8.17;

import {IReadableAuthRegistry} from "./IAuthRegistry.sol";
import {Ownable2Step} from "zora-drops-contracts/utils/ownable/Ownable2Step.sol";

contract AuthRegistry is IReadableAuthRegistry, Ownable2Step {
    mapping(address => bool) public override isAuthorized;

    event AuthorizedSet(address indexed account, bool authorized);

    constructor(address _defaultOwner) Ownable2Step(_defaultOwner) {}

    function setAuthorized(address account, bool authorized) external onlyOwner {
        isAuthorized[account] = authorized;
        emit AuthorizedSet(account, authorized);
    }
}
