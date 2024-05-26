//
//  ViewController.swift
//  SimulateCrash
//
//  Created by Pavankumar Arepu on 26/05/24.
//

import UIKit
import MessageUI

class ViewController: UIViewController, MFMailComposeViewControllerDelegate {

    override func viewWillAppear(_ animated: Bool) {
        checkForCrashReport()
    }
    
    override func viewDidLoad() {
        checkForCrashReport()
    }
    
    
    
    @IBAction func simulateCrash(_ sender: Any) {
        // Simulate a crash with incorrect logic (e.g., division by zero)
//        let arr = Array(arrayLiteral: 1,2,4);
//        print(arr[5]);
//        // print(arr[5]); // This line will never be reached due to the crash
        let optionalValue: String? = nil
        print(optionalValue!) // This will cause a force-unwrap crash
       }

    func checkForCrashReport() {
        // Check if crash log file exists
        let fileName = "crash_log.txt"
        let documentsPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let filePath = documentsPath.appendingPathComponent(fileName)
        if FileManager.default.fileExists(atPath: filePath.path) {

            // Prompt user to send crash report
            let alert = UIAlertController(title: "Crash Report Found",
                                          message: "An unexpected crash occurred. Would you like to send a report to the developer?",
                                          preferredStyle: .alert)
            let sendAction = UIAlertAction(title: "Send Report", style: .default) { _ in
                self.sendCrashReport(filePath: filePath)
            }
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            alert.addAction(sendAction)
            alert.addAction(cancelAction)
            present(alert, animated: true, completion: nil)
        } else {
            print("No crash report found")
        }
    }
    
    private func sendCrashReport(filePath: URL) {
            // Read crash log file contents
            do {
                let crashReport = try String(contentsOf: filePath, encoding: .utf8)

                // Prepare email content (consider user consent here)
                let subject = "App Crash Report"
                let body = crashReport

                // Configure email composition view controller
                let mailComposer = MFMailComposeViewController()
                mailComposer.mailComposeDelegate = self
                mailComposer.setSubject(subject)
                mailComposer.setMessageBody(body, isHTML: false)

                // Attach crash log file (optional)
                if let data = try? Data(contentsOf: filePath) {
                    let attachmentData = data
                    let mimeType = "text/plain"
                    mailComposer.addAttachmentData(attachmentData, mimeType: mimeType, fileName: "crash_log.txt")
                }

                // Present email composition view controller
                if MFMailComposeViewController.canSendMail() {
                    present(mailComposer, animated: true, completion: nil)
                } else {
                    print("Cannot send email")
                    // Handle case where email cannot be sent (e.g., no email account configured)
                }
            } catch {
                print("Error reading crash report: \(error)")
            }
        }
}

extension ViewController {

    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult) {
        controller.dismiss(animated: true, completion: nil)

        switch result {
        case .sent:
            print("Crash report sent successfully")
        case .cancelled:
            print("Crash report sending cancelled")
        case .failed:
            print("Error sending crash report")
        case .saved:
            print("Crash report saved as draft")
        default:
            break
        }
    }
}


