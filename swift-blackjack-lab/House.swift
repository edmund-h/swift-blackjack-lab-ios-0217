//
//  House.swift
//  swift-blackjack-lab
//
//  Created by Edmund Holderbaum on 2/7/17.
//  Copyright © 2017 Flatiron School. All rights reserved.
//

import Foundation

class House : Player {
    override init (name nameIn: String ) {
        super.init (name: nameIn)
        tokens = tokens * 10
    }
    override var mayHit: Bool{
        if self.mustHit {
            return super.mayHit}
        return false
    }
    var mustHit: Bool {
        
        return self.handscore < 17
    }
}
