//
//  ViewController.swift
//  Todoey
//
//  Created by Seyma on 31.05.2023.
// Bu kullanımda Delegate oluşturma veya outlet bağlama gibi işlerimiz yok, her şeyi Xcode hallediyor

import UIKit

class TodoListViewController: UITableViewController {

    var itemArray = ["Find Milk", "Buy Eggs", "Destory Demogorgon"]
    
    // for user default;
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // çökme olmasın diye if-let kullanacağız
        if let items = defaults.array(forKey: "TodoListArray") as? [String] {
            itemArray = items
        }
    }
    
//MARK: - TableView Datasource Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // burada 2 farklı tableView geliyor V sembolu olan global ve bu UITableViewController'ı alt sınıflandırarak elde ettiğimz şey, main üzerindeki tableView dan IBOutlet oluşturmamızla aynı şeydir. L sembolu olan lokal değişken buradaki metot parametrelerinden biri olarak gelir. Projemizde hangisini seçtiğimizin bir önemi yok çünkğü ikisi de aynı şeye atıfta bulunuyor
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        cell.textLabel?.text = itemArray[indexPath.row]
        return cell
    }
    
//MARK: - TableView Delegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        }   else {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark  // belirli bir dizin yolunda bulunan hücreye bir referans alır, belirlediğimiz dizin yolu ise bu metotta seçtiğimiz ve aksesuar kullanmamıza izin verecek.
        }
        
        tableView.deselectRow(at: indexPath, animated: true) // ----> seçili satırın sürekli olarak renkli gösterilmesini engelliyor niiiiiice
    }

//MARK: - Add New Items
    @IBAction func AddButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField() // alertTextField kullanımı için
        
        let alert = UIAlertController(title: "Yeni Todoey Ekle", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Ekle", style: .default) { (action) in // bu alan butona basıldığında olmasını sağlayacağımız alan işte bu yüzden textfield alanını yazdırmak istiyorsak burada yapmalıyız, tetiklenen yer burası addTextField metodu değil orası sadece veri girişi için var.
            
            // what will happen once the user clicks add the item button or on our UIAlert
            //print(textField.text)
            
            self.itemArray.append(textField.text!)
            
            // for User Default
            self.defaults.set(self.itemArray, forKey: "TodoListArray")
            
            self.tableView.reloadData()
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Yeni item"
            //print(alertTextField.text) // burada hata aldık sebebiyse print closure içerisinde ve butona basıldığında neler olacağı zaten yukarıdaki metotta var. Fakat biz burada textfield içeriğine ne yazıldığını almak istiyoruz çünkü kullanacağız.. o halde IBAction içerisinde yerel bir değişken oluşturursak bu problemi çözeriz.
            textField = alertTextField
        }
        
        alert.addAction(action)  // aciton sabitimizi eklediğimiz yer.
        
        // present(<#T##viewControllerToPresent: UIViewController##UIViewController#>, animated: <#T##Bool#>)
        present(alert, animated: true, completion: nil)
        
        
    }
    
}

