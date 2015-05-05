//
//  ViewController.swift
//  CoreData_Swift
//
//  Created by joaquim on 13/04/15.
//  Copyright (c) 2015 Joaquim Pessoa Filho. All rights reserved.
//

import UIKit

class MarcasTableViewController: UITableViewController, UITableViewDataSource, UITableViewDelegate
{
    lazy var marcas:Array<Marca> = {
        return MarcaManager.sharedInstance.buscarMarcas()
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(animated: Bool) {
        marcas = MarcaManager.sharedInstance.buscarMarcas()
        self.tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return marcas.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let item:Marca = marcas[indexPath.row]
        var cell:UITableViewCell = tableView.dequeueReusableCellWithIdentifier("marcaCell") as! UITableViewCell
        
        cell.textLabel?.text = item.nome
        cell.detailTextLabel?.text = "\(item.slogan) - Produtos(\(item.produtos.count))"
        
        return cell
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let destino = segue.destinationViewController as? ProdutosTableViewController {
            destino.marca = marcas[tableView.indexPathForSelectedRow()!.row]
        }
    }
    
    // MARK: UITableViewDelegate Methods
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == UITableViewCellEditingStyle.Delete {
            var marcaSelecionada = marcas[indexPath.row]
            
            if MarcaManager.sharedInstance.apagarMarca(marcaSelecionada) {
                marcas.removeAtIndex(indexPath.row)
                tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Fade)
            } else {
                let alertController = UIAlertController(title: "Remoção", message: "Não foi possível remover a marca", preferredStyle: .Alert)
                let defaultAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
                alertController.addAction(defaultAction)
                presentViewController(alertController, animated: true, completion: nil)
            }
        }
    }
}

