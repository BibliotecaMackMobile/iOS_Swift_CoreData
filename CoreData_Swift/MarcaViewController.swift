//
//  NovaMarcaViewController.swift
//  CoreData_Swift
//
//  Created by joaquim on 13/04/15.
//  Copyright (c) 2015 Joaquim Pessoa Filho. All rights reserved.
//

import UIKit

class MarcaViewController: UITableViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var nomeText: UITextField!
    @IBOutlet weak var sloganText: UITextField!
    
    var marca:Marca?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if marca != nil {
            nomeText.text = marca!.nome
            sloganText.text = marca!.slogan
            self.navigationItem.title = "Editar"
        } else {
            self.navigationItem.title = "Nova Marca"
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func salvarMarca(sender: AnyObject)
    {
        if marca == nil {
            marca = MarcaManager.sharedInstance.novaMarca()
        }
        
        marca!.nome = nomeText.text
        marca!.slogan = sloganText.text
        MarcaManager.sharedInstance.salvar()
        self.navigationController?.popViewControllerAnimated(true)
    }
}
