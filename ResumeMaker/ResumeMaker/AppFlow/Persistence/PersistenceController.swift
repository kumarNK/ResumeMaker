//
//  PersistenceController.swift
//  ResumeMaker
//
//  Created by Narender Kumar on 29/04/2022.
//


import Disk
import RealmSwift
import UIKit

class PersistenceController {
    static let shared = PersistenceController()
    
    private init() {}
    
    func add(image: UIImage, path: String) throws {
        try Disk.save(image, to: .documents, as: path)
    }
    
    func get(path: String) -> UIImage? {
        return try? Disk.retrieve(path, from: .documents, as: UIImage.self)
    }
    
    func add<Element: Object>(entity: Element) throws {
        let realm = try Realm()
        try realm.write {
            realm.add(entity, update: .modified)
        }
    }
    
    func add<Element: Object>(entities: [Element]) throws {
        let realm = try Realm()
        realm.beginWrite()
        realm.add(entities, update: .modified)
        try realm.commitWrite()
    }
    
    func get<Element: Object, Key>(
        ofType type: Element.Type,
        forPrimaryKey key: Key
    ) throws -> Element?  {
        let realm = try Realm()
        let object = realm.object(ofType: type, forPrimaryKey: key)
        return object
    }
    
    func get<Element: Object>(ofType type: Element.Type) throws -> Element?  {
        let objects: [Element] = try get()
        return objects.first
    }
    
    func get<Element: Object>() throws -> [Element] {
        let realm = try Realm()
        let results = realm.objects(Element.self)
        return Array(results)
    }
    
    func update<Result>(_ block: (() throws -> Result)) throws {
        let realm = try Realm()
        try realm.write(block)
    }
    
    func delete<Element: Object>(entity: Element) throws {
        let realm = try Realm()
        try realm.write {
            realm.delete(entity)
        }
    }
}
