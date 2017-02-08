//
//  DeckTableViewController.swift
//  SURF_Translate
//
//  Created by Legeng Liu on 6/1/16.
//  Copyright © 2016 SURF. All rights reserved.
//

import UIKit

class DeckTableViewController: UITableViewController, UINavigationControllerDelegate{
    
    //MARK: Properties:

    //keeps array of Deck objects
    var decks = [Deck]()
    
     //favoriteDecks is used *internally* to keep track of all my favorite decks. For sorting purposes etc.
     // every time a Deck is favorited, add it to the favoriteDecks array, but also have it in the normal decks array, because the tableview controller displays the decks array. favoriteDecks is not displayed and only used to keep track internally.
    var favoriteDecks = [Deck]()
    
    //implementing search. "nil" means no new view controller needed when searching
    let searchController = UISearchController(searchResultsController: nil)
    
    var filteredDecks = [Deck]()
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        self.navigationItem.rightBarButtonItem = self.editButtonItem
        
    
         //making sample Cards and Decks to test stuff
         
        var sampleCards = [Card]()
        var sampleCards2 = [Card]()
        var sampleCards3 = [Card]()
        
        let card1 = Card(firstPhrase: "1", secondPhrase: "2", numTimesUsed: 0)!
        let card2 = Card(firstPhrase: "english", secondPhrase: "arabic", numTimesUsed : 0)!
        let card3 = Card(firstPhrase: "I need water", secondPhrase: "أحتاج إلى الماء", numTimesUsed :0)!
        let card4 = Card(firstPhrase: "Hello", secondPhrase: "Salaam", numTimesUsed: 0)!
            
        sampleCards += [card1, card2, card3, card4]
        sampleCards2 += [card1, card3, card4]
        sampleCards3 += [card3, card4]
        
        
        let deck1 = Deck(name: "Refugee", cards: sampleCards, language1: "English", language2: "Arabic", isFavorite: true)!
        let deck2 = Deck(name: "UNHCR Phrasebook", cards: sampleCards2, language1: "English", language2: "Arabic", isFavorite: true)!
        let deck3 = Deck(name: "UNHCR Phrasebook Extended extended extended extended extended dddddddddddddddddddddddddddddddd", cards: sampleCards, language1: "English", language2: "Arabic", isFavorite: false)!
        let deck4 = Deck(name: "Doctors to Refugees", cards: sampleCards, language1: "English", language2: "Arabic", isFavorite: false)!
        let deck5 = Deck(name: "Commonly used in camp", cards: sampleCards, language1: "English", language2: "Arabic", isFavorite: false)!
        let deck6 = Deck(name: "Customized deck", cards: sampleCards, language1: "English", language2: "Arabic", isFavorite: false)!
        let deck7 = Deck(name: "Imported Online", cards: sampleCards3, language1: "English", language2: "Arabic", isFavorite: false)!
        decks += [deck1, deck2, deck3, deck4, deck5, deck6, deck7]
        
        //filtering favorited decks from all decks
        favoriteDecks = decks.filter{$0.isFavorite == true}

        
//MARK: search
        
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        searchController.hidesNavigationBarDuringPresentation = true  //maybe we should set this to true?
        definesPresentationContext = true
        tableView.tableHeaderView = searchController.searchBar
    }
    
    func filterContentForSearchText(_ searchText: String){
        filteredDecks = decks.filter{deck in
            return deck.name.lowercased().contains(searchText.lowercased())
        }
        tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    //when searching, return the # of Decks that fit search criteria, otherwise return total #
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchController.isActive && searchController.searchBar.text != "" {
            return filteredDecks.count
        } else {
            return decks.count
        }
    }

    //lets DeckTableViewController set the values inside each cell to decks that are already filtered
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellIdentifier = "DeckTableViewCell" //this unique identifier can be edited in Attributes section of Cell object
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! DeckTableViewCell

        var deck: Deck
        
        if searchController.isActive && searchController.searchBar.text != "" {
            deck = filteredDecks[indexPath.row]
        } else {
            deck = decks[indexPath.row]
        }
        
        cell.deckName.text = deck.name
        cell.numberOfCards.text = "Cards:" + String(deck.cards.count)
        cell.deckFavoriteControl.isFavorite = deck.isFavorite
        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
     
     
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        var selectedDeck: Deck
        if segue.identifier == "showCards"{
        
            let showCardsViewController = segue.destination as! CardTableViewController
            
            if let selectedDeckCell = sender as? DeckTableViewCell{
                let indexPath = tableView.indexPath(for: selectedDeckCell)!
                
                if searchController.isActive && searchController.searchBar.text != "" {
                    selectedDeck = filteredDecks[indexPath.row]
                } else {
                    selectedDeck = decks[indexPath.row]
                }
                showCardsViewController.cards = selectedDeck.cards
                showCardsViewController.navigationItem.title? = selectedDeck.name
                
            }
        } else if segue.identifier == "AddDeck"{
            print ("add new deck")
        }
    }
    
    @IBAction func unwindToDeckList(_ sender: UIStoryboardSegue) {
        if let sourceViewController = sender.source as? NewDeckViewController, let newDeck = sourceViewController.newDeck {
            
            // if new made Deck is favorited, then this code below puts it on top, below the other Favorited decks.
            if newDeck.isFavorite == true{
                let newIndexPath = IndexPath(row: favoriteDecks.count, section: 0)
                decks.insert(newDeck, at: favoriteDecks.count)
                tableView.insertRows(at: [newIndexPath], with: .bottom)
                
                favoriteDecks.append(newDeck)
            
            // if not a Favorite, then put on bottom of all the decks
            } else {
                let newIndexPath = IndexPath(row: decks.count, section: 0)
                decks.append(newDeck)
                tableView.insertRows(at: [newIndexPath], with: .bottom)
            }
        }
    }
}

extension DeckTableViewController: UISearchResultsUpdating{
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
    }
}




