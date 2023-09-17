//
//  CategoryTableViewController.swift
//  Todoey
//
//  Created by Seyma on 17.09.2023.
//

import UIKit
import RealmSwift

class CategoryTableViewController: UITableViewController {

    let realm = try! Realm()
    
    var categories = [Category]()
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
        
        loadCategories()
    }
    
    
    //MARK: - TableView data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        
        cell.textLabel?.text = categories[indexPath.row].name
        
        return cell
    }
    
    
    //MARK: - TableView Delegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToItems", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! TodoListViewController
        
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedCategory = categories[indexPath.row]
        }
    }
    
    //MARK: - Data Manipulation Methods
    func save(category: Category) {
        do {
            try realm.write({
                realm.add(category)
            })
        } catch {
            print("error: \(error)")
        }
        tableView.reloadData()
    }
    
    func loadCategories() {
//        let request: NSFetchRequest<Category> = Category.fetchRequest()
//
//        do {
//            categories = try context.fetch(request)
//        } catch {
//            print("error: \(error)")
//        }
//        tableView.reloadData()
    }
    
    
    
    //MARK: - Add new Category
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        let alert = UIAlertController(title: "Yeni Kategori Ekle", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Ekle", style: .default) { (action) in
            
            let newCategory = Category()
            newCategory.name = textField.text!
            
            
            self.categories.append(newCategory)
            
            self.save(category: newCategory)
        }
        alert.addAction(action)
        alert.addTextField { (alertTextField) in
            textField = alertTextField
            alertTextField.placeholder = "Yeni Kategori"
        }
    
        present(alert, animated: true, completion: nil)
    }

    
    
}
