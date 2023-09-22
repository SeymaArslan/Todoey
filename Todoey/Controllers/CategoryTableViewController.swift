//
//  CategoryTableViewController.swift
//  Todoey
//
//  Created by Seyma on 17.09.2023.
//

import UIKit
import RealmSwift
import ChameleonFramework

class CategoryTableViewController: SwipeTableViewController {

    let realm = try! Realm()
    var categories: Results<Category>?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadCategories()
        
        tableView.separatorStyle = .none  // renk kenarlılarının keskinliğini önlemek için

    }
    
    override func viewWillAppear(_ animated: Bool) {
        guard let navBar = navigationController?.navigationBar else {
            fatalError("")
        }
        navBar.backgroundColor = .systemBackground
        navBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor(hexString: "5856D6")]
        navigationController?.navigationBar.tintColor = UIColor(hexString: "5856D6")
        
        
        
        
    }
    
    
    
    //MARK: - TableView data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = super.tableView(tableView, cellForRowAt: indexPath)
        
        if let category = categories?[indexPath.row] {
            cell.textLabel?.text = category.name
            
            guard let categoryColour = UIColor(hexString: category.colour) else {
                fatalError()
            }
            
            cell.backgroundColor = categoryColour // hexValue return String color
            cell.textLabel?.textColor = ContrastColorOf(categoryColour, returnFlat: true)
        }
    
        
        return cell
    }
    
    
    
    //MARK: - TableView Delegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToItems", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! TodoListViewController
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedCategory = categories?[indexPath.row]
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
        categories = realm.objects(Category.self)
        tableView.reloadData()
    }
    
    
    
    //MARK: - Delete data from Swipe
    override func updateModel(at indexPath: IndexPath) {
        
        // swipeTableViewCont da oluşturduğumuz updateModel fonksiyonunda ki print ifadesini kullanmak istersek
        super.updateModel(at: indexPath)
        
        if let categoryForDeletion = self.categories?[indexPath.row] {
            do {
                try self.realm.write{
                    self.realm.delete(categoryForDeletion)                    }
            } catch {
                print("Kategori silinirken hata oluştu, \(error)")
            }
        }
    }
    
    
    
    //MARK: - Add new Category
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        let alert = UIAlertController(title: "Yeni Kategori Ekle", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Ekle", style: .default) { (action) in
            
            let newCategory = Category()
            newCategory.name = textField.text!
            newCategory.colour = UIColor.randomFlat().hexValue()
            
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




