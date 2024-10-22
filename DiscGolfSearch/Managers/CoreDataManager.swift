//
//  CoreDataManager.swift
//  DiscGolfSearch
//
//  Created by Kinney Kare on 12/4/23.
//

import UIKit
import CoreData
import OSLog

extension Notification.Name {
    static let persistentStoreLoadError = Notification.Name("persistentStoreLoadError")
}

class CoreDataManager {
    
    static let shared = CoreDataManager(modelName: "DiscGolfSearch", persistentContainer: NSPersistentCloudKitContainer(name: "DiscGolfSearch"))
    
    private let modelName: String
    private let persistentContainer: NSPersistentCloudKitContainer
    
    // MARK: - Initialization
    
    init(modelName: String, persistentContainer: NSPersistentCloudKitContainer) {
        self.modelName = modelName
        self.persistentContainer = persistentContainer
        loadPersistentStores()
    }
    
    // MARK: - Core Data Operations
    func saveContext() {
        guard persistentContainer.viewContext.hasChanges else { return }
        
        do {
            try persistentContainer.viewContext.save()
        } catch {
            let nsError = error as NSError
            // Handle error appropriately (e.g., show an alert)
            print("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
    
    // Expose viewContext for direct access
    var managedContext: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    // MARK: - Fetch Request
    
    func fetch<T: NSManagedObject>(_ objectType: T.Type, predicate: NSPredicate? = nil) -> Result<[T], Error>  {
        let entityName = String(describing: objectType)
        let fetchRequest = NSFetchRequest<T>(entityName: entityName)
        
        if let predicate = predicate {
            fetchRequest.predicate = predicate
        }
        
        do {
            let result = try persistentContainer.viewContext.fetch(fetchRequest)
            return .success(result)
        } catch {
            os_log("Error fetching data: %@", log: OSLog.default, type: .error, error.localizedDescription)
            return .failure(error)
        }
    }
    
    // MARK: - Delete
    func delete(_ object: NSManagedObject) {
        persistentContainer.viewContext.delete(object)
        saveContext()
    }
    
    private func loadPersistentStores() {
        persistentContainer.loadPersistentStores { (storeDescription, error) in
            if let error = error as NSError? {
                // Log the error
                os_log("Unresolved error: %@", log: OSLog.default, type: .error, error.userInfo)
                // Post a notification for error handling
                NotificationCenter.default.post(name: .persistentStoreLoadError, object: nil, userInfo: ["error": error])
            }
        }
    }
}
