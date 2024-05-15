//
//  Defaults.swift
//  AppcentNews
//
//  Created by oguzhan on 15.05.2024.
//

import Foundation

struct Defaults {
    
    private enum Keys {
        static let favorites = "Favorites"
    }
    
    static var favoriteNewsIDs: [String] {
        get {
            return UserDefaults.standard.stringArray(forKey: Keys.favorites) ?? []
        }
        set {
            UserDefaults.standard.setValue(newValue, forKey: Keys.favorites)
        }
    }
    
    static func addFavorite(newsID: String) {
        if !favoriteNewsIDs.contains(newsID) {
            var updatedFavorites = favoriteNewsIDs
            updatedFavorites.append(newsID)
            favoriteNewsIDs = updatedFavorites
        }
    }
    
    static func removeFavorite(newsID: String) {
        let updatedFavorites = favoriteNewsIDs.filter { $0 != newsID }
        favoriteNewsIDs = updatedFavorites
    }
    
    static func isFavorite(newsID: String) -> Bool {
        return favoriteNewsIDs.contains(newsID)
    }
}
