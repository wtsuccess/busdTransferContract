/**
 *Submitted for verification at BscScan.com on 2022-01-09
*/

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";


abstract contract Context {
    function _msgSender() internal view virtual returns (address) {
        return msg.sender;
    }

    function _msgData() internal view virtual returns (bytes calldata) {
        this; // silence state mutability warning without generating bytecode - see https://github.com/ethereum/solidity/issues/2691
        return msg.data;
    }
}

abstract contract Ownable is Context {
    address private _owner;

    event OwnershipTransferred(address indexed previousOwner, address indexed newOwner);

    /**
     * @dev Initializes the contract setting the deployer as the initial owner.
     */
    constructor () {
        address msgSender = _msgSender();
        _owner = msgSender;
        emit OwnershipTransferred(address(0), msgSender);
    }

    /**
     * @dev Returns the address of the current owner.
     */
    function owner() public view virtual returns (address) {
        return _owner;
    }

    /**
     * @dev Throws if called by any account other than the owner.
     */
    modifier onlyOwner() {
        require(owner() == _msgSender(), "Ownable: caller is not the owner");
        _;
    }

    /**
     * @dev Leaves the contract without owner. It will not be possible to call
     * `onlyOwner` functions anymore. Can only be called by the current owner.
     *
     * NOTE: Renouncing ownership will leave the contract without an owner,
     * thereby removing any functionality that is only available to the owner.
     */
    function renounceOwnership() public virtual onlyOwner {
        emit OwnershipTransferred(_owner, address(0));
        _owner = address(0);
    }

    /**
     * @dev Transfers ownership of the contract to a new account (`newOwner`).
     * Can only be called by the current owner.
     */
    function transferOwnership(address newOwner) public virtual onlyOwner {
        require(newOwner != address(0), "Ownable: new owner is the zero address");
        emit OwnershipTransferred(_owner, newOwner);
        _owner = newOwner;
    }
}

contract BUSDHandler is Ownable {
    IERC20 private busd;
     
    event Transfer(address receiver,uint256 amount); 

    constructor(address _busd) public {
        busd = IERC20(_busd) ;
    }

    function deposit(address _receiver, uint256 _amount) external {
        require(_amount > 0, "BUSD should be larger than 0");
        require(busd.balanceOf(msg.sender) >= _amount, "Insufficient BUSD balance");
        busd.transferFrom(msg.sender, address(this), _amount);
        transfer2wallet(_receiver, _amount); 
    }

    function transfer2wallet(address _receiver, uint256 _amount) internal {
        require(_amount > 0, "BUSD should be larger than 0");
        require(busd.balanceOf(address(this)) >= _amount, "Insufficient BUSD balance");
        busd.transfer(_receiver, _amount);
        emit Transfer(_receiver, _amount);
    }
}