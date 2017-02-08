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
        print (times)
        print (tempArray.count)
        self.notDealt = sortCards(tempArray)
        for card in notDealt { print( card.cardLabel )}
    }
    
    var description: String {
        return "Cards Remaining: \(self.notDealt.count) Cards Dealt: \(self.dealt.count)\n"     }
    func shuffle () {
        var deckToShuffle: [Card] = [] //variable to store deck to shuffle
//        if notDealt.count == 0 && dealt.count == 0 {
//            notDealt += [Card(),Card()] //because of an error the tests created >.<
//        }
        if notDealt.count == 0 {
            deckToShuffle = self.dealt //takes cards from graveyard if no cards remain
            self.dealt.removeAll()
        } else {
            deckToShuffle = self.notDealt //shuffles the deck
            self.notDealt.removeAll()
        }
        
        //var arrayA = notDealt //put all possible cards into a new array
        let end = deckToShuffle.count
        for i in 0..<end{
            let rndIndex = Int(arc4random_uniform(UInt32(deckToShuffle.count)))
            self.notDealt.append(deckToShuffle[rndIndex])//<^choose a random card by index
            //self.notDealt.removeFirst(1) //get rid of ordered cards and keep size at 52
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
        notDealt.remove(at: 0)
        return myCard
    }
}
