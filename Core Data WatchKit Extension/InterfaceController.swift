//
//  InterfaceController.swift
//  Core Data WatchKit Extension
//
//  Created by joaquim on 05/05/15.
//  Copyright (c) 2015 Joaquim Pessoa Filho. All rights reserved.
//

import WatchKit
import Foundation
import WatchCoreDataProxy


class InterfaceController: WKInterfaceController {

    @IBOutlet weak var marcasTable: WKInterfaceTable!
    var marcas:[Marca]?
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        // Configure interface objects here.
        reloadTable()
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
    override func table(table: WKInterfaceTable, didSelectRowAtIndex rowIndex: Int) {
        reloadTable()
    }

    
    func reloadTable() {
        marcas = MarcaManager.sharedInstance.buscarMarcas()
        marcasTable.setNumberOfRows(marcas!.count, withRowType: "MarcaRow")
        
        for (index, marca) in enumerate(marcas!) {
            if let row = marcasTable.rowControllerAtIndex(index) as? MarcaRow {
                row.marcaLabel.setText(marca.nome)
                row.produtosLabel.setText("Produtos: \(marca.produtos.allObjects.count)")
            }
        }
    }
}
