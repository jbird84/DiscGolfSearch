//
//  HelpViewController.swift
//  DiscGolfSearch
//
//  Created by Kinney Kare on 5/17/24.
//

import UIKit
import Eureka

class HelpViewController: FormViewController {
    
    enum CellTags: String {
        case customerName
        case customerEmail
        case customerPhone
        case customerSubject
        case customerMessage
    }

    override func viewDidLoad() {
        super.viewDidLoad()

       createContactSupportForm()
    }
    
    private func setupView() {
        // Add a "SEND" button to the navigation bar
        let saveButton = UIBarButtonItem(title: "SEND", style: .plain, target: self, action: #selector(sendButtonTapped))
        navigationItem.rightBarButtonItem = saveButton
    }
    private func createContactSupportForm() {
        form
        +++ Section("Your Name")
        <<< LabelRow(CellTags.customerName.rawValue) {
            $0.title =  "Name"
        }
        <<< EmailRow(CellTags.customerEmail.rawValue) {
            $0.title =  "Email"
        }
        <<< NumericRow(CellTags.customerPhone.rawValue) {
            $0.title =  "Number"
        }
        <<< LabelRow(CellTags.customerSubject.rawValue) {
            $0.title =  "Subject"
        }
        <<< TextRow(CellTags.customerMessage.rawValue) {
            $0.title =  "Message"
        }
    }
    
    @objc private func saveButtonTapped() {
        
       
            navigationController?.popViewController(animated: true)
            AlertPresenter.instance.showAlert(title: "Success", body: "Email Sent To Support Successfully!", iconImage: UIImage(systemName: "checkmark.circle.fill")!, bannerColor: .green) {
            }
        }
    }
}
