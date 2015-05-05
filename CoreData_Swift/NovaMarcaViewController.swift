//
//  NovaMarcaViewController.swift
//  CoreData_Swift
//
//  Created by joaquim on 13/04/15.
//  Copyright (c) 2015 Joaquim Pessoa Filho. All rights reserved.
//

import UIKit

class NovaMarcaViewController: UITableViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var nomeText: UITextField!
    @IBOutlet weak var sloganText: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func salvarMarca(sender: AnyObject)
    {
        var marca = MarcaManager.sharedInstance.novaMarca()
        marca.nome = nomeText.text
        marca.slogan = sloganText.text
        MarcaManager.sharedInstance.salvar()
        self.navigationController?.popViewControllerAnimated(true)
    }
}
