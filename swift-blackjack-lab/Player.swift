//
//  Player.swift
//  swift-blackjack-lab
//
//  Created by Edmund Holderbaum on 2/7/17.
//  Copyright © 2017 Flatiron School. All rights reserved.
//

import Foundation

class Player {
    let name: String
    var tokens: UInt
    var cards: [Card]
    var stayed: Bool
    
    init (name: String) {
        self.name = name
        self.tokens = 100
        self.cards = []
        self.stayed = false
    }
    
    var handscore: UInt{
        var hasAce:UInt = 0
        var total:UInt = 0
        for myCard in cards {
            if myCard.cardValue == 1 {
                hasAce += 1
                continue
            }
            total += myCard.cardValue
        }
        if hasAce == 1 && total == 10 { return 21 }
        return total + hasAce
    }//returns score value of player's hand
    
    var blackjack: Bool{
        guard handscore == 21 else {return false}
        guard cards.count > 2 else {return false}
        print ("\(name) has BLACKJACK!")
        return true
    }//determines whether player has blackjack
    
    var busted: Bool{
        let didBust = handscore > 21
        if didBust { print ("\(name) has BUSTED!")}
        return didBust
    }//determines if player busted
    
    var mayHit: Bool{
        return !(blackjack||busted||stayed)
    }//determines whether player may hit
    
    var description: String{
        var toReturn = name + " has cards: " + descriptionFor(cards)
        toReturn += "tokens: \(tokens) stayed: \(stayed) "
        toReturn += "handscore: \(handscore) busted: \(busted) blackjack: \(blackjack)\n"
        return toReturn
    }//generates a description of the player's gamestate
    
    func didWin (bet: UInt){
        print ("\(name) gained \(bet) tokens.")
        self.tokens += bet
    }//adds tokens if player won bet
    
    func didLose (bet: UInt){
        print ("\(name) lost \(bet) tokens.")
        self.tokens -= bet
    }//removes them if player lost bet
    
    func makeBet ()-> UInt { //makes a random bet based on number of tokens remaining!
        let amountToBet = arc4random_uniform(UInt32(self.tokens))
        print ("\(name) bets \(amountToBet) tokens!")
        return UInt(amountToBet)
    }//places bet
    
    func canPlace(bet: UInt) -> Bool{
        return bet <= self.tokens
    }//determines whether a bet can be placed
        
    func betterDesc () -> String {
        return "\(name)'s hand is \(descriptionFor(cards)) score is \(handscore) and has \(tokens) tokens remaining."
    }

}





