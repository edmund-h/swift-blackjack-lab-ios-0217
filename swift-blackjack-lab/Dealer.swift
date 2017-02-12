//
//  Dealer.swift
//  swift-blackjack-lab
//
//  Created by Edmund Holderbaum on 2/7/17.
//  Copyright © 2017 Flatiron School. All rights reserved.
//

import Foundation

class Dealer {
    var deck: Deck = Deck ()
    var house = House (name: "House")
    var player: Player
    var bet: UInt = 0
    var round = 1
    
//    convenience init (usingHouseRules: Bool){
//        if !usingHouseRules {
//            self.player = Player (name: "Player")
//        }else{
//           self.init()
//        }
//    }
    init (){
        self.player = House (name: "Player")
    }
    
    func place (bet alphaBet: UInt) -> Bool {
        if alphaBet <= player.tokens && alphaBet <= house.tokens {
            bet = alphaBet
            print ("Bet placed sccessfully!")
            return true
        }
        print ("Bet placement failed :[")
        return false
    }
    func deal () {
        deck.shuffle()
        print (deck.description)
        player.stayed = false
        house.stayed = false
        player.cards.removeAll()
        house.cards.removeAll()
        takeCard(house)
        takeCard(player)
        takeCard(house)
        takeCard(player)
        self.round += 1
    }
    func turn (house myTurn: Player) {
        if myTurn.mayHit && !myTurn.stayed {
            takeCard(myTurn)
        } else {
            myTurn.stayed = true
        }
        
    }
    func winner () -> String {
        if player.busted || house.blackjack {
            return "house"
        }
        if player.blackjack || house.busted || player.cards.count > 4{
            return "player"
        }
        if house.stayed && player.stayed{
            if house.handscore >= player.handscore{
                return "house"
            }
            return "player"
        }
        return "no"
    }
    func award () ->String{
        switch winner(){
        case "no":
            return ("Round continues, no winner.")
        case "player":
            house.didLose(bet: bet)
            player.didWin(bet: bet)
            return ("The player wins the round: \(player.handscore) - \(house.handscore)")
        default:
            house.didWin(bet: bet)
            player.didLose(bet: bet)
            return ("The house wins the round.\(house.handscore) - \(player.handscore)")
        }
    }
    private func takeCard  (_ playerIn: Player){
        playerIn.cards.append( deck.drawCard() )
    }
    
}
