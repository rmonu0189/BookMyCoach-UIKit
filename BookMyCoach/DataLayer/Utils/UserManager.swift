//
//  UserManager.swift
//  BookMyCoach
//
//  Created by Bharat Lal on 11/28/20.
//

import Foundation

class UserManager: NSObject, ObservableObject {
    
    // MARK: Declaration for string constants to be used to decode and also serialize.
    private struct SerializationKeys {
        static let activeUser = "com.bookmycoach.activeUser"
        static let accessToken = "com.bookmycoach.accessToken"
    }
    
    fileprivate var _activeUser: User?
    
    var backupSalt: Data?
    var openItemToastShown = false
    
    // MARK: - Singleton Instance
    class var shared: UserManager {
        struct Singleton {
            static let instance = UserManager()
        }
        return Singleton.instance
    }
    
    fileprivate override init() {
        super.init()
        // Load last logged user data if exists
        if isLoggedInUser() {
            loadActiveUser()
        }
    }
    
    var accessToken: String? {
        get {
            return UserDefaults.standard.value(forKey: SerializationKeys.accessToken) as? String
        }
        set {
            UserDefaults.standard.setValue(newValue, forKey: SerializationKeys.accessToken)
        }
    }
    
    var activeUser: User? {
        get {
            return _activeUser
        }
        set {
            _activeUser = newValue
            if _activeUser != nil {
                saveActiveUser()
            }
        }
    }
    
    func isLoggedInUser() -> Bool {
        guard UserDefaults.standard.value(forKey: SerializationKeys.activeUser) != nil else {
            return false
        }
        return true
    }
    
    func loadActiveUser() {
        guard let decodedUser = UserDefaults.standard.value(forKey: SerializationKeys.activeUser) as? Data else { return }
        do {
            activeUser = try JSONDecoder().decode(User.self, from: decodedUser)
        } catch {
            print(error)
        }
    }

    func saveActiveUser() {
        do {
            let data = try JSONEncoder().encode(activeUser)
            UserDefaults.standard.set(data, forKey: SerializationKeys.activeUser)
            UserDefaults.standard.synchronize()
        } catch {
            print(error)
        }
    }
    
    func deleteActiveUser() {
        UserDefaults.standard.removePersistentDomain(forName: Bundle.main.bundleIdentifier!)
        UserDefaults.standard.synchronize()
        self.activeUser = nil
    }

}
