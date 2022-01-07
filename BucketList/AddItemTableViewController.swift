//
//  AddItemTableViewController.swift
//  BucketList
//
//  Created by administrator on 05/01/2022.
//

import UIKit

class AddItemTableViewController: UIViewController {

    @IBOutlet weak var bucketItem: UITextField!
    
    var addItemDelegate: AddItemDelegate?
    var itemName: String?
    var indexPathRow: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if itemName != ""{
            bucketItem.text = itemName
        }
        //navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done", style:.plain, target: self, action: #selector(self.appenedElement))
    }

    @IBAction func saveButtonPressed(_ sender: UIButton) {
        appenedElement()
    }
    
    func appenedElement(){
        //dismmis the view > add item > reload the table view
        guard let item = bucketItem.text else {return}
        if(itemName != "" && indexPathRow != nil){
            addItemDelegate?.editItem(item: item, indexPathRow: indexPathRow!)
        } else{
            addItemDelegate?.addItem(item: item)
        }
           
        
        //used when we presenting modally
        self.dismiss(animated: true, completion: nil)
        
    }
}

protocol AddItemDelegate: class {
    func addItem(item: String)
    func editItem(item: String, indexPathRow: Int)
}
