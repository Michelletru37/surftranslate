//
//  CardTableViewController.swift
//  SURF_Translate
//
//  Created by Legeng Liu on 6/2/16.
//  Copyright © 2016 SURF. All rights reserved.
//

import UIKit

class CardTableViewController: UITableViewController, UINavigationControllerDelegate {
    
    //MARK: properties
    

    var cards = [Card]() //keeps track of all the Card objects
    
    //search
    let searchController = UISearchController(searchResultsController: nil)
    
    var filteredCards = [Card]()

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        self.navigationItem.rightBarButtonItem = self.editButtonItem
  
        /*
        //adding some sample Cards
        let card1 = Card(firstPhrase: "1", secondPhrase: "2", numTimesUsed: 0)
        let card2 = Card(firstPhrase: "English", secondPhrase: "Arabic", numTimesUsed: 0)
        let card3 = Card(firstPhrase: "I need water", secondPhrase: "أحتاج إلى الماء", numTimesUsed:0)
        cards += [card1, card2, card3]
        */
        
        
        //search
        
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        searchController.hidesNavigationBarDuringPresentation = true
        definesPresentationContext = true
        tableView.tableHeaderView = searchController.searchBar
        
    }
    
    //how to be able to search both top and bottom string?
    func filterContentForSearchText(_ searchText:String){
        filteredCards = cards.filter { card in
            return (card.firstPhrase.lowercased().contains(searchText.lowercased())) || (card.secondPhrase.lowercased().contains(searchText.lowercased()))
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

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchController.isActive && searchController.searchBar.text != ""{
            return filteredCards.count
        } else {
            return cards.count
        }
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "CardTableViewCell"
     
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! CardTableViewCell
        
        var card: Card
        
        if searchController.isActive && searchController.searchBar.text != "" {
            card = filteredCards[indexPath.row]
        } else {
            card = cards[indexPath.row]
        }
        
        cell.topPhrase.text = card.firstPhrase
        cell.bottomPhrase.text = card.secondPhrase
        return cell
    }
    


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
        if segue.identifier == "AddCard"{
            print ("adding new card")
        }
        /*
        let card: Card
        if searchController.active && searchController.searchBar.text != ""{
            card = filteredCards[indexPath.row]
         } else {
            card = cards[indexPath.row]
         }
        */
    }
    
    @IBAction func unwindToCardList(_ sender: UIStoryboardSegue){
        if let sourceViewController = sender.source as? NewCardViewController, let newCard = sourceViewController.newCard {
            
            //need to implement fav function later
            
            let newIndexPath = IndexPath(row: cards.count, section: 0)
            cards.append(newCard)
            tableView.insertRows(at: [newIndexPath], with: .bottom)
        }
    }
}



extension CardTableViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
    }
    
}


