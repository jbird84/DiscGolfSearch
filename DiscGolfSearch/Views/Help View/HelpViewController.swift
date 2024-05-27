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
        // Add a "SEND" button to the navigation bar
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
        // Validate required fields
                let nameRow: TextRow? = form.rowBy(tag: CellTags.customerName.rawValue)
                let emailRow: EmailRow? = form.rowBy(tag: CellTags.customerEmail.rawValue)
                let phoneRow: PhoneRow? = form.rowBy(tag: CellTags.customerPhone.rawValue)
                let subjectRow: TextRow? = form.rowBy(tag: CellTags.customerSubject.rawValue)
                let messageRow: TextAreaRow? = form.rowBy(tag: CellTags.customerMessage.rawValue)

                // Collect the values
                let name = nameRow?.value
                let email = emailRow?.value
                let phone = phoneRow?.value  // Optional
                let subject = subjectRow?.value
                let message = messageRow?.value

                // Check if any required field is empty
                if name?.isEmpty ?? true || email?.isEmpty ?? true || subject?.isEmpty ?? true || message?.isEmpty ?? true {
                    // Show alert if any required field is empty
                    let alertController = UIAlertController(title: "Error", message: "Please fill in all required fields.", preferredStyle: .alert)
                    alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    present(alertController, animated: true, completion: nil)
                } else {
                    // Print the information if all required fields are filled
                    
                    sendEmail(email: email ?? "Email Not Provided", title: subject ?? "Subject Not Provided", name: name ?? "Name Not Provided", phone: phone ?? "Phone Not Provided", body: message ?? "Message Not Provided")
                    print("Name: \(name ?? "")")
                    print("Email: \(email ?? "")")
                    print("Phone: \(phone ?? "N/A")")
                    print("Subject: \(subject ?? "")")
                    print("Message: \(message ?? "")")

                    // Dismiss the view controller and show success alert
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
            //TODO: show failure alert
            
        }
    }

    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true)
    }
}
