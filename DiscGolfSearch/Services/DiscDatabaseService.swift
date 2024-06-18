////
////  DiscDatabaseService.swift
////  DiscGolfSearch
////
////  Created by Kinney Kare on 11/29/23.
////
//
import UIKit
import SwiftData


class DiscDatabaseService {
    
    
    static var shared = DiscDatabaseService()
    var container: ModelContainer?
    var context: ModelContext?
    
    init() {
        do {
            container = try ModelContainer(for: DiscSwiftDataModel.self)
            if let container {
                context = ModelContext(container)
            }
        } catch {
            print("Swift Data Error: \(error)")
        }
    }
    
    //MARK: Saving Disc To Cart
    func saveDisc(discName: String, discImageData: Data, discStability: String, discSpeed: String, discGlide: String, discTurn: String, discFade: String, discBrand: String, viewController: UIViewController) {
        
            if let context {
                let discToBeSaved = DiscSwiftDataModel(id: UUID().uuidString, name: discName, imageData: discImageData, stability: discStability, speed: discSpeed, glide: discGlide, turn: discTurn, fade: discFade, brand: discBrand)
                 context.insert(discToBeSaved)
            } else {
            print("ERROR SAVING DISC!")
           
                let alert = UIAlertController(title: "Error", message: "An error occurred while saving the disc data.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                viewController.present(alert, animated: true, completion: nil)
        }
    }
    
    //MARK: Fetch Disc
    func fetchDiscCartList(onCompletion:@escaping([DiscSwiftDataModel]?,Error?)->(Void)){
            
        let descriptor = FetchDescriptor<DiscSwiftDataModel>(sortBy: [SortDescriptor<DiscSwiftDataModel>(\.brand)])
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
    
    //MARK: update disc
    func updateDisc(disc: DiscSwiftDataModel, newDiscName: String){
           let discToBeUpdated = disc
        discToBeUpdated.name = newDiscName
       }
    
    //MARK: Delete Disc
    func deleteDiscFromCartView(disc: DiscSwiftDataModel){
            let discToBeDeleted = disc
            if let context{
                context.delete(discToBeDeleted)
            }
        }
}
