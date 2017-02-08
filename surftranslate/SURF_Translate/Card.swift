//
//  Card.swift
//  SURF_Translate
//
//  Created by Legeng Liu on 6/1/16.
//  Copyright © 2016 SURF. All rights reserved.
//

import UIKit

class Card {
    
    //MARK: properties
    //phrases, recordings, languages etc.
    
    var firstPhrase: String
    var secondPhrase: String
    
    
    //For the Most Used sorting function. Increment every time user taps the Sound Button
    var numTimesUsed: Int
    
    //Init
    init?(firstPhrase:String, secondPhrase:String, numTimesUsed:Int){
        self.firstPhrase = firstPhrase
        self.secondPhrase = secondPhrase
        self.numTimesUsed = numTimesUsed
        
        if firstPhrase.isEmpty && secondPhrase.isEmpty{
            return nil
        }
    }
}
