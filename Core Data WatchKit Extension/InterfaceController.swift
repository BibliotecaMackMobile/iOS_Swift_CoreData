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
        print("Iniciando")
        // Configure interface objects here.
        reloadTable()
        
        WKInterfaceController.openParentApplication(["request": "refreshData"],
            reply: { (replyInfo, error) -> Void in
                // TODO: process reply data
                NSLog("Reply: \(replyInfo)")
                self.reloadTable()
        })
    }
    
    

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

    
    func reloadTable() {
        // 1
        marcas = MarcaManager.sharedInstance.buscarMarcas()

        marcasTable.setNumberOfRows(marcas!.count, withRowType: "MarcaRow")
        
        for (index, marca) in enumerate(marcas!) {
            // 2
            if let row = marcasTable.rowControllerAtIndex(index) as? MarcaRow {
                // 3
                row.marcaLabel.setText(marca.nome)
                row.produtosLabel.setText("\(marca.produtos.allObjects.count)")
            }
        }
    }
}
