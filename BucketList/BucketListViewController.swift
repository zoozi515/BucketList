//
//  ViewController.swift
//  BucketList
//
//  Created by administrator on 05/01/2022.
//

import UIKit

class BucketListViewController: UITableViewController {
    
    var array = ["name","age","id"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add", style:.plain, target: self, action: #selector(self.addTabbed))
        
    }

    @objc func addTabbed(){
        // i can put this code inside button func
        let addItemVC =  storyboard?.instantiateViewController(identifier: "addVC") as! AddItemTableViewController
        addItemVC.addItemDelegate = self
        //push
        self.navigationController?.pushViewController(addItemVC, animated: true)
        //present modally
        //self.present(addItemVC, animated: true, completion: nil)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return array.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = array[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //edit
        // i can put this code inside button func
        let addItemVC =  storyboard?.instantiateViewController(identifier: "addVC") as! AddItemTableViewController
        addItemVC.addItemDelegate = self
        addItemVC.indexPathRow = indexPath.row
        addItemVC.itemName = array[indexPath.row]
        //push
        self.navigationController?.pushViewController(addItemVC, animated: true)
        
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            array.remove(at: indexPath.row)
            tableView.reloadData()
        }
    }

}

extension BucketListViewController: AddItemDelegate{
    func editItem(item: String, indexPathRow: Int) {
        array[indexPathRow] = item
        tableView.reloadData()
    }
    
    func addItem(item: String) {
        array.append(item)
        tableView.reloadData()
    }
}


//todo
//edit by selectrowat
