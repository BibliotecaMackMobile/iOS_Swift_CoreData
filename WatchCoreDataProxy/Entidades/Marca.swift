//
//  Marca.swift
//  CoreData_Swift
//
//  Created by joaquim on 13/04/15.
//  Copyright (c) 2015 Joaquim Pessoa Filho. All rights reserved.
//

import Foundation
import CoreData

public class Marca: NSManagedObject {

    @NSManaged public var nome: String
    @NSManaged public var slogan: String
    @NSManaged public var produtos: NSSet

    public func addProduto(produto:Produto) {
        var produtos = self.mutableSetValueForKey("produtos")
        produtos.addObject(produto)
    }
    
    public func removeProduto(produto:Produto) {
        var produtos = self.mutableSetValueForKey("produtos")
        produtos.removeObject(produto)
    }
}