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
    }
    var blackjack: Bool{
        if cards.count > 2{
            return false
        }
        return handscore == 21
    }
    var busted: Bool{
        return handscore > 21
    }
    var mayHit: Bool{
        return !(blackjack||busted||stayed)
    }
    var description: String{
        var toReturn = name + "has cards: " + cards.description
        toReturn += "tokens: \(tokens) stayed: \(stayed)"
        toReturn += "handscore: \(handscore) busted: \(busted) blackjack: \(blackjack)"
        return toReturn
    }
    func didWin (bet: UInt){
        tokens += bet
    }
    func didLose (bet: UInt){
        tokens -= bet
    }
    func makeBet ()-> UInt { //makes a random bet based on number of tokens remaining!
        let amountToBet = arc4random_uniform(UInt32(self.tokens))
        return UInt(amountToBet)
    }
    func canPlace(bet: UInt) -> Bool{
        return bet <= self.tokens
    }
}
