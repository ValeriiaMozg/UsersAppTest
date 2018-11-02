//
//  CoreDataManager.swift
//  UsersListApp
//
//  Created by Lera Mozgovaya on 10/30/18.
//  Copyright © 2018 Lera Mozgovaya. All rights reserved.
//

import CoreData
import UIKit

final class CoreDataManager {
    
    static let shared = CoreDataManager(modelName: "UsersListApp")
    
    private let modelName: String
    
    init(modelName: String) {
        self.modelName = modelName
    }
    
    private(set) lazy var managedObjectContext: NSManagedObjectContext = {
        let managedObjectContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        
        managedObjectContext.persistentStoreCoordinator = self.persistentStoreCoordinator
        
        return managedObjectContext
    }()
    
    private lazy var managedObjectModel: NSManagedObjectModel = {
        guard let modelURL = Bundle.main.url(forResource: self.modelName, withExtension: "momd") else {
            fatalError("Unable to find Data Model")
        }
        
        guard let managedObjectModel = NSManagedObjectModel(contentsOf: modelURL) else {
            fatalError("Unable to load Data Model")
        }
        
        return managedObjectModel
    }()
    
    private lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator = {
        let pesistentStoreCoordinator = NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModel)
        
        let fileManager = FileManager.default
        let storeName = "\(self.modelName).sqlite"
        
        let documentsDirectoryURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0]
        
        let persistentStoreURL = documentsDirectoryURL.appendingPathComponent(storeName)
        
        do {
            try pesistentStoreCoordinator.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: persistentStoreURL, options: nil)
        }
        catch {
            fatalError("Unable to Add Persistent Store")
        }
        
        return pesistentStoreCoordinator
    }()
    
    func saveContext() {
        guard managedObjectContext.hasChanges else { return }
        
        do {
            try managedObjectContext.save()
        } catch {
            print("Unable to Save Managed Object Context")
            print("\(error), \(error.localizedDescription)")
        }
    }
}

extension CoreDataManager {
    
    func saveUser(_ user: UserDisplayModel, completion: () -> Void) {
        
        var userEntity: UserEntity?
        
        if let userEn = fetchUser(user) {
            userEntity = userEn
        }
        else {

            userEntity = UserEntity(context: managedObjectContext)
            userEntity?.userId = user.userId

            let pictureEn = PictureEntity(context: managedObjectContext)
            pictureEn.large = user.avatarLarge
            pictureEn.thumbnail = user.avatarTrumb
            
            userEntity?.picture = pictureEn
        }
        
        userEntity?.email = user.email
        userEntity?.firstname = user.name
        userEntity?.lastname = user.lastname
        userEntity?.phone = user.phone
        
        saveContext()
        completion()
    }
    
    func updateAvatar(_ user: UserDisplayModel) {
        
        guard let userEntity = fetchUser(user) else { return }
        
        let data = user.userPickedAvatar?.jpegData(compressionQuality: 1)
        
        userEntity.picture?.userLoadedAvatar = data
        
        saveContext()
    }
    
    func fetchUser(_ user: UserDisplayModel) -> UserEntity? {
        
        let fetchRequest: NSFetchRequest<UserEntity> = UserEntity.fetchRequest()
        
        let predicate = NSPredicate(format: "%K = %@", #keyPath(UserEntity.userId), user.userId)
        
        fetchRequest.predicate = predicate
        
        do {
            let result = try managedObjectContext.fetch(fetchRequest)
            if result.count > 0 {
                return result.first
            }
        }
        catch {
            return nil
        }
        
        return nil
    }
    
    func fetchUsers() -> [UserEntity]? {
        
        let fetchRequest: NSFetchRequest<UserEntity> = UserEntity.fetchRequest()
       
        do {
            let result = try managedObjectContext.fetch(fetchRequest)
            if result.count > 0 {
                return result
            }
        }
        catch {
            return nil
        }
        
        return nil
    }
    
    func deleteUser(_ user: UserDisplayModel) {
        
        let fetchRequest: NSFetchRequest<UserEntity> = UserEntity.fetchRequest()
        
        let predicate = NSPredicate(format: "%K = %@", #keyPath(UserEntity.userId), user.userId)
        
        fetchRequest.predicate = predicate
        
        let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest as! NSFetchRequest<NSFetchRequestResult>)
        
        do {
            try self.managedObjectContext.execute(batchDeleteRequest)
            saveContext()
        } catch {
            print(error.localizedDescription)
        }
    }
}

