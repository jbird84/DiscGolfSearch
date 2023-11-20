//
//  BagDatabaseService.swift
//  DiscGolfSearch
//
//  Created by Kinney Kare on 11/18/23.
//

import UIKit
import SwiftData

class BagDatabaseService {
    
    static var shared = BagDatabaseService()
    var container: ModelContainer?
    var context: ModelContext?
    
    init() {
        do {
            container = try ModelContainer(for: BagSwiftDataModel.self)
            if let container {
                context = ModelContext(container)
            }
        } catch {
            print(error)
        }
    }
    
    
    //MARK: Saving Bags
    func saveBag(bagName: String, bagType: String, bagHexColor: String, viewController: UIViewController) {
        
            if let context {
                let bagToBeSaved = BagSwiftDataModel(id: UUID().uuidString, bagHexColor: bagHexColor, bagTitle: bagName, bagType: bagType)
                 context.insert(bagToBeSaved)
            } else {
            print("ERROR SAVING BAG!")
                // Show an alert to the user
                let alert = UIAlertController(title: "Error", message: "An error occurred while saving this bag data.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                viewController.present(alert, animated: true, completion: nil)
        }
    }


    func fetchDiscBagList(onCompletion:@escaping([BagSwiftDataModel]?,Error?)->(Void)){
            
        let descriptor = FetchDescriptor<BagSwiftDataModel>(sortBy: [SortDescriptor<BagSwiftDataModel>(\.bagTitle)])
            if let context{
                do{
                    let data = try context.fetch(descriptor)
                    onCompletion(data,nil)
                }
                catch{
                    onCompletion(nil,error)
                }
            }
       }

    func update(bag: BagSwiftDataModel, newBagName: String){
           let bagToBeUpdated = bag
        bagToBeUpdated.bagTitle = newBagName
        //Finish rest of changes here:
       }

    func deleteBagFromBagView(bag: BagSwiftDataModel){
            let bagToBeDeleted = bag
            if let context{
                context.delete(bagToBeDeleted)
            }
        }
}



