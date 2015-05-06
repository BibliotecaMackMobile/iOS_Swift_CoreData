//
//  ViewController.swift
//  CoreData_Swift
//
//  Created by joaquim on 13/04/15.
//  Copyright (c) 2015 Joaquim Pessoa Filho. All rights reserved.
//

import UIKit
import WatchCoreDataProxy

class MarcasTableViewController: UITableViewController, UITableViewDataSource, UITableViewDelegate
{
    var marcaSelecionada:Marca?
    
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
        } else if let destino = segue.destinationViewController as? MarcaViewController {
            destino.marca = marcaSelecionada
        }
    }
    
    
    // MARK: UITableViewDelegate Methods
    
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {}
    
    
    override func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [AnyObject]? {
        
        let editAction = UITableViewRowAction(style: UITableViewRowActionStyle.Normal, title: "Editar") { (action, indexPath) -> Void in
            self.marcaSelecionada = self.marcas[indexPath.row]
            self.performSegueWithIdentifier("marcaSegue", sender: self)
        }
        
        let deleteAction = UITableViewRowAction(style: UITableViewRowActionStyle.Default, title: "Apagar") { (action, indexPath) -> Void in
            var marcaSelecionada = self.marcas[indexPath.row]
            
            if MarcaManager.sharedInstance.apagarMarca(marcaSelecionada) {
                self.marcas.removeAtIndex(indexPath.row)
                tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Fade)
            } else {
                let alertController = UIAlertController(title: "Remoção", message: "Não foi possível remover a marca", preferredStyle: .Alert)
                let defaultAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
                alertController.addAction(defaultAction)
                self.presentViewController(alertController, animated: true, completion: nil)
            }
        }
        
        return [editAction, deleteAction]
    }
}

