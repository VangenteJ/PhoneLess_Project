//
//  AppDelegate.swift
//  PhoneLess_Project
//
//  Created by Joel Vangente on 25/02/2019.
//  Copyright © 2019 Joel Vangente. All rights reserved.
//

import UIKit
import CoreData
import Firebase

var timeoff = "0"

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    
    var ref:DatabaseReference!
    var window: UIWindow?
    
    let displayStatusChanged: CFNotificationCallback = { center, observer, name, object, info in
        let str = name!.rawValue as CFString
        if (str == "com.apple.springboard.lockcomplete" as CFString) {
            let isDisplayStatusLocked = UserDefaults.standard
            isDisplayStatusLocked.set(true, forKey: "isDisplayStatusLocked")
            isDisplayStatusLocked.synchronize()
        }
    }

    override init() {
        FirebaseApp.configure()
        Database.database().isPersistenceEnabled = true
    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        //FirebaseApp.configure()
        ref = Database.database().reference()
        
        let isDisplayStatusLocked = UserDefaults.standard
        isDisplayStatusLocked.set(false, forKey: "isDisplayStatusLocked")
        isDisplayStatusLocked.synchronize()
        
        // Darwin Notification
        let cfstr = "com.apple.springboard.lockcomplete" as CFString
        let notificationCenter = CFNotificationCenterGetDarwinNotifyCenter()
        let function = displayStatusChanged
        CFNotificationCenterAddObserver(notificationCenter,
                                        nil,
                                        function,
                                        cfstr,
                                        nil,
                                        .deliverImmediately)

        return true
    }
    
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
        
        let isDisplayStatusLocked = UserDefaults.standard
        if let lock = isDisplayStatusLocked.value(forKey: "isDisplayStatusLocked"){
            // user locked screen
            if(lock as! Bool){
                // do anything you want here
                print("Home button pressed.")
                
                
                
            }
                // user pressed home button
            else{
                // do anything you want here
                print("Lock button pressed.")
                
                let formatter = DateFormatter()
                // initially set the format based on datepicker date / server String
                formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
                
                let myString = formatter.string(from: Date()) // string purpose I add here
                // convert string to date
                let myDate = formatter.date(from: myString)
                //then again set the date format whhich type of output needed
                formatter.dateFormat = "ss"
                // again convert date to string
                let myStringafd = formatter.string(from: myDate!)
                
                timeoff = myStringafd
                print(myStringafd)
            }
        }
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
        
        print("Back to foreground.")
        
        let formatter = DateFormatter()
        // initially set the format based on datepicker date / server String
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        let myString = formatter.string(from: Date()) // string purpose I add here
        // convert string to date
        let myDate = formatter.date(from: myString)
        //then again set the date format whhich type of output needed
        formatter.dateFormat = "ss"
        // again convert date to string
        let myStringafd = formatter.string(from: myDate!)
        
        let timeoff2 = myStringafd
        
        if let timeO = Int(timeoff){
            if let timeO2 = Int(timeoff2){
                if timeO2 < timeO{
                    let tO = 60 - timeO
                    timeoff = String(tO + timeO2)
                }else{
                    timeoff = String(timeO2 - timeO)
                }
            }
        }
        print(timeoff)
        print(myStringafd)
        if Auth.auth().currentUser?.uid != nil{
            ref.child((Auth.auth().currentUser?.uid)!).child("Time6").setValue(timeoff)
        }
        
        //restore lock screen setting
        let isDisplayStatusLocked = UserDefaults.standard
        isDisplayStatusLocked.set(false, forKey: "isDisplayStatusLocked")
        isDisplayStatusLocked.synchronize()
      
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        // Saves changes in the application's managed object context before the application terminates.
        self.saveContext()
    }

    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "PhoneLess_Project")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

}

