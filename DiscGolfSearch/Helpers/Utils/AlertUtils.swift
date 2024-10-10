//
//  AlertUtils.swift
//  DiscGolfSearch
//
//  Created by Kinney Kare on 10/8/24.
//

import UIKit

class AlertUtils {
    
    static func showAlert(on viewController: UIViewController, title: String, message: String, actions: [UIAlertAction]) {
          let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
          
          for action in actions {
              alertController.addAction(action)
          }
          
          viewController.present(alertController, animated: true, completion: nil)
      }
      
      static func showSupportAlert(on viewController: UIViewController) {
          let helpAction = UIAlertAction(title: "Contact Support", style: .default) { _ in
              // Navigate to Help View Controller
              let storyboard = UIStoryboard(name: "HelpView", bundle: nil)
              if let vc = storyboard.instantiateViewController(withIdentifier: "helpVC") as? HelpViewController {
                  vc.overrideUserInterfaceStyle = .dark
                  viewController.navigationController?.pushViewController(vc, animated: true)
              }
          }
          
          let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
          
          showAlert(on: viewController, title: "Support", message: "Would you like to contact support?", actions: [helpAction, cancelAction])
      }
      
      static func showSiteDownAlert(on viewController: UIViewController, retryAction: @escaping () -> Void) {
          let retry = UIAlertAction(title: "Try Refreshing", style: .default) { _ in
              retryAction()
          }
          
          let helpAction = UIAlertAction(title: "Contact Support", style: .default) { _ in
              showSupportAlert(on: viewController)
          }
          
          showAlert(on: viewController, title: "Site is down ☹️", message: "It looks like the site where the disc data comes from is currently down. Please close app and check back in later.", actions: [retry, helpAction])
      }
  }
