//
//  WatchCoreDataProxy.swift
//  CoreData_Swift
//
//  Created by joaquim on 05/05/15.
//  Copyright (c) 2015 Joaquim Pessoa Filho. All rights reserved.
//
import CoreData

public class WatchCoreDataProxy {
    public static let sharedInstance:WatchCoreDataProxy = WatchCoreDataProxy()
    private init(){}

//    public class var sharedInstance : WatchCoreDataProxy {
//        struct Static {
//            static let instance : WatchCoreDataProxy = WatchCoreDataProxy()
//        }
//        return Static.instance
//    }
    
    public let sharedAppGroup:String = "group.mackmobile.CoreDataSwift"
    
    // MARK: - Core Data stack
    
    public lazy var applicationDocumentsDirectory: NSURL = {
        // The directory the application uses to store the Core Data store file. This code uses a directory named "MackMobile.CoreData_Swift" in the application's documents Application Support directory.
//        let urls = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)
        let url = NSFileManager.defaultManager().containerURLForSecurityApplicationGroupIdentifier(WatchCoreDataProxy.sharedInstance.sharedAppGroup)
        return url!
//        return urls[urls.count-1] as! NSURL
        }()
    
    public lazy var managedObjectModel: NSManagedObjectModel = {
        // The managed object model for the application. This property is not optional. It is a fatal error for the application not to be able to find and load its model.
        
        //Esta e uma mudanca importante
        let proxyBundle = NSBundle(identifier: "MackMobile.WatchCoreDataProxy")
        let modelURL = proxyBundle!.URLForResource("CoreData_Swift", withExtension: "momd")

        return NSManagedObjectModel(contentsOfURL: modelURL!)!
        }()
    
    public lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator? = {
        // The persistent store coordinato for the application. This implementation creates and return a coordinato
        
        var error:NSError? = nil
        
        var sharedContainerURL:NSURL = self.applicationDocumentsDirectory
        let storeURL = sharedContainerURL.URLByAppendingPathComponent("CoreDataSwift.sqlite")

        var coordinator:NSPersistentStoreCoordinator? = NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModel)
        
        if coordinator!.addPersistentStoreWithType(NSSQLiteStoreType, configuration: nil, URL: storeURL, options: nil, error: &error) == nil {
            // error handling goes here
            abort()
        }
        return coordinator
        
        }()
    
    public lazy var managedObjectContext: NSManagedObjectContext? = {
        // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.) This property is optional since there are legitimate error conditions that could cause the creation of the context to fail.
        let coordinator = self.persistentStoreCoordinator
        if coordinator == nil {
            return nil
        }
        var managedObjectContext = NSManagedObjectContext()
        managedObjectContext.persistentStoreCoordinator = coordinator
        return managedObjectContext
        }()
    
    // MARK: - Core Data Saving support
    
    public func saveContext () {
        if let moc = self.managedObjectContext {
            var error: NSError? = nil
            if moc.hasChanges && !moc.save(&error) {
                NSLog("Unresolved error \(error), \(error!.userInfo)")
                // A aplicacao sera finalizada por nao ser possivel usar o CoreData
                // eh recomendado tratar este erro, exibindo uma orientacao ao usuario para solucao do problema
                abort()
            }
        }
    }
}
