//
//  DeckTableViewCell.swift
//  SURF_Translate
//
//  Created by Legeng Liu on 6/1/16.
//  Copyright © 2016 SURF. All rights reserved.
//

import UIKit

class DeckTableViewCell: UITableViewCell {

    //Properties
    @IBOutlet weak var deckName: UILabel!
    @IBOutlet weak var numberOfCards: UILabel!
    @IBOutlet weak var deckFavoriteControl: DeckFavoriteControl!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
