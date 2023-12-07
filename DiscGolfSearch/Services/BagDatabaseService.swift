////
////  BagDatabaseService.swift
////  DiscGolfSearch
////
////  Created by Kinney Kare on 11/18/23.
////
//
//import UIKit
//import SwiftData
//
//class BagDatabaseService {
//    
//    static var shared = BagDatabaseService()
//    var container: ModelContainer?
//    var context: ModelContext?
//    
//    init() {
//        do {
//            container = try ModelContainer(for: BagSwiftDataModel.self)
//            if let container {
//                context = ModelContext(container)
//            }
//        } catch {
//            print("Swift Data Error: \(error)")
//        }
//    }
//    
//    //MARK: BAGS
//    //MARK: Saving Bags
//    func saveBag(bagName: String, bagType: String, bagHexColor: String, viewController: UIViewController) {
//        
//        if let context {
//            let bagToBeSaved = BagSwiftDataModel(id: UUID().uuidString, bagHexColor: bagHexColor, bagTitle: bagName, bagType: bagType)
//            context.insert(bagToBeSaved)
//        } else {
//            print("ERROR SAVING BAG!")
//            // Show an alert to the user
//            let alert = UIAlertController(title: "Error", message: "An error occurred while saving this bag data.", preferredStyle: .alert)
//            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
//            viewController.present(alert, animated: true, completion: nil)
//        }
//    }
//    
//    //MARK: Fetching Bags
//    func fetchDiscBagList(onCompletion:@escaping([BagSwiftDataModel]?,Error?)->(Void)){
//        
//        let descriptor = FetchDescriptor<BagSwiftDataModel>(sortBy: [SortDescriptor<BagSwiftDataModel>(\.bagTitle)])
//        if let context{
//            do{
//                let data = try context.fetch(descriptor)
//                onCompletion(data,nil)
//            }
//            catch{
//                onCompletion(nil,error)
//            }
//        }
//    }
//    
//    //MARK: Updating Bags
//    func update(bag: BagSwiftDataModel, with disc: DiscGolfDisc){
//        let bagToBeUpdated = bag
//        bagToBeUpdated.discs.append(disc)
//        //Finish rest of changes here:
//    }
//    
//    //MARK: Remove disc from bag
//    func remove(_ disc: DiscGolfDisc, from bag: BagSwiftDataModel) {
//        if let index = bag.discs.firstIndex(where: { $0.id == disc.id }) {
//            // Remove the disc from the bag
//            bag.discs.remove(at: index)
//        }
//    }
//    
//    //MARK: Delete Bag
//    func deleteBagFromBagView(bag: BagSwiftDataModel){
//        let bagToBeDeleted = bag
//        if let context{
//            context.delete(bagToBeDeleted)
//        }
//    }
//    
//    
//    //MARK: DISCS
//    //MARK: Saving Disc To Cart
//    func saveDisc(discName: String, discImageData: Data, discStability: String, discSpeed: String, discGlide: String, discTurn: String, discFade: String, discBrand: String, viewController: UIViewController) {
//        
//            if let context {
//                let discToBeSaved = DiscSwiftDataModel(id: UUID().uuidString, name: discName, imageData: discImageData, stability: discStability, speed: discSpeed, glide: discGlide, turn: discTurn, fade: discFade, brand: discBrand)
//                 context.insert(discToBeSaved)
//            } else {
//            print("ERROR SAVING DISC!")
//                // Show an alert to the user
//                let alert = UIAlertController(title: "Error", message: "An error occurred while saving the disc data.", preferredStyle: .alert)
//                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
//                viewController.present(alert, animated: true, completion: nil)
//        }
//    }
//    
//    //MARK: Fetch Disc
//    func fetchDiscCartList(onCompletion:@escaping([DiscSwiftDataModel]?,Error?)->(Void)){
//            
//        let descriptor = FetchDescriptor<DiscSwiftDataModel>(sortBy: [SortDescriptor<DiscSwiftDataModel>(\.brand)])
//            if let context{
//                do{
//                    let data = try context.fetch(descriptor)
//                    onCompletion(data,nil)
//                }
//                catch{
//                    onCompletion(nil,error)
//                }
//            }
//       }
//    
//    //MARK: update disc
//    func updateDisc(disc: DiscSwiftDataModel, newDiscName: String){
//           let discToBeUpdated = disc
//        discToBeUpdated.name = newDiscName
//        //Finish rest of changes here:
//       }
//    
//    //MARK: Delete Disc
//    func deleteDiscFromCartView(disc: DiscSwiftDataModel){
//            let discToBeDeleted = disc
//            if let context{
//                context.delete(discToBeDeleted)
//            }
//        }
//}
//
//
//
