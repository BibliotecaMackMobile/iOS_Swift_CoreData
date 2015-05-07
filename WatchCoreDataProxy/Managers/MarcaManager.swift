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
    public static let sharedInstance:MarcaManager = MarcaManager()
    static let entityName:String = "Marca"
    
    lazy var managedContext:NSManagedObjectContext = {
        var c = WatchCoreDataProxy.sharedInstance.managedObjectContext
        return c!
    }()
    
    private init(){}
    
    public func novaMarca()->Marca
    {
        return NSEntityDescription.insertNewObjectForEntityForName(MarcaManager.entityName, inManagedObjectContext: managedContext) as! Marca
    }
    
    public func salvar()
    {
        var error:NSError?
        managedContext.save(&error)
        
        if let e = error {
            println("Could not save. Error: \(error), \(error!.userInfo)")
        }
    }
    
    public func buscarMarcas()->[Marca]
    {
        let fetchRequest = NSFetchRequest(entityName: MarcaManager.entityName)
        var error:NSError?
        
        let fetchedResults = managedContext.executeFetchRequest(fetchRequest, error: &error) as? [NSManagedObject]
        
        if !WatchCoreDataProxy.sharedInstance.managedObjectContext!.save(&error) {
            println("Error fetching on the managed object context")
        }
        
        println(fetchedResults?.count)
        
        var marcas:Array<Marca> = []
        for (index,marca) in enumerate(fetchedResults!) {
            marcas.append(marca as! Marca)
        }
        return marcas
    }

    public func buscarMarcasTESTE()->[NSManagedObject]
    {
        let fetchRequest = NSFetchRequest(entityName: MarcaManager.entityName)
        var error:NSError?
        
        let fetchedResults = managedContext.executeFetchRequest(fetchRequest, error: &error) as? [NSManagedObject]
        
        if !WatchCoreDataProxy.sharedInstance.managedObjectContext!.save(&error) {
            println("Error fetching on the managed object context")
        }
        
        println(fetchedResults?.count)
        
        if let results = fetchedResults as? [Marca] {
            return results
        } else {
            println("Could not fetch. Error: \(error), \(error!.userInfo)")
        }
        
        NSFetchRequest(entityName: "FetchRequest")
        
        return Array<Marca>()
    }

    
    
    public func apagarMarca(var marca:Marca) -> Bool
    {
        var error:NSError?
        var marcaNome = marca.nome

        managedContext.deleteObject(marca)
        managedContext.save(&error)
        
        if let e = error {
            println("Erro ao tentar remover a marca (\(marcaNome)): \(error)")
            return false
        } else {
            println("Marca \(marcaNome) removida com sucesso")
        }
        return true
    }
}