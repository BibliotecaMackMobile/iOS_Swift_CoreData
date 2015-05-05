//
//  MarcaManager.swift
//  CoreData_Swift
//
//  Created by joaquim on 13/04/15.
//  Copyright (c) 2015 Joaquim Pessoa Filho. All rights reserved.
//

import CoreData
import UIKit

public class MarcaManager {
    static let sharedInstance:MarcaManager = MarcaManager()
    static let entityName:String = "Marca"
    lazy var managedContext:NSManagedObjectContext = {
        var appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        var c = appDelegate.managedObjectContext
        return c!
    }()
    
    private init(){}
    
    func novaMarca()->Marca
    {
        return NSEntityDescription.insertNewObjectForEntityForName(MarcaManager.entityName, inManagedObjectContext: managedContext) as! Marca
    }
    
    func salvar()
    {
        var error:NSError?
        managedContext.save(&error)
        
        if let e = error {
            println("Could not save. Error: \(error), \(error!.userInfo)")
        }
    }
    
    func buscarMarcas()->Array<Marca>
    {
        let fetchRequest = NSFetchRequest(entityName: MarcaManager.entityName)
        var error:NSError?
        
        let fetchedResults = managedContext.executeFetchRequest(fetchRequest, error: &error) as? [NSManagedObject]
        
        if let results = fetchedResults as? [Marca] {
            return results
        } else {
            println("Could not fetch. Error: \(error), \(error!.userInfo)")
        }
        
        NSFetchRequest(entityName: "FetchRequest")
        
        
        return Array<Marca>()
    }
}