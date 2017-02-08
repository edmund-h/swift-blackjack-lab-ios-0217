//
//  Card.swift
//  swift-blackjack-lab
//
//  Created by Edmund Holderbaum on 2/7/17.
//  Copyright © 2017 Flatiron School. All rights reserved.
//

import Foundation

class Card {
    let suit: String
    let rank: String
    let cardLabel: String
    var cardValue: UInt{
        return determineCardValue(rank)
    }
    var description: String {
        return self.cardLabel
    }
    var sortValue: UInt{
        if let thisVal = sortingValues [rank] {
            return thisVal
        }
        return 0
    }
    convenience init () {
        let mySuit = allSuits [Int(arc4random_uniform(3))]
        let myRank = Array(blackJackValues.keys) [Int(arc4random_uniform(12))]
        self.init (suit: mySuit, rank: myRank)
    }
    init (suit mySuit: String, rank myRank: String) {
        self.suit = mySuit
        self.rank = myRank
        self.cardLabel = mySuit + myRank
        //determineCardValue is computed instead of initialized here
        //because trying to do that with a function made swift mad
        //...I don't like fighting with swift.
    }
    
    func validSuits () -> [String]{
        return allSuits
    }
    func validRanks () -> [String]{
        return Array(blackJackValues.keys)
    }
    
    func determineCardValue (_ myRank: String ) -> UInt{
        
        if let myVal = blackJackValues[myRank]{
            return myVal
        }
        return 0
    }
}
func sortCards(_ cardArray: [Card])-> [Card]{
    var myArray: [Card] = []
    var clubs: [Card] = []
    var spades: [Card] = []
    var hearts: [Card] = []
    var diamonds: [Card] = []
    let sortedCards = cardArray.sorted(by: { $1.sortValue < $0.sortValue })
    var times = 0
    for card in sortedCards {
        switch card.suit {
        case "♣︎":
            clubs.append(card)
        case "♥︎":
            hearts.append(card)
        case "♦︎":
            diamonds.append(card)
        case "♠︎":
            spades.append(card)
        default:
            continue
        }
        times += 1
        
    }
    myArray = clubs + spades + hearts + diamonds
    
//    myArray.append(clubs)
//    myArray.append(spades)
//    myArray.append(hearts)
//    myArray.append(diamonds)
    return myArray
}

func descriptionFor(_ cardArray: [Card]) -> String {
    let output = String(describing: sortCards(cardArray))
    return output
}

let blackJackValues: [String : UInt] = [
    "A" : 1,
    "2" : 2,
    "3" : 3,
    "4" : 4,
    "5" : 5,
    "6" : 6,
    "7" : 7,
    "8" : 8,
    "9" : 9,
    "10":10,
    "J" :10,
    "Q" :10,
    "K" :10
]

let sortingValues: [String :UInt] = [
    "A" : 1,
    "2" : 2,
    "3" : 3,
    "4" : 4,
    "5" : 5,
    "6" : 6,
    "7" : 7,
    "8" : 8,
    "9" : 9,
    "10":10,
    "J" :11,
    "Q" :12,
    "K" :13
]

let allSuits = ["♣︎","♠︎","♥︎","♦︎"]


