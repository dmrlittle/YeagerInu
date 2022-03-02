// SPDX-License-Identifier: Unlicensed

pragma solidity ^0.8.0;

interface IERC20 {
    
    function totalSupply() external view returns (uint256);
    function balanceOf(address account) external view returns (uint256);
    function transfer(address recipient, uint256 amount) external returns (bool);
    function allowance(address owner, address spender) external view returns (uint256);
    function approve(address spender, uint256 amount) external returns (bool);
    function transferFrom(
        address sender,
        address recipient,
        uint256 amount
    ) external returns (bool);

    event Transfer(address indexed from, address indexed to, uint256 value);
    event Approval(address indexed owner, address indexed spender, uint256 value);
}

interface IERC20Metadata is IERC20 {
   
    function name() external view returns (string memory);
    function symbol() external view returns (string memory);
    function decimals() external view returns (uint8);
}

abstract contract Context {
    function _msgSender() internal view virtual returns (address) {
        return msg.sender;
    }

    function _msgData() internal view virtual returns (bytes calldata) {
        return msg.data;
    }
}

abstract contract Ownable is Context {
    address private _owner;
    event OwnershipTransferred(address indexed previousOwner, address indexed newOwner);

    constructor() {
        _transferOwnership(_msgSender());
    }

    function owner() public view virtual returns (address) {
        return _owner;
    }

    modifier onlyOwner() {
        require(owner() == _msgSender(), "Ownable: caller is not the owner");
        _;
    }

    function renounceOwnership() public virtual onlyOwner {
        _transferOwnership(address(0));
    }

    function transferOwnership(address newOwner) public virtual onlyOwner {
        require(newOwner != address(0), "Ownable: new owner is the zero address");
        _transferOwnership(newOwner);
    }

    function _transferOwnership(address newOwner) internal virtual {
        address oldOwner = _owner;
        _owner = newOwner;
        emit OwnershipTransferred(oldOwner, newOwner);
    }
}

/*
interface IUniswapV2Factory {
    event PairCreated(address indexed token0, address indexed token1, address pair, uint);

    function feeTo() external view returns (address);
    function feeToSetter() external view returns (address);

    function getPair(address tokenA, address tokenB) external view returns (address pair);
    function allPairs(uint) external view returns (address pair);
    function allPairsLength() external view returns (uint);

    function createPair(address tokenA, address tokenB) external returns (address pair);

    function setFeeTo(address) external;
    function setFeeToSetter(address) external;
}

interface IUniswapV2Router01 {
    function factory() external pure returns (address);
    function WETH() external pure returns (address);

    function addLiquidity(
        address tokenA,
        address tokenB,
        uint amountADesired,
        uint amountBDesired,
        uint amountAMin,
        uint amountBMin,
        address to,
        uint deadline
    ) external returns (uint amountA, uint amountB, uint liquidity);
    function addLiquidityETH(
        address token,
        uint amountTokenDesired,
        uint amountTokenMin,
        uint amountETHMin,
        address to,
        uint deadline
    ) external payable returns (uint amountToken, uint amountETH, uint liquidity);
    function removeLiquidity(
        address tokenA,
        address tokenB,
        uint liquidity,
        uint amountAMin,
        uint amountBMin,
        address to,
        uint deadline
    ) external returns (uint amountA, uint amountB);
    function removeLiquidityETH(
        address token,
        uint liquidity,
        uint amountTokenMin,
        uint amountETHMin,
        address to,
        uint deadline
    ) external returns (uint amountToken, uint amountETH);
    function removeLiquidityWithPermit(
        address tokenA,
        address tokenB,
        uint liquidity,
        uint amountAMin,
        uint amountBMin,
        address to,
        uint deadline,
        bool approveMax, uint8 v, bytes32 r, bytes32 s
    ) external returns (uint amountA, uint amountB);
    function removeLiquidityETHWithPermit(
        address token,
        uint liquidity,
        uint amountTokenMin,
        uint amountETHMin,
        address to,
        uint deadline,
        bool approveMax, uint8 v, bytes32 r, bytes32 s
    ) external returns (uint amountToken, uint amountETH);
    function swapExactTokensForTokens(
        uint amountIn,
        uint amountOutMin,
        address[] calldata path,
        address to,
        uint deadline
    ) external returns (uint[] memory amounts);
    function swapTokensForExactTokens(
        uint amountOut,
        uint amountInMax,
        address[] calldata path,
        address to,
        uint deadline
    ) external returns (uint[] memory amounts);
    function swapExactETHForTokens(uint amountOutMin, address[] calldata path, address to, uint deadline)
        external
        payable
        returns (uint[] memory amounts);
    function swapTokensForExactETH(uint amountOut, uint amountInMax, address[] calldata path, address to, uint deadline)
        external
        returns (uint[] memory amounts);
    function swapExactTokensForETH(uint amountIn, uint amountOutMin, address[] calldata path, address to, uint deadline)
        external
        returns (uint[] memory amounts);
    function swapETHForExactTokens(uint amountOut, address[] calldata path, address to, uint deadline)
        external
        payable
        returns (uint[] memory amounts);

    function quote(uint amountA, uint reserveA, uint reserveB) external pure returns (uint amountB);
    function getAmountOut(uint amountIn, uint reserveIn, uint reserveOut) external pure returns (uint amountOut);
    function getAmountIn(uint amountOut, uint reserveIn, uint reserveOut) external pure returns (uint amountIn);
    function getAmountsOut(uint amountIn, address[] calldata path) external view returns (uint[] memory amounts);
    function getAmountsIn(uint amountOut, address[] calldata path) external view returns (uint[] memory amounts);
}

interface IUniswapV2Router02 is IUniswapV2Router01 {
    function removeLiquidityETHSupportingFeeOnTransferTokens(
        address token,
        uint liquidity,
        uint amountTokenMin,
        uint amountETHMin,
        address to,
        uint deadline
    ) external returns (uint amountETH);
    function removeLiquidityETHWithPermitSupportingFeeOnTransferTokens(
        address token,
        uint liquidity,
        uint amountTokenMin,
        uint amountETHMin,
        address to,
        uint deadline,
        bool approveMax, uint8 v, bytes32 r, bytes32 s
    ) external returns (uint amountETH);

    function swapExactTokensForTokensSupportingFeeOnTransferTokens(
        uint amountIn,
        uint amountOutMin,
        address[] calldata path,
        address to,
        uint deadline
    ) external;
    function swapExactETHForTokensSupportingFeeOnTransferTokens(
        uint amountOutMin,
        address[] calldata path,
        address to,
        uint deadline
    ) external payable;
    function swapExactTokensForETHSupportingFeeOnTransferTokens(
        uint amountIn,
        uint amountOutMin,
        address[] calldata path,
        address to,
        uint deadline
    ) external;
}
*/

interface IUniswapV2Factory {
    function createPair(address tokenA, address tokenB) external returns (address pair);
}

interface IUniswapV2Router02{
    function factory() external pure returns (address);
    function WETH() external pure returns (address);
    function swapExactTokensForETH(uint amountIn, uint amountOutMin, address[] calldata path, address to, uint deadline)
        external
        returns (uint[] memory amounts);
    function swapExactTokensForETHSupportingFeeOnTransferTokens(
        uint amountIn,
        uint amountOutMin,
        address[] calldata path,
        address to,
        uint deadline
    ) external;
    function addLiquidityETH(
        address token,
        uint amountTokenDesired,
        uint amountTokenMin,
        uint amountETHMin,
        address to,
        uint deadline
    ) external payable returns (uint amountToken, uint amountETH, uint liquidity);
}

contract YeagerInu is Context, IERC20Metadata, Ownable {
    
    struct governingTaxes{
        uint32 _totalTaxPercent;
        uint32 _split0;
        uint32 _split1;
        uint32 _split2;
        uint32 _split3;
        uint32 _split4;
        address payable _wallet1;
        address payable _wallet2;
        address payable _wallet3;
    }

    struct Fees {
        uint256 _fee0;
        uint256 _fee1;
        uint256 _fee2;
        uint256 _fee3;
        uint256 _fee4;
    }
    
    governingTaxes[] private _governingTaxes;
    governingTaxes private _localtax;
    
    mapping (address => uint256) private _rOwned;
    mapping (address => uint256) private _tOwned;
    mapping(address => mapping(address => uint256)) private _allowances;
    
    mapping (address => bool) private _isExcluded;
    address[] private _excluded;
    mapping (address => bool) private _isExcludedFromFee;
    mapping (address => bool) private _isLiquidityPool;

    mapping (address => bool) private _isBlacklisted;
    uint256 public _maxTxAmount;
    uint256 public _maxHoldAmount;

    bool private _tokenLock = true; //Locking the token until Liquidty is added
    uint256 public _tokenCommenceTime;

    uint256 private constant _startingSupply = 100_000_000_000_000_000; //100 Quadrillion
    
    uint256 private constant MAX = ~uint256(0);
    uint256 private constant _tTotal = _startingSupply * 10**9;
    uint256 private _rTotal = (MAX - (MAX % _tTotal));
    uint256 private _tFeeTotal;
    
    string private constant _name = "testing0";
    string private constant _symbol = "TEST0";
    uint8 private constant _decimals = 9;

    address public constant burnAddress = 0x000000000000000000000000000000000000dEaD; 
    
    IUniswapV2Router02 private uniswapV2Router;
    address public uniswapV2Pair;
    uint256 private _swapthreshold = 0;
    bool private swapEnabled = false;
    bool private inSwap = false;

    modifier lockTheSwap {
        inSwap = true;
        _;
        inSwap = false;
    }

    constructor (address wallet1_,  address wallet2_,  address wallet3_) {
        _rOwned[_msgSender()] = _rTotal;

        /*
            Total Tax Percentage per Transaction : 10%
            Tax Split:
                > Burn (burnAddress): 10%
                > Dev Wallet (wallet1): 10%
                > Dev Wallet (wallet2): 10% 
                > Marketing Wallet (wallet3): 50%
                > Holders (reflect): 16%
        */

        /*
            >>> First 24 hour Tax <<<

            > Buy <
            Total Tax Percentage per Transaction : 25%
            Tax Split:
                > Burn (burnAddress): 4%
                > Dev Wallet (wallet1): 20%
                > Dev Wallet (wallet2): 20% 
                > Marketing Wallet (wallet3): 40%
                > Holders (reflect): 16%

            > Sell <
            Total Tax Percentage per Transaction : 10%
            Tax Split:
                > Burn (burnAddress): 4%
                > Dev Wallet (wallet1): 20%
                > Dev Wallet (wallet2): 20% 
                > Marketing Wallet (wallet3): 40%
                > Holders (reflect): 16%
        */

        _governingTaxes.push(governingTaxes(10, 4, 20, 20, 40, 16, payable(wallet1_), payable(wallet2_), payable(wallet3_)));
        _governingTaxes.push(governingTaxes(25, 4, 20, 20, 40, 16, payable(wallet1_), payable(wallet2_), payable(wallet3_)));
        _localtax = _governingTaxes[1];
        //uniswapV2Router = IUniswapV2Router02(0x7a250d5630B4cF539739dF2C5dAcb4c659F2488D);
        //uniswapV2Router = IUniswapV2Router02(0x10ED43C718714eb63d5aA57B78B54704E256024E);
        uniswapV2Router = IUniswapV2Router02(0x9Ac64Cc6e4415144C455BD8E4837Fea55603e5c3);
        uniswapV2Pair = IUniswapV2Factory(uniswapV2Router.factory()).createPair(address(this), uniswapV2Router.WETH());

        //Max TX amount is 100% of the total supply, will be updated when token gets into circulation (anti-whale)
        _maxTxAmount = (_startingSupply * 10**9); 
        //Max Hold amount is 2% of the total supply. (Only for first 24 hours) (anti-whale) 
        _maxHoldAmount = ((_startingSupply * 10**9) * 2) / 100;

        //Excluding Owner and Other Governing Wallets From Reward System;
        excludeFromFee(owner());
        excludeFromReward(owner());
        excludeFromReward(burnAddress);
        excludeFromReward(wallet1_);
        excludeFromReward(wallet2_);
        excludeFromReward(wallet3_);
        excludeFromReward(address(this));

        emit Transfer(address(0), _msgSender(), _tTotal);
    }

    function name() public pure override returns (string memory) {
        return _name;
    }

    function symbol() public pure override returns (string memory) {
        return _symbol;
    }

    function decimals() public pure override returns (uint8) {
        return _decimals;
    }

    function totalSupply() public pure override returns (uint256) {
        return _tTotal;
    }

    function balanceOf(address account) public view override returns (uint256) {
        if (_isExcluded[account]) return _tOwned[account];
        return tokenFromReflection(_rOwned[account]);
    }

    function transfer(address recipient, uint256 amount) public override returns (bool) {
        _transfer(_msgSender(), recipient, amount);
        return true;
    }

    function allowance(address owner, address spender) public view override returns (uint256) {
        return _allowances[owner][spender];
    }

    function approve(address spender, uint256 amount) public override returns (bool) {
        _approve(_msgSender(), spender, amount);
        return true;
    }

    function transferFrom(
        address sender,
        address recipient,
        uint256 amount
    ) public override returns (bool) {
        _transfer(sender, recipient, amount);

        uint256 currentAllowance = _allowances[sender][_msgSender()];
        require(currentAllowance >= amount, "ERC20: transfer amount exceeds allowance");
        unchecked {
            _approve(sender, _msgSender(), currentAllowance - amount);
        }

        return true;
    }

    function increaseAllowance(address spender, uint256 addedValue) public virtual returns (bool) {
        _approve(_msgSender(), spender, _allowances[_msgSender()][spender] + addedValue);
        return true;
    }

    function decreaseAllowance(address spender, uint256 subtractedValue) public virtual returns (bool) {
        uint256 currentAllowance = _allowances[_msgSender()][spender];
        require(currentAllowance >= subtractedValue, "ERC20: decreased allowance below zero");
        unchecked {
            _approve(_msgSender(), spender, currentAllowance - subtractedValue);
        }

        return true;
    }

    function totalFees() public view returns (uint256) {
        return _tFeeTotal;
    }

    function buyTaxes() public view 
    returns (
        uint32 total_Tax_Percent,
        uint32 burn_Split,
        uint32 governingSplit_Wallet1,
        uint32 governingSplit_Wallet2,
        uint32 governingSplit_Wallet3,
        uint32 reflect_Split
    ) {
        return (
            _governingTaxes[0]._totalTaxPercent,
            _governingTaxes[0]._split0,
            _governingTaxes[0]._split1,
            _governingTaxes[0]._split2,
            _governingTaxes[0]._split3,
            _governingTaxes[0]._split4
        );
    }

    function sellTaxes() public view 
    returns (
        uint32 total_Tax_Percent,
        uint32 burn_Split,
        uint32 governingSplit_Wallet1,
        uint32 governingSplit_Wallet2,
        uint32 governingSplit_Wallet3,
        uint32 reflect_Split
    ) {
        return (
            _governingTaxes[1]._totalTaxPercent,
            _governingTaxes[1]._split0,
            _governingTaxes[1]._split1,
            _governingTaxes[1]._split2,
            _governingTaxes[1]._split3,
            _governingTaxes[1]._split4
        );
    }

    function isExcludedFromReward(address account) public view returns (bool) {
        return _isExcluded[account];
    }

    function isExcludedFromFee(address account) public view returns(bool) {
        return _isExcludedFromFee[account];
    }

    function isBlacklisted(address account) public view returns (bool) {
        return _isBlacklisted[account];
    }

    function isLiquidityPool(address account) public view returns (bool) {
        return _isLiquidityPool[account];
    }

    function _hasLimits(address from, address to) private view returns (bool) {
        return from != owner()
            && to != owner()
            && to != burnAddress;
    }

    function setBlacklistAccount(address account, bool enabled) external onlyOwner() {
        _isBlacklisted[account] = enabled;
    }

    function setLiquidityPool(address account, bool enabled) external onlyOwner() {
        
        _isLiquidityPool[account] = enabled;
        
        if(enabled) {
            swapEnabled = true;
            excludeFromReward(account);
        }
        else {
            swapEnabled = false;
            includeInReward(account);
        }
    }

    function setMaxTxAmount(uint256 maxTxAmount) external onlyOwner() {
        require(maxTxAmount >= (_tTotal / 1000), "Max Transaction amt must be above 0.1% of total supply"); // Cannot set lower than 0.1%
        _maxTxAmount = maxTxAmount;
    }

    function setMaxHoldAmount(uint256 maxHoldAmount) external onlyOwner() {
        require(maxHoldAmount >= (_tTotal / 1000), "Max Hold amt must be above 0.1% of total supply"); // Cannot set lower than 0.1%
        _maxHoldAmount = maxHoldAmount;
    }

    function unlockToken() external onlyOwner() {
        _tokenLock = false;
        _tokenCommenceTime = block.timestamp;
    }

    function setTaxes(
        uint256 type_,
        uint32 totalTaxPercent_, 
        uint32 split0_, 
        uint32 split1_, 
        uint32 split2_, 
        uint32 split3_,
        uint32 split4_, 
        address wallet1_, 
        address wallet2_,
        address wallet3_
    ) external onlyOwner() {
        require(wallet1_ != address(0) && wallet2_ != address(0) && wallet3_ != address(0), "Tax Wallets assigned zero address !");
        require(split0_+split1_+split2_+split3_+split4_ == 100, "Split Percentages does not sum upto 100 !");

        _governingTaxes[type_]._totalTaxPercent = totalTaxPercent_;
        _governingTaxes[type_]._split0 = split0_;
        _governingTaxes[type_]._split1 = split1_;
        _governingTaxes[type_]._split2 = split2_;
        _governingTaxes[type_]._split3 = split3_;
        _governingTaxes[type_]._split4 = split4_;
        _governingTaxes[type_]._wallet1 = payable(wallet1_);
        _governingTaxes[type_]._wallet2 = payable(wallet2_);
        _governingTaxes[type_]._wallet3 = payable(wallet3_);

        if(type_ == 1) _localtax = _governingTaxes[type_];
    }

    function excludeFromFee(address account) public onlyOwner {
        _isExcludedFromFee[account] = true;
    }
    
    function includeInFee(address account) external onlyOwner {
        _isExcludedFromFee[account] = false;
    }

    function excludeFromReward(address account) public onlyOwner() {
        require(!_isExcluded[account], "Account is already excluded");
        if(_rOwned[account] > 0) {
            _tOwned[account] = tokenFromReflection(_rOwned[account]);
        }
        _isExcluded[account] = true;
        _excluded.push(account);
    }

    function includeInReward(address account) public onlyOwner() {
        require(_isExcluded[account], "Account is already excluded");
        for (uint256 i = 0; i < _excluded.length; i++) {
            if (_excluded[i] == account) {
                _excluded[i] = _excluded[_excluded.length - 1];
                _tOwned[account] = 0;
                _isExcluded[account] = false;
                _excluded.pop();
                break;
            }
        }
    }

    function sendETHToWallets(uint256 amount) private {

        uint256 wsplit1 = (amount * _localtax._split1) / (_localtax._split1 + _localtax._split2 + _localtax._split3);
        uint256 wsplit2 = (amount * _localtax._split2) / (_localtax._split1 + _localtax._split2 + _localtax._split3);
        uint256 wsplit3 = amount - wsplit1 - wsplit2;

        _localtax._wallet1.transfer(wsplit1);
        _localtax._wallet2.transfer(wsplit2);
        _localtax._wallet3.transfer(wsplit3);
    }

    function swapTokensForEth(uint256 tokenAmount) private lockTheSwap {
        address[] memory path = new address[](2);
        path[0] = address(this);
        path[1] = uniswapV2Router.WETH();
        _approve(address(this), address(uniswapV2Router), tokenAmount);

        uniswapV2Router.swapExactTokensForETHSupportingFeeOnTransferTokens(
            tokenAmount,
            0,
            path,
            address(this),
            block.timestamp
        );
    }

    receive() external payable {}

    function reflect(uint256 tAmount) public {
        address sender = _msgSender();
        require(!_isExcluded[sender], "Excluded addresses cannot call this function");
        (uint256 rAmount,,,,) = _getValues(tAmount);
        _rOwned[sender] = _rOwned[sender] - rAmount;
        _rTotal = _rTotal - rAmount;
        _tFeeTotal = _tFeeTotal + tAmount;
    }

    function reflectionFromToken(uint256 tAmount, bool deductTransferFee) public view returns(uint256) {
        require(tAmount <= _tTotal, "Amount must be less than supply");
        if (!deductTransferFee) {
            (uint256 rAmount,,,,) = _getValues(tAmount);
            return rAmount;
        } else {
            (,uint256 rTransferAmount,,,) = _getValues(tAmount);
            return rTransferAmount;
        }
    }

    function tokenFromReflection(uint256 rAmount) public view returns(uint256) {
        require(rAmount <= _rTotal, "Amount must be less than total reflections");
        uint256 currentRate =  _getRate();
        return rAmount / currentRate;
    }

    function _approve(
        address owner,
        address spender,
        uint256 amount
    ) internal virtual {
        require(owner != address(0), "ERC20: approve from the zero address");
        require(spender != address(0), "ERC20: approve to the zero address");

        _allowances[owner][spender] = amount;
        emit Approval(owner, spender, amount);
    }

    function _transfer(
        address sender,
        address recipient,
        uint256 tAmount
    ) private {
        require(sender != address(0), "ERC20: transfer from the zero address");
        require(recipient != address(0), "ERC20: transfer to the zero address");
        require((!_tokenLock) || (!_hasLimits(sender, recipient))  , "Token is Locked for Liquidty to be added");

        if(!inSwap && _hasLimits(sender, recipient)) {
            require(tAmount <= _maxTxAmount, "Transfer amount exceeds the maxTxAmount");
            require(!isBlacklisted(sender) || !isBlacklisted(recipient), "Sniper Rejected");
            require(balanceOf(recipient)+tAmount <= _maxHoldAmount, "Receiver address exceeds the maxHoldAmount");
        }

        if(inSwap || _isExcludedFromFee[sender] || _isExcludedFromFee[recipient]) {
            uint256 rAmount = tAmount * _getRate();

            _rOwned[sender] = _rOwned[sender] - rAmount;
            _rOwned[recipient] = _rOwned[recipient] + rAmount;
        
            if (_isExcluded[sender]) _tOwned[sender] = _tOwned[sender] - tAmount;
            if (_isExcluded[recipient]) _tOwned[recipient] = _tOwned[recipient] + tAmount;

            emit Transfer(sender, recipient, tAmount);
        }
        else {

            if(_isLiquidityPool[sender]) _localtax = _governingTaxes[0];    
                            
            if (_localtax._totalTaxPercent > 0) {
                (uint256 rAmount, uint256 rTransferAmount, Fees memory rFee, uint256 tTransferAmount, Fees memory tFee) = _getValues(tAmount);

                if(_isLiquidityPool[sender]) _localtax = _governingTaxes[1];    

                _rOwned[sender] = _rOwned[sender] - rAmount;
                _rOwned[recipient] = _rOwned[recipient] + rTransferAmount;
                _rOwned[burnAddress] += rFee._fee0;

                if (_isExcluded[sender]) _tOwned[sender] = _tOwned[sender] - tAmount;
                if (_isExcluded[recipient]) _tOwned[recipient] = _tOwned[recipient] + tTransferAmount;
                if (_isExcluded[burnAddress]) _tOwned[burnAddress] += tFee._fee0;
                
                if (swapEnabled && sender != uniswapV2Pair && !inSwap) {
                    _rOwned[address(this)] += (rFee._fee1+rFee._fee2+rFee._fee3);
                    _tOwned[address(this)] += (tFee._fee1+tFee._fee2+tFee._fee3);

                    swapTokensForEth(tFee._fee1+tFee._fee2+tFee._fee3);
                    uint256 contractETHBalance = address(this).balance;
                    if(contractETHBalance > 0) {
                        sendETHToWallets(contractETHBalance);
                    }

                    emit Transfer(sender, address(this), (tFee._fee1+tFee._fee2+tFee._fee3));

                }

                else {
                    _rOwned[_localtax._wallet1] += rFee._fee1;
                    _rOwned[_localtax._wallet2] += rFee._fee2;
                    _rOwned[_localtax._wallet3] += rFee._fee3;
                    if (_isExcluded[_localtax._wallet1])_tOwned[_localtax._wallet1] += tFee._fee1;
                    if (_isExcluded[_localtax._wallet2])_tOwned[_localtax._wallet2] += tFee._fee2;
                    if (_isExcluded[_localtax._wallet3])_tOwned[_localtax._wallet3] += tFee._fee3;

                    emit Transfer(sender, _localtax._wallet1, tFee._fee1);
                    emit Transfer(sender, _localtax._wallet2, tFee._fee2);
                    emit Transfer(sender, _localtax._wallet3, tFee._fee3);
                }

                _reflectFee(rFee._fee4, tFee._fee0+tFee._fee1+tFee._fee2+tFee._fee3+tFee._fee4);

                emit Transfer(sender, burnAddress, tFee._fee0);
                emit Transfer(sender, recipient, tTransferAmount);
            }
            else {
                uint256 rAmount = tAmount * _getRate();

                _rOwned[sender] = _rOwned[sender] - rAmount;
                _rOwned[recipient] = _rOwned[recipient] + rAmount;
            
                if (_isExcluded[sender]) _tOwned[sender] = _tOwned[sender] - tAmount;
                if (_isExcluded[recipient]) _tOwned[recipient] = _tOwned[recipient] + tAmount;

                emit Transfer(sender, recipient, tAmount);
            }
        }
    }

    function _reflectFee(uint256 rFee, uint256 tFee) private {
        _rTotal = _rTotal - rFee;
        _tFeeTotal = _tFeeTotal + tFee;
    }

    function _getValues(uint256 tAmount) private view returns (uint256 rAmount, uint256 rTransferAmount, Fees memory rFee, uint256 tTransferAmount, Fees memory tFee) {
        (tTransferAmount, tFee) = _getTValues(tAmount);
        uint256 currentRate =  _getRate();
        (rAmount, rTransferAmount, rFee) = _getRValues(tAmount, tFee, currentRate);
        return (rAmount, rTransferAmount, rFee, tTransferAmount, tFee);
    }

    function _getTValues(uint256 tAmount) private view returns (uint256, Fees memory) {
        Fees memory tFee;
        tFee._fee0 = (tAmount * _localtax._totalTaxPercent * _localtax._split0) / 10**4;
        tFee._fee1 = (tAmount * _localtax._totalTaxPercent * _localtax._split1) / 10**4;
        tFee._fee2 = (tAmount * _localtax._totalTaxPercent * _localtax._split2) / 10**4;
        tFee._fee3 = (tAmount * _localtax._totalTaxPercent * _localtax._split3) / 10**4;
        tFee._fee4 = (tAmount * _localtax._totalTaxPercent * _localtax._split4) / 10**4;
        uint256 tTransferAmount = tAmount - tFee._fee0 - tFee._fee1 - tFee._fee2 - tFee._fee3 - tFee._fee4;
        return (tTransferAmount, tFee);
    }

    function _getRValues(uint256 tAmount, Fees memory tFee, uint256 currentRate) private pure returns (uint256, uint256, Fees memory) {
        uint256 rAmount = tAmount * currentRate;
        Fees memory rFee;
        rFee._fee0 = tFee._fee0 * currentRate;
        rFee._fee1 = tFee._fee1 * currentRate;
        rFee._fee2 = tFee._fee2 * currentRate;
        rFee._fee3 = tFee._fee3 * currentRate;
        rFee._fee4 = tFee._fee4 * currentRate;
        uint256 rTransferAmount = rAmount - rFee._fee0 - rFee._fee1 - rFee._fee2 - rFee._fee3 - rFee._fee4;
        return (rAmount, rTransferAmount, rFee);
    }

    function _getRate() private view returns(uint256) {
        (uint256 rSupply, uint256 tSupply) = _getCurrentSupply();
        return rSupply / tSupply;
    }

    function _getCurrentSupply() private view returns(uint256, uint256) {
        uint256 rSupply = _rTotal;
        uint256 tSupply = _tTotal;      
        for (uint256 i = 0; i < _excluded.length; i++) {
            if (_rOwned[_excluded[i]] > rSupply || _tOwned[_excluded[i]] > tSupply) return (_rTotal, _tTotal);
            rSupply = rSupply - _rOwned[_excluded[i]];
            tSupply = tSupply - _tOwned[_excluded[i]];
        }
        if (rSupply < _rTotal / _tTotal) return (_rTotal, _tTotal);
        return (rSupply, tSupply);
    }
}