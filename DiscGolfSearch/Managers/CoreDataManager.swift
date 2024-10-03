//
//  CoreDataManager.swift
//  DiscGolfSearch
//
//  Created by Kinney Kare on 12/4/23.
//

import UIKit
import CoreData

class CoreDataManager {
    
    static let shared = CoreDataManager(modelName: "DiscGolfSearch", persistentContainer: NSPersistentCloudKitContainer(name: "DiscGolfSearch"))
    
    private let modelName: String
    private let persistentContainer: NSPersistentCloudKitContainer
    
    // MARK: - Initialization
    
    init(modelName: String, persistentContainer: NSPersistentCloudKitContainer) {
        self.modelName = modelName
        self.persistentContainer = persistentContainer
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
            print("Error fetching data: \(error.localizedDescription)")
            return .failure(error)
        }
    }
   
    
    //SAVE ALL DISCS HERE
    func saveAllDiscs(_ discs: [DiscGolfDisc]) {
        // Clear existing data if needed
        let fetchRequest: NSFetchRequest<DiscsInfoEntity> = DiscsInfoEntity.fetchRequest()
        do {
                    let existingEntities = try persistentContainer.viewContext.fetch(fetchRequest)
                    for entity in existingEntities {
                        persistentContainer.viewContext.delete(entity)
                    }
                } catch {
                    print("Error clearing existing discs: \(error.localizedDescription)")
                }
        
        // Save new discs
                for disc in discs {
                    let entity = DiscsInfoEntity(context: persistentContainer.viewContext)
                    entity.id = disc.id
                    entity.name = disc.name
                    entity.brand = disc.brand
                    entity.category = disc.category
                    entity.speed = disc.speed
                    entity.glide = disc.glide
                    entity.turn = disc.turn
                    entity.fade = disc.fade
                    entity.stability = disc.stability
                    entity.link = disc.link
                    entity.pic = disc.pic
                    entity.nameSlug = disc.nameSlug
                    entity.brandSlug = disc.brandSlug
                    entity.color = disc.color
                    entity.backgroundColor = disc.backgroundColor
                    entity.usedFor = disc.usedFor
                    entity.plasticType = disc.plasticType
                    entity.discWeight = disc.discWeight
                    entity.discColor = disc.discColor
                }
                saveContext()
    }
    
    // MARK: - Fetch All Discs
        func fetchAllDiscs() -> [DiscGolfDisc] {
            let fetchRequest: NSFetchRequest<DiscsInfoEntity> = DiscsInfoEntity.fetchRequest()
            
            do {
                let entities = try persistentContainer.viewContext.fetch(fetchRequest)
                return entities.map { entity in
                    DiscGolfDisc(
                        id: entity.id ?? "",
                        name: entity.name ?? "",
                        brand: entity.brand ?? "",
                        category: entity.category ?? "",
                        speed: entity.speed ?? "",
                        glide: entity.glide ?? "",
                        turn: entity.turn ?? "",
                        fade: entity.fade ?? "",
                        stability: entity.stability ?? "",
                        link: entity.link ?? "",
                        pic: entity.pic ?? "",
                        nameSlug: entity.nameSlug ?? "",
                        brandSlug: entity.brandSlug ?? "",
                        color: entity.color ?? "",
                        backgroundColor: entity.backgroundColor ?? "",
                        usedFor: entity.usedFor,
                        plasticType: entity.plasticType,
                        discWeight: entity.discWeight,
                        discColor: entity.discColor
                    )
                }
            } catch {
                print("Error fetching all discs: \(error.localizedDescription)")
                return []
            }
        }
    
    // MARK: - Delete
    func delete(_ object: NSManagedObject) {
        persistentContainer.viewContext.delete(object)
        saveContext()
    }
}
