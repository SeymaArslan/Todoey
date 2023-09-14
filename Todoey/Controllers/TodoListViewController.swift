//
//  ViewController.swift
//  Todoey
//
//  Created by Seyma on 31.05.2023.
// Bu kullanımda Delegate oluşturma veya outlet bağlama gibi işlerimiz yok, her şeyi Xcode hallediyor

import UIKit

class TodoListViewController: UITableViewController {

    //var itemArray = ["Find Milk", "Buy Eggs", "Destory Demogorgon"]
    // 1) Her veriyi bir özellikle ilişkilendirme 
    // listeye fazlaca veri eklediğimizde check yaptığımız satırın dışında başka bir verinin de check olduğunu, işareeti kaldırdığımızda seçtiğimiz satırda da işaretin kalktığını görüyoruz ve bu çok saçma bir davranış.. Sebebine gelirsek; Tablo hücremizde aslında bir satır işaretliyoruz, ardından scroll ettiğimizde kendisine gelen bilgi seçili bir satır olduğu fakat kaydırma ile değişen ekranda seçili bir satır olmadığından tablo da dolaşır ve bir satırı işaretler. dequeueReusableCell yönteminde seçtiğimiz satır görünümde kaybolduğu noktada, tablo görünümünün etrafına gelir ve altta yeni bir tablo görünümü hücresi olarak yeniden başlatılır, yeniden kullanıldığı için, aksesuarı kontrol eden özellik hala burada mevcuttur işte bu yüzden bu tuhaf davranışla karşılaşıyoruz. Öte yandan let cell = UITableViewCell(style: .default, reuseIdentifier: "ToDoItemCell") hücreleri bu şekilde tanımlamış olsaydıkta ekranı kaydırdığımızda seçili bir satır yerine göreceğimiz şey, işaretlediğimiz satıra döndüğümüzde işaretimizin kaybolmasıdır, bunun nedeni ise işaretleme veya işareti kaldırmanın hücre üzerinde bir özellik ayarlıyor olmasıdır. Hücre ekrandan kaybolduğunda, ayrılmış ve yok edilmiş olur, geri eski yerine kaydırdığımızda aslında tablo hücresinin eklendiği yepyeni bir hücre almaktayız... Sorun şu ki, bir özelliği hücreyle değil verilerle ilişkilendirmemiz gerekiyor. Yani her hücreyi işaretli/işaretsiz özellikle ilişkilendirebilmemizin bir yoluna gerek duyuyoruz. Bu problemi MVC ile çözeceğiz
    var itemArray = [Item]()
    
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
    
    // for user default;
//    let defaults = UserDefaults.standard siliyoruz çünkü oluşturduğumuz (dataFilePath) yolda kendi plistimizi oluşturacağız
     
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(dataFilePath)

//        let newItem = Item()
//        newItem.title = "Find"
//        itemArray.append(newItem)
//        
//        let newItem2 = Item()
//        newItem.title = "Find"
//        itemArray.append(newItem)
//        
//        let newItem3 = Item()
//        newItem.title = "Find"
//        itemArray.append(newItem)
        
//        if let items = defaults.array(forKey: "ToDoListArray") as? [Item] { // as? [String] den [Item] a dönüştürüyoruz sebebi ise artık String dizi değil öğe dizisi almamız.
//            itemArray = items
//        }
        
        loadItems()
    }
    
//MARK: - TableView Datasource Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // burada 2 farklı tableView geliyor V sembolu olan global ve bu UITableViewController'ı alt sınıflandırarak elde ettiğimz şey, main üzerindeki tableView dan IBOutlet oluşturmamızla aynı şeydir. L sembolu olan lokal değişken buradaki metot parametrelerinden biri olarak gelir. Projemizde hangisini seçtiğimizin bir önemi yok çünkğü ikisi de aynı şeye atıfta bulunuyor
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
       
        let item = itemArray[indexPath.row]
        cell.textLabel?.text = item.title

        cell.accessoryType = item.done == true ? .checkmark : .none
        return cell
    }
    
//MARK: - TableView Delegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done

        saveItems()
        
        tableView.deselectRow(at: indexPath, animated: true) // ----> seçili satırın sürekli olarak renkli gösterilmesini engelliyor niiiiiice
    }

//MARK: - Add New Items
    @IBAction func AddButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField() // alertTextField kullanımı için
        
        let alert = UIAlertController(title: "Yeni Todoey Ekle", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Ekle", style: .default) { (action) in // bu alan butona basıldığında olmasını sağlayacağımız alan işte bu yüzden textfield alanını yazdırmak istiyorsak burada yapmalıyız, tetiklenen yer burası addTextField metodu değil orası sadece veri girişi için var.
            
            // what will happen once the user clicks add the item button or on our UIAlert
            
            // Item sınıfınfan oluşturduğumuz nesneleri textfield da göstermek için
            let newItem = Item()
            newItem.title = textField.text!
            
            self.itemArray.append(newItem)  // self.itemArray.append(textField.text!)
            
            // for User Default
//            self.defaults.set(self.itemArray, forKey: "TodoListArray")

            self.saveItems()
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
    
    
    //MARK: - Model Manipulation Methods
    func saveItems() {
        let encoder = PropertyListEncoder()
        do {
            let data = try encoder.encode(itemArray)
            try data.write(to: dataFilePath!)
        } catch {
            print("Error encoding item array, \(error)")
        }
        self.tableView.reloadData()
    }
    
    func loadItems() {
        if let data = try? Data(contentsOf: dataFilePath!) {
            let decoder = PropertyListDecoder()
            do {
                itemArray = try decoder.decode([Item].self, from: data)
            } catch {
                print("Error decoding item array, \(error)")
            }
            
        }
    }
    
}

