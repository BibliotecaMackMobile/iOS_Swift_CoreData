//
//  Produto.swift
//  CoreData_Swift
//
//  Created by joaquim on 13/04/15.
//  Copyright (c) 2015 Joaquim Pessoa Filho. All rights reserved.
//

import Foundation
import CoreData

public class Produto: NSManagedObject {

    @NSManaged public var nome: String
    @NSManaged public var preco: Double
    @NSManaged public var marca: Marca

}
