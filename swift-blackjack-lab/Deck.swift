//
//  Deck.swift
//  swift-blackjack-lab
//
//  Created by Edmund Holderbaum on 2/7/17.
//  Copyright © 2017 Flatiron School. All rights reserved.
//

import Foundation

class Deck{
    private var dealt : [Card]
    private var notDealt : [Card]
    
    init(){
        self.dealt = []
        self.notDealt = []
        var tempArray:[Card] = []
        for key in blackJackValues.keys{
            for suit in allSuits{  //load dealt with all possible cards=
                tempArray.append(Card(suit: suit, rank: key ))
            } //chose to load deck since
        }
        self.notDealt = sortCards(tempArray)
    }
    
    var description: String {
        return "Cards Remaining: \(self.notDealt.count) Cards Dealt: \(self.dealt.count) \n"     }
    
    func shuffle () {
        var deckToShuffle: [Card] = [] //variable to store deck to shuffle
        if notDealt.count == 0 {
            deckToShuffle = self.dealt //takes cards from graveyard if no cards remain
            self.dealt.removeAll()
        } else {
            deckToShuffle = self.notDealt //shuffles the deck
            self.notDealt.removeAll()
        }
        
        
        let end = deckToShuffle.count
        for _ in 0..<end{
            let rndIndex = Int(arc4random_uniform(UInt32(deckToShuffle.count)))
            self.notDealt.append(deckToShuffle[rndIndex])//<^choose a random card by index
           deckToShuffle.remove(at: rndIndex) //remove the used card to prevent doubles
        }
    //so proud of myself for this!
    }
    
    func drawCard () -> Card {
        if notDealt.count == 0{
            print ("No cards left to draw! Shuffling dealt cards...")
            shuffle()
            return drawCard()
        }
        let myCard = notDealt[0]
        dealt.append(myCard)
        notDealt.remove(at: 0)
        return myCard
    }
}
