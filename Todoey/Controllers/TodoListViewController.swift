//
//  ViewController.swift
//  Todoey
//
//  Created by Seyma on 31.05.2023.
//

import UIKit
import CoreData

class TodoListViewController: UITableViewController {
    
    var itemArray = [Item]()
    
    var selectedCategory: Category? {
        didSet{
//            loadItems()
        }
    }
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
        
    }
    
    //MARK: - TableView Datasource Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        let item = itemArray[indexPath.row]
        cell.textLabel?.text = item.title
        
        cell.accessoryType = item.done == true ? .checkmark : .none
        return cell
    }
    
    
    //MARK: - TableView Delegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //        itemArray[indexPath.row].setValue(<#T##value: Any?##Any?#>, forKey: <#T##String#>) güncelleme ama el ile gibi düşünelim
        
        //        context.delete(itemArray[indexPath.row])  // safeArea dan sil (kalıcı depodan) fakat yeniden yükleme yapmadığımız sürece sildiklerimizi göremeyiz, bunu da ardından gelen saveItems func ile yapacak
        //        itemArray.remove(at: indexPath.row) // görünümden sil
        
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        
        saveItems()
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    //MARK: - Add New Items
    @IBAction func AddButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Yeni İçerik Ekle", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Ekle", style: .default) { (action) in
            
//            let newItem = Item(context: self.context)   // buradaki context bilgisi Appdelegate te saveContext te ki persistentContainer dan geliyor
//            newItem.title = textField.text!
//            newItem.done = false // Coredata da done optional değil bu yüzden hata atıyor atmasın diye varsayılan olarak değer verdik
//            newItem.parentCategory = self.selectedCategory
//            self.itemArray.append(newItem)
            
            self.saveItems()
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Yeni içerik"
            textField = alertTextField
        }
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
        
    }
    
    
    //MARK: - Model Manipulation Methods
    func saveItems() {
        
        do {
            try context.save()
        } catch {
            print("Error saving context \(error)")
        }
        self.tableView.reloadData()
    }
    
//    func loadItems(with request: NSFetchRequest<Item> = Item.fetchRequest(), predicate: NSPredicate? = nil) {
//        let categoryPredicate = NSPredicate(format: "parentCategory.name MATCHES %@", selectedCategory!.name!)
//
//        if let addtionalPredicate = predicate {
//            request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [categoryPredicate, addtionalPredicate])
//        } else {
//            request.predicate = categoryPredicate
//        }
//
//        do {
//            itemArray = try context.fetch(request)  // burası bir Item dizisi döndürüyor ki request i tanımlarken kullandık. NSFetchRequest<Item> belirtmezsek hata alırız ve itemArray olarak tanımladığımızda tablo görünümünde değerleri görürüz
//        } catch {
//            print("Error fetching data from context \(error)")
//        }
//        tableView.reloadData()
//    }
    
    
}


//MARK: - SearchBar Methods
//extension TodoListViewController: UISearchBarDelegate {
//    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
//        let request: NSFetchRequest<Item> = Item.fetchRequest()
//
//        let predicate = NSPredicate(format: "title CONTAINS[cd] %@", searchBar.text!)
//
//        request.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)] // NSSortDescriptor bir dizi bekler her ne kadar tek bir sıralama filtremiz varsa da [] içerisine alacağız
//
//        loadItems(with: request, predicate: predicate)
//
//    }
//
//    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//        if searchBar.text?.count == 0 {
//            loadItems()
//
//            DispatchQueue.main.async {
//                searchBar.resignFirstResponder()  // searchBar da ilk duruma dönme yani imleç gidiyor ve klavye kapanıyor
//            }
//
//        }
//    }
//}
