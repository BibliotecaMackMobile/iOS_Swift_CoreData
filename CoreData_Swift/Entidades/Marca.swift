//
//  Marca.swift
//  CoreData_Swift
//
//  Created by joaquim on 13/04/15.
//  Copyright (c) 2015 Joaquim Pessoa Filho. All rights reserved.
//

import Foundation
import CoreData

class Marca: NSManagedObject {

    @NSManaged var nome: String
    @NSManaged var slogan: String
    @NSManaged var produtos: NSSet

    func addProduto(produto:Produto) {
        var produtos = self.mutableSetValueForKey("produtos")
        produtos.addObject(produto)
    }
}