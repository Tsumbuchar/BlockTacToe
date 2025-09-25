// SPDX-License-Identifier: MIT

pragma solidity ^0.8.20;

contract TicTacToe {
    uint constant public gameCost = 0.1 ether;
    
    uint8 public boardSize = 3;
    uint8 public movesCounter;

    uint balanceToWithdrawPlayer1;
    uint balanceToWithdrawPlayer2;

    uint timeToReact = 3 minutes;
    uint gameValidUntil;

    bool gameActive;

    address[3][3] board;

    address public player1;
    address public player2;

    address activePlayer;

    event PlayerJoined(address player);
    event NextPlayer(address player);
    event GameOverWithWin(address winner);
    event GameOverWithDraw(address player);
    event PayoutSuccess(address reciever, uint amountInWei);

    function TictacToe() public payable{
        player1 = msg.sender;
        require(msg.value == gameCost);
        gameValidUntil = block.timestamp + timeToReact;
    }

    function joinGame() public payable{
        assert (player2 == address(0));
        require(msg.value == gameCost);
        gameActive = true;
        player2 = msg.sender;
        emit PlayerJoined(player2);
        
        if(block.number % 2 == 0){
            activePlayer = player1;
        }else{
            activePlayer = player2;
        }
        
        gameValidUntil = block.timestamp + timeToReact;
        emit NextPlayer(activePlayer);  

    }

    function getBoard() public view returns(address[3][3] memory){
        return board;
    }

    function setWinner(address player) private{
        gameActive = false;
        emit GameOverWithWin(player);
        uint balanceToPayOut = address(this).balance;
        (bool sent, ) = payable(player).call{value: balanceToPayOut}("");
        if(!sent){
            if(player == player1){
                balanceToWithdrawPlayer1 = balanceToPayOut;
            }else{
                balanceToWithdrawPlayer2 = balanceToPayOut;
            }
        }else{
            emit PayoutSuccess(player, balanceToPayOut);
        }
    }

    function withDrawWin() public {
        if(msg.sender == player1){
            require(balanceToWithdrawPlayer1 > 0);
            balanceToWithdrawPlayer1 = 0;
            payable(player1).transfer(balanceToWithdrawPlayer1);
            emit PayoutSuccess(player1, balanceToWithdrawPlayer1);
        }else{
            require(balanceToWithdrawPlayer2 > 0);
            balanceToWithdrawPlayer2 = 0;
            payable(player1).transfer(balanceToWithdrawPlayer2);
            emit PayoutSuccess(player2, balanceToWithdrawPlayer2);
        }
    }

    function setDraw() private{
        gameActive = false;
        emit GameOverWithDraw(address(0));

        uint balanceToPayOut = address(this).balance / 2;

        if(payable(player1).send(balanceToPayOut) == false){
            balanceToWithdrawPlayer1 += balanceToPayOut;
        }else{
            emit PayoutSuccess(player1, balanceToPayOut);
        }
        if(payable(player2).send(balanceToPayOut) == false){
            balanceToWithdrawPlayer2 += balanceToPayOut;
        }else{
            emit PayoutSuccess(player2, balanceToPayOut);
        }
        
        
        /*uint refund = address(this).balance / 2;
        if (refund > 0) {
            payable(player1).transfer(refund);
            payable(player2).transfer(refund);
            emit PayoutSuccess(player1, refund);
            emit PayoutSuccess(player2, refund);
        }*/
    }

    function emergencyCashout() public {
        require(gameValidUntil < block.timestamp);
        require(gameActive);
        setDraw();
    }

    function setStone(uint8 x,uint8 y) public{
        require(board[x][y] == address(0));
        require(gameValidUntil > block.timestamp);
        assert(gameActive);
        assert(x < boardSize);
        assert(y < boardSize);
        require(msg.sender == activePlayer);
        board[x][y] = msg.sender;
        movesCounter++;
        gameValidUntil = block.timestamp + timeToReact;

        for(uint8 i = 0; i < boardSize; i++){
            if(board[i][y] != activePlayer){
                break;
            }
            //win
            if(i == (boardSize-1)){
                //winner
                setWinner(activePlayer);
                return;
            }
        }

        for(uint8 i = 0; i < boardSize; i++){
            if(board[x][i] != activePlayer){
                break;
            }
            //win
            if(i == (boardSize-1)){
                //winner
                setWinner(activePlayer);
                return;
            }
        }

        //diagonale
        if(x==y){
            for(uint8 i = 0; i < boardSize; i++){
                if(board[i][i] != activePlayer){
                    break;
                }
                //win
                if(i == (boardSize-1)){
                    //winner
                    setWinner(activePlayer);
                    return;
                }
            }
        }

        //anti-diagonale
        if((x + y) == boardSize - 1){
            for(uint8 i = 0; i < boardSize; i++){
                if(board[i][(boardSize-1)-i] != activePlayer){
                    break;
                }
                //win
                if(i == (boardSize-1)){
                    //winner
                    setWinner(activePlayer);
                    return;
                }
            }
        }
        
        //draw
        if(movesCounter == (boardSize**2)){
            setDraw();
            return;
        }

        if (activePlayer == player1){
            activePlayer = player2;
        }else{
            activePlayer = player1;
        }


    }
}