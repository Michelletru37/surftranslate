//
//  NewDeckViewController.swift
//  SURF_Translate
//
//  Created by Legeng Liu on 6/11/16.
//  Copyright © 2016 SURF. All rights reserved.
//

import UIKit

class NewCardViewController: UIViewController, UINavigationControllerDelegate, UITextViewDelegate {
    
    //MARK: Properties
    
    
    
    @IBOutlet weak var translateFromTextView: UITextView!
    @IBOutlet weak var translateToTextView: UITextView!
    @IBOutlet weak var saveButton: UIButton!
    
    var newCard = Card?()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        translateFromTextView.delegate = self
        translateToTextView.delegate = self
        
        //make sure save button is diabled when first starts
        checkValidCard()
        
        
        //adding borders to textview
        translateFromTextView.layer.borderWidth = 0.5
        translateFromTextView.layer.borderColor = UIColor.lightGray.cgColor
        translateFromTextView.layer.cornerRadius = 4.0
        
        translateToTextView.layer.borderWidth = 0.5
        translateToTextView.layer.borderColor = UIColor.lightGray.cgColor
        translateToTextView.layer.cornerRadius = 4.0
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: - Navigation
    @IBAction func cancelNewCard(_ sender: AnyObject) {
        dismiss(animated: true, completion: nil)
    }
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if saveButton === sender {
            let translateFrom = translateFromTextView.text!
            let translateTo = translateToTextView.text!
            
            newCard = Card(firstPhrase: translateFrom, secondPhrase: translateTo, numTimesUsed: 0)
        }

    }
    
    //MARK: UITextViewDelegate
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        //delete prompt text when user preses on textview
        checkValidCard()
        if textView == translateFromTextView && textView.text == "First phrase of this card"{
            translateFromTextView.text = ""
            
        } else if textView == translateToTextView && textView.text == "Second phrase of this card"{
            translateToTextView.text = ""
            
        }
        
    }
   
    func textViewDidEndEditing(_ textView: UITextView) {
        checkValidCard()
    }
    
    func textViewDidChange(_ textView: UITextView) {
        checkValidCard()
    }
    
    //gets rid of keyboard
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if(text == "\n") {
            textView.resignFirstResponder()
            return false
        }
        return true
    }
    
    func checkValidCard() {
        // Disable the Save button if the text field is empty.
        let text1 = translateFromTextView.text ?? ""
        let text2 = translateToTextView.text ?? ""
        if text1.isEmpty && text2.isEmpty{
            saveButton.isEnabled = false
        } else if text1 == "First phrase of this card" && text2 == "Second phrase of this card"{
            saveButton.isEnabled = false
        } else {
            saveButton.isEnabled = true
        }
    }
    
}
