//
//  PersistenceManager.swift
//  GHFollowers
//
//  Created by Mukthar Amiyan on 29/09/24.
//

import Foundation

enum PersistenceActionType {
    case add, remove
}

enum PersistenceManager {
    
    static private let defaults = UserDefaults.standard
    
    enum Keys {
        static let favourite = "favourites"
    }
    
    
    static func updateWith(favourite: Follower, actionType: PersistenceActionType, completed: @escaping (GFError?) -> Void) {
        retrieveFavorites { result in
            switch result {
            case .success(var favourites):
                switch actionType {
                case .add:
                    guard !favourites.contains(favourite) else {
                        completed(.alreadyInFavourites)
                        return
                    }
                    favourites.append(favourite)
                case .remove:
                    favourites.removeAll { $0.login == favourite.login }
                }
                
                completed(save(favourites: favourites))
                
            case .failure(let error):
                completed(error)
            }
            
        }
    }
    
    
    static func retrieveFavorites(completed: @escaping (Result<[Follower],GFError>)-> Void) {
        guard let favoritesData = defaults.object(forKey: Keys.favourite) as? Data else {
            completed(.success([]))
            return
        }
        
        do {
            let decoder   =   JSONDecoder()
            let favourites = try decoder.decode([Follower].self, from: favoritesData)
            completed(.success(favourites))
        } catch {
            completed(.failure(.unableToFavourite))
        }
    }
    
    
    static func save(favourites: [Follower]) -> GFError? {
        do {
            let encoder = JSONEncoder()
            let data    = try encoder.encode(favourites)
            defaults.set(data, forKey: Keys.favourite)
            return nil
        } catch {
            return .unableToFavourite
        }
    }
}
