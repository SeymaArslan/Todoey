//
//  ViewController.swift
//  Todoey
//
//  Created by Seyma on 31.05.2023.
// Bu kullanımda Delegate oluşturma veya outlet bağlama gibi işlerimiz yok, her şeyi Xcode hallediyor

import UIKit

class TodoListViewController: UITableViewController {

    let itemArray = ["Find Milk", "Buy Eggs", "Destory Demogorgon"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
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


}

