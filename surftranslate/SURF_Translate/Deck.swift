//
//  Deck.swift
//  SURF_Translate
//
//  Created by Legeng Liu on 6/1/16.
//  Copyright © 2016 SURF. All rights reserved.
//

import UIKit

class Deck {
    
    //MARK: properties
    
    var name: String
    var cards: [Card]
    var isFavorite: Bool = false
    
    
    //keeps track of the Deck language so we can sort using the language drop down menu.
    var language1: String?
    var language2: String?

    //MARK: initialization
    
    init?(name:String, cards: [Card], language1:String?, language2:String?, isFavorite: Bool){
        self.name = name
        self.cards = cards
        self.language1 = language1
        self.language2 = language2
        self.isFavorite = isFavorite
        

        if name.isEmpty{
            return nil
        }
    }
    
    /* un-comment for Encoding and Decoding data later
     
    //MARK: implementing the NSOBject and NSCoding protocals
    func encodeWithCoder(aCoder: NSCoder) {
        //filler
    }
    
    required convenience init? (coder aDecoder: NSCoder){
        //filler
    }
   */
}
