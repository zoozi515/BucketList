//
//  ViewController.swift
//  BucketList
//
//  Created by administrator on 05/01/2022.
//

import UIKit
import CoreData

class BucketListViewController: UITableViewController {
    
    //#1
    let managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    var cars = [Cars]() //#0
    //var array: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add", style:.plain, target: self, action: #selector(self.addTabbed))
        
    }

    //#2
    override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            fetchAllItems()
    }
    
    @objc func addTabbed(){
        // i can put this code inside button func
        let addItemVC =  storyboard?.instantiateViewController(identifier: "addVC") as! AddItemTableViewController
        addItemVC.addItemDelegate = self
        
        //present modally
        self.present(addItemVC, animated: true, completion: nil)
    }
    
    //#3
    func fetchAllItems() {
            let itemRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Cars")
            
            do {
                let result = try managedObjectContext.fetch(itemRequest)
                cars = result as! [Cars]
                
                for car in cars {
                    print(car.name!)
                    print("Success")
                }
            } catch {
                print("\(error)")
            }
            
            tableView.reloadData()
        }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cars.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        //cell.textLabel?.text = array[indexPath.row]
        cell.textLabel?.text = cars[indexPath.row].name //#5
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //edit
        // i can put this code inside button func
        let addItemVC =  storyboard?.instantiateViewController(identifier: "addVC") as! AddItemTableViewController
        addItemVC.addItemDelegate = self
        addItemVC.indexPathRow = indexPath.row
        addItemVC.itemName = cars[indexPath.row].name //#6
        //present modally
        self.present(addItemVC, animated: true, completion: nil)
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            //array.remove(at: indexPath.row)
            //tableView.reloadData()
            
            let removeCar = cars[indexPath.row] //#7
            managedObjectContext.delete(removeCar)
            do {
                    try managedObjectContext.save()
            }
            catch {}
            fetchAllItems()
        }
    }

}

extension BucketListViewController: AddItemDelegate{
    func editItem(item: String, indexPathRow: Int) {
       
        cars[indexPathRow].name = item //#8
        if managedObjectContext.hasChanges {
            do {
                try managedObjectContext.save()
                print("Success \(cars[indexPathRow].name)")
            } catch {
                print("\(error.localizedDescription)")
            }
        }
        self.fetchAllItems()

        //array[indexPathRow] = item
        //tableView.reloadData()
    }
    
    func addItem(item: String) {
        //#4
        let cars = NSEntityDescription.insertNewObject(forEntityName: "Cars", into: managedObjectContext) as! Cars
        cars.name = item
        guard let myCar = cars.name else { return }
                
        if managedObjectContext.hasChanges {
            do {
                try managedObjectContext.save()
                print("Success \(myCar)")
            } catch {
                print("\(error.localizedDescription)")
            }
        }
        //array.append(item)
        //tableView.reloadData()
    }
}
