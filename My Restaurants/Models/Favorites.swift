//
//  File.swift
//  My Restaurants
//
//  Created by Eugene Lysenko on 13.07.2021.
//

#if !os(macOS)
import UIKit
#endif

protocol FavoritesProtocol: AnyObject {
    func favoritesChanged(empty: Bool)
}

class Favorites {
    
    weak var delegate: FavoritesProtocol?
    
    var data: Array = [String]()
    
    init() {
        load()
    }
    
    func add(resId: String) {
        let ind = find(resId:resId)
        if (ind == -1) {
            data.append(resId)
            save()
        }
    }
    
    func remove(resId: String) {
        let ind = find(resId:resId)
        if (ind == -1) {
            return
        }
        data.remove(at: ind)
        save()
    }
    
    func find(resId: String) -> Int {
        var ind: Int = 0
        for item in data {
            if item == resId {
                return ind
            }
            ind += 1
        }
        return -1
    }
    
    func exists(resId: String) -> Bool {
        return find(resId:resId) != -1
    }
    
    func empty() -> Bool {
        return data.count == 0
    }
    
    func dump() {
        var ind: Int = 0
        for item in data {
            print("\(ind) \(item)")
            ind += 1
        }
        print("---")
    }
    
    func flash() {
        data.removeAll()
    }
    
    func indicate() {
        guard (delegate != nil) else {
            return
        }
        delegate?.favoritesChanged(empty: empty())
    }
    
    func load() {
#if !os(macOS)
        let defaults = UserDefaults.standard
        data = defaults.stringArray(forKey: Settings.favoritesName) ?? [String]()
        indicate()
#endif
    }
    
    func save() {
#if !os(macOS)
        let defaults = UserDefaults.standard
        defaults.set(data, forKey: Settings.favoritesName)
        indicate()
#endif
    }
    
}
