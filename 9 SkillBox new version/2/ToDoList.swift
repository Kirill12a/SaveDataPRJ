//
//  ToDoList.swift
//  9 SkillBox new version
//
//  Created by Kirill Drozdov on 21.03.2021.
//

import Foundation
import RealmSwift

class ToDoListItem: Object{
    @objc dynamic var name = ""
    @objc dynamic var done = false
}
