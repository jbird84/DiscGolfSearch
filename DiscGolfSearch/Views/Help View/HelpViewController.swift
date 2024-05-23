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
        setupView()
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
        <<< TextRow(CellTags.customerName.rawValue) {
            $0.title =  "Name"
        }
        +++ Section("Your Email")
        <<< EmailRow(CellTags.customerEmail.rawValue) {
            $0.title =  "Email"
        }
        +++ Section("Your Phone Number")
        <<< TextRow(CellTags.customerPhone.rawValue) {
            $0.title =  "Number"
        }
        +++ Section("Email Subject")
        <<< TextRow(CellTags.customerSubject.rawValue) {
            $0.title =  "Subject"
        }
        +++ Section("Email Message")
        <<< TextAreaRow(CellTags.customerMessage.rawValue) {
            $0.title =  "Message"
        }
    }
    
    @objc private func sendButtonTapped() {
        navigationController?.popViewController(animated: true)
        AlertPresenter.instance.showAlert(title: "Success", body: "Email Sent To Support Successfully!", iconImage: UIImage(systemName: "checkmark.circle.fill")!, bannerColor: .green) {
        }
    }
}
