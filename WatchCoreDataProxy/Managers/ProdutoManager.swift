//
//  ProdutoManager.swift
//  CoreData_Swift
//
//  Created by joaquim on 15/04/15.
//  Copyright (c) 2015 Joaquim Pessoa Filho. All rights reserved.
//

import CoreData
import UIKit

public class ProdutoManager {
    public static let sharedInstance:ProdutoManager = ProdutoManager()
    static let entityName:String = "Produto"

    lazy var managedContext:NSManagedObjectContext = {
        return WatchCoreDataProxy.sharedInstance.managedObjectContext!
    }()
    
    private init(){}
    
    public func novoProduto()->Produto
    {
        return NSEntityDescription.insertNewObjectForEntityForName(ProdutoManager.entityName, inManagedObjectContext: managedContext) as! Produto
    }
    
    
    public func salvar()
    {
        var error:NSError?
        managedContext.save(&error)
        
        if let e = error {
            println("Could not save. Error: \(error), \(error!.userInfo)")
        }
    }
    
    public func buscarProdutos()->Array<Produto>
    {
        let fetchRequest = NSFetchRequest(entityName: ProdutoManager.entityName)
        var error:NSError?
        
        let fetchedResults = managedContext.executeFetchRequest(fetchRequest, error: &error) as? [NSManagedObject]
        
        if let results = fetchedResults as? [Produto] {
            return results
        } else {
            println("Could not fetch. Error: \(error), \(error!.userInfo)")
        }
        return Array<Produto>()
    }
    
    
    public func apagarProduto(var produto:Produto) -> Bool
    {
        var error:NSError?
        var produtoNome = produto.nome
        managedContext.deleteObject(produto)
        managedContext.save(&error)
        
        if let e = error {
            println("Erro ao tentar remover o produto (\(produtoNome)): \(error)")
            return false
        } else {
            println("Produto \(produtoNome) removido com sucesso")
        }
        return true
    }
}