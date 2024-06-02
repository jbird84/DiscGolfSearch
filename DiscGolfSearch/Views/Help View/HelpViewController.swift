//
//  HelpViewController.swift
//  DiscGolfSearch
//
//  Created by Kinney Kare on 5/17/24.
//

import UIKit
import Eureka
import MessageUI


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
        title = "Contact Support"
        // Set the navigation bar title text color to white
            if let navigationBar = navigationController?.navigationBar {
                let appearance = UINavigationBarAppearance()
                appearance.configureWithOpaqueBackground()
                appearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
                appearance.backgroundColor = navigationBar.backgroundColor // retain the existing background color
                navigationBar.standardAppearance = appearance
                navigationBar.scrollEdgeAppearance = appearance
            }
        
        let saveButton = UIBarButtonItem(title: "SEND", style: .plain, target: self, action: #selector(sendButtonTapped))
        navigationItem.rightBarButtonItem = saveButton
    }
    
    private func createContactSupportForm() {
        form
        +++ Section("Your Name")
        <<< TextRow(CellTags.customerName.rawValue) {
            $0.placeholder =  "Name"
        }
        +++ Section("Your Email")
        <<< EmailRow(CellTags.customerEmail.rawValue) {
            $0.placeholder =  "Email"
        }
        +++ Section("Your Phone Number (Optional)")
        <<< PhoneRow(CellTags.customerPhone.rawValue) {
            $0.placeholder =  "Number"
        }
        +++ Section("Email Subject")
        <<< TextRow(CellTags.customerSubject.rawValue) {
            $0.placeholder =  "Subject"
        }
        +++ Section("Email Message")
        <<< TextAreaRow(CellTags.customerMessage.rawValue) {
            $0.placeholder =  "Message"
        }
    }
    
    @objc private func sendButtonTapped() {
        
        let nameRow: TextRow? = form.rowBy(tag: CellTags.customerName.rawValue)
        let emailRow: EmailRow? = form.rowBy(tag: CellTags.customerEmail.rawValue)
        let phoneRow: PhoneRow? = form.rowBy(tag: CellTags.customerPhone.rawValue)
        let subjectRow: TextRow? = form.rowBy(tag: CellTags.customerSubject.rawValue)
        let messageRow: TextAreaRow? = form.rowBy(tag: CellTags.customerMessage.rawValue)
        
        let name = nameRow?.value
        let email = emailRow?.value
        let phone = phoneRow?.value
        let subject = subjectRow?.value
        let message = messageRow?.value
        
        if name?.isEmpty ?? true || email?.isEmpty ?? true || subject?.isEmpty ?? true || message?.isEmpty ?? true {
            
            let alertController = UIAlertController(title: "Error", message: "Please fill in all required fields.", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alertController, animated: true, completion: nil)
        } else {
            
            sendEmail(email: email ?? "Email Not Provided", title: subject ?? "Subject Not Provided", name: name ?? "Name Not Provided", phone: phone ?? "Phone Not Provided", body: message ?? "Message Not Provided")
            
            navigationController?.popViewController(animated: true)
            AlertPresenter.instance.showAlert(title: "Success", body: "Email Sent To Support Successfully!", iconImage: UIImage(systemName: "checkmark.circle.fill")!, bannerColor: .green) { }
        }
    }
}

extension HelpViewController: MFMailComposeViewControllerDelegate {
    func sendEmail(email: String, title: String, name: String, phone: String, body: String) {
        if MFMailComposeViewController.canSendMail() {
            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = self
            mail.setPreferredSendingEmailAddress(email)
            mail.setToRecipients(["joshkinney@kinneykare.com"])
            mail.setSubject(title)
            mail.setMessageBody("<p> Date: \(Date())</p> <br /> <p> \(title)</p> <br /> <p> \(name)</p> <br /> <p> \(phone)</p> <br /> <p> Body: \(body)</p>", isHTML: true)
            
            present(mail, animated: true)
        } else {
            let alertController = UIAlertController(title: "Error Contacting Support", message: "Please make sure you have internet and try again.", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alertController, animated: true, completion: nil)
        }
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true)
    }
}
