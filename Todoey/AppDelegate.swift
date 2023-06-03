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



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Uygulama yüklendiğinde çağırılan yer, uygulamanın çökmesi önemli değil, burası çalışan ilk yer
        //print("ilk açılan yer")
        
        // for userdefault .. dosya yoluna ulaşmak için buraya işlem yapacağız NOT bu kod satırları simulator için ve kesinlikle kayıt işlemi için ilgili butonlara basmamız gerekiyor.
//        print(NSSearchPathForDirectoriesInDomains(<#T##directory: FileManager.SearchPathDirectory##FileManager.SearchPathDirectory#>, <#T##domainMask: FileManager.SearchPathDomainMask##FileManager.SearchPathDomainMask#>, <#T##expandTilde: Bool##Bool#>))
        
        //print(NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).last! )  // ilki dizin, ikincisi etki alanı, tilde yi genişletmek için true diyeceğiz ek olarak .last deme sebebimiz ise son öğeyi alma isteği.. ve sonucunu string olarak yazdıracağız. Uygulamamızı çalıştırdığımız anda console da dosya yolumuzu göreceğiz.
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // uygulama açıkken telefona bir şey olduğunda (örn, telefon çağrı alırsa) tetiklenme eğilimindedir. Uygulama veri kaybını önlemek için burada bir şeyler yapabiliriz. Diyelim ki bir form dolduruluyor ve o an telefon çaldı, çalmayla beraber tetiklendiği için kullanıcı verilerini kaybetmesin diye burada kayıt işlemi yapabilriz.
        print("telefon çaldığında")
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        // uygulamamız ekrandan kaybolduğunda, örn, ana ekran düğmesine basıldı veya farklı bir uygulamayı açtığımızda tetiklenir, yani uygulama artık görünmüyor ve arka plana giriyor.
        print("uygulamanın görünmediği yer.")
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        // uygulamamızın sonlandırılacağı noktadır, kullanıcı veya sistem tarafından tetiklenebilir, sistem tetiklemesi geçiş yapılan bir başka uygulama var ve kaynağı yoğun olarak kullanıyorsa örn bir oyun olabilir bu.. işte o zaman sistem tarafından kullanılan kaynakların çoğunu geri alabilir. Arka planda olsa bile, hala çalışan işlemleri olabilir ve iphone belleğini kullanıyor olabilir.. Bu gibi durumlarda, kaynaklar uygulamamızdan geri alındığında, uygulamamız arka planda olmaktan çıkar ve işletim sistemi sonlandırmaya veya kapatmaya başlar.
        print("uygulama kapatılıyor")
    }
    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }

    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "Todoey")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
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
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

}

