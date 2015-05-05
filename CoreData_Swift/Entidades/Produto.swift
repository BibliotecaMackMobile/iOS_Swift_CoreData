//
//  Produto.swift
//  CoreData_Swift
//
//  Created by joaquim on 13/04/15.
//  Copyright (c) 2015 Joaquim Pessoa Filho. All rights reserved.
//

import Foundation
import CoreData

class Produto: NSManagedObject {

    @NSManaged var nome: String
    @NSManaged var preco: Double
    @NSManaged var marca: Marca

}
