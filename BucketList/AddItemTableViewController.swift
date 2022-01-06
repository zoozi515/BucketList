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
   
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done", style:.plain, target: self, action: #selector(self.appenedElement))
        
    }

    
    @objc func appenedElement(){
        //dismmis the view > add item > reload the table view
        guard let item = bucketItem.text else {return}
        addItemDelegate?.addItem(item: item)
        
        //used when we presenting modally
        //self.dismiss(animated: true, completion: nil)
        
        //used when we pushing - we go back to pre controller
        self.navigationController?.popViewController(animated: true)
        
        //we go to specific controller
        //self.navigationController?.popToViewController(UIViewController, animated: true)
        
        //we go to home page - used when we have many controller to fill a form
        //self.navigationController?.popToRootViewController(animated: <#T##Bool#>)
    }
}

protocol AddItemDelegate: class {
    func addItem(item: String)
}
