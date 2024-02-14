//
//  Location.swift
//  MapTest
//
//  Created by Awesomepia on 2/6/24.
//

import UIKit
import RealmSwift
import MapKit

class Location: Object {
    @objc dynamic var id = "" // primary key
    @objc dynamic var dispatch_id = ""
    @objc dynamic var date: String = ""
    @objc dynamic var latitude: Double = 0.0
    @objc dynamic var longitude: Double = 0.0
    
    override static func primaryKey() -> String? {
        return "id"
    }
}

class StationMarker: NSObject, MKAnnotation {
    let title: String?
    let coordinate: CLLocationCoordinate2D
    let subtitle: String?
    
    init(title: String?, coordinate: CLLocationCoordinate2D, subtitle: String?) {
        self.title = title
        self.coordinate = coordinate
        self.subtitle = subtitle
        
        super.init()
    }
}

class MapModel {
    let realm = try! Realm()
    
    func save(data: Location) {
        do {
            data.id = UUID().uuidString
            
            try self.realm.write {
                self.realm.add(data)
                
            }
            
        } catch {
            print("Error saving Location: \(error)")
            
        }
    }
    
    func read() -> Results<Location> {
        return self.realm.objects(Location.self)
    }
    
    func read(withId id: String) -> Location? {
        let data = self.realm.objects(Location.self).filter { $0.id == id }.first
        
        return data
    }
    
    func update(data: Location, date: String, latitude: Double, longitude: Double) {
        guard let data = self.read(withId: data.id) else { return }
        
        do {
            try self.realm.write {
                data.latitude = latitude
                data.longitude = longitude
                
            }
            
        } catch {
            print("Error deleting Location: \(error)")
            
        }
    }
    
    func delete(data: Location) {
        do {
            try realm.write {
                self.realm.delete(data)
                
            }
            
        } catch {
            print("Error deleting Location: \(error)")
            
        }
    }
    
    func deleteAll() {
        let data = self.realm.objects(Location.self)
        do {
            try self.realm.write {
                self.realm.delete(data)
                
            }
            
        } catch {
            print("Error deleting All Data: \(error)")
            
        }
    }
    
}

