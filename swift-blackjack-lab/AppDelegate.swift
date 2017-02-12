//
//  AppDelegate.swift
//  swift-blackjack-lab
//
//  Created by Flatiron School on 7/8/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    var dealer = Dealer ()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        /*
         
         * Call your custom classes here when running the scheme.
         
         */
        var rounds = 1
        while dealer.place(bet: 100) {
            print ("////////////////////////////////////////////////////////////////////ROUND #\(rounds)\n//////////////////////////////////////////////////////////////////")
            playBlackjack(withBet: 100)
            rounds += 1
        }
        
        // Do not alter
        return true  //
    }
    
    
     func playBlackjack (withBet: UInt){
        var turns = 0
        guard dealer.place(bet: withBet) else {return}
        dealer.deal()
        print ("Turn \(turns)")
        print (dealer.player.betterDesc())
        print (dealer.house.betterDesc())
        while dealer.winner() == "no" {
            turns += 1
            print ("Turn \(turns)")
            dealer.turn(house: dealer.house)
            dealer.turn(house: dealer.player)
            print (dealer.player.betterDesc())
            print (dealer.house.betterDesc())
            print (dealer.deck.description)
        }
        print (dealer.award())
        
     }
     
 
    
}

