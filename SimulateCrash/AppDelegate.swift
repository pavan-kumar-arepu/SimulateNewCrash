//
//  AppDelegate.swift
//  SimulateCrash
//
//  Created by Pavankumar Arepu on 26/05/24.
//

import UIKit


//func handleCrash(exception: NSException) {
//    print("Crash occurred: \(exception)")
//
//    // Extract crash information
//    let name = exception.name.rawValue
//    let reason = exception.reason ?? "No reason provided"
//    let callStack = exception.callStackSymbols.joined(separator: "\n")
//
//    // Format crash details
//    let crashReport = """
//    **Crash Report**
//
//    Name: \(name)
//    Reason: \(reason)
//    Call Stack:
//
//    \(callStack)
//    """
//
//    // Save crash report to a file
//    let fileName = "crash_log.txt"
//    let documentsPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
//    let filePath = documentsPath.appendingPathComponent(fileName)
//
//    do {
//        try crashReport.write(to: filePath, atomically: true, encoding: .utf8)
//        print("Crash report saved to: \(filePath)")
//    } catch {
//        print("Error saving crash report: \(error)")
//    }
//}


@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        // Set the uncaught exception handler
        NSSetUncaughtExceptionHandler { exception in
            AppDelegate.handleCrash(exception: exception)
        }
        return true
    }

    static func handleCrash(exception: NSException) {
        print("Crash occurred: \(exception)")

        // Extract crash information
        let name = exception.name.rawValue
        let reason = exception.reason ?? "No reason provided"
        let callStack = exception.callStackSymbols.joined(separator: "\n")

        // Format crash details
        let crashReport = """
        **Crash Report**

        Name: \(name)
        Reason: \(reason)
        Call Stack:

        \(callStack)
        """

        // Save crash report to a file
        let fileName = "crash_log.txt"
        let documentsPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let filePath = documentsPath.appendingPathComponent(fileName)

        do {
            try crashReport.write(to: filePath, atomically: true, encoding: .utf8)
            print("Crash report saved to: \(filePath)")
        } catch {
            print("Error saving crash report: \(error)")
        }
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}



