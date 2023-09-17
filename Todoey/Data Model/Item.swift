//
//  Item.swift
//  Todoey
//
//  Created by Seyma on 17.09.2023.
//

import Foundation
import RealmSwift

class Item: Object {
    @objc dynamic var title: String = ""
    @objc dynamic var done: Bool = false
    var parentCategory = LinkingObjects(fromType: Category.self, property: "items")  // LinkingObjects, bir özellik ilişkisi aracılığıyla sahibi olduğu model nesnesine bağlanan 0 veya daha fazla nesneyi temsil eden otomatik güncellenen kapsayıcılardır. Özetle bu sadece öğelerin ters ilişkisini tanımlamaktadır. 
}
