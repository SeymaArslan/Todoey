//
//  AppDelegate.swift
//  Todoey
//
//  Created by Seyma on 31.05.2023.
//

import UIKit
import CoreData

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Uygulama yüklendiğinde çağırılan yer, uygulamanın çökmesi önemli değil, burası çalışan ilk yer
        //print("ilk açılan yer")
        
        // for userdefault .. dosya yoluna ulaşmak için buraya işlem yapacağız NOT bu kod satırları simulator için ve kesinlikle kayıt işlemi için ilgili butonlara basmamız gerekiyor.
//        print(NSSearchPathForDirectoriesInDomains(<#T##directory: FileManager.SearchPathDirectory##FileManager.SearchPathDirectory#>, <#T##domainMask: FileManager.SearchPathDomainMask##FileManager.SearchPathDomainMask#>, <#T##expandTilde: Bool##Bool#>))
        
        //print(NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).last! )  // ilki dizin, ikincisi etki alanı, tilde yi genişletmek için true diyeceğiz ek olarak .last deme sebebimiz ise son öğeyi alma isteği.. ve sonucunu string olarak yazdıracağız. Uygulamamızı çalıştırdığımız anda console da dosya yolumuzu göreceğiz.
        
        return true
    }

    
    func applicationWillTerminate(_ application: UIApplication) {
//        print("uygulama kapatılıyor")
        self.saveContext()
    }
    

    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Todoey")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

}

