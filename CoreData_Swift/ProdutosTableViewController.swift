//
//  ProdutosTableViewController.swift
//  CoreData_Swift
//
//  Created by joaquim on 15/04/15.
//  Copyright (c) 2015 Joaquim Pessoa Filho. All rights reserved.
//

import UIKit

class ProdutosTableViewController: UITableViewController, UITableViewDataSource
{
    var marca:Marca?
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func viewWillAppear(animated: Bool) {
        tableView.reloadData()
        self.navigationItem.title = marca?.nome
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let count = marca?.produtos.count {
            return marca!.produtos.allObjects.count
        }
        return 0
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let item = marca!.produtos.allObjects[indexPath.row] as! Produto
        var cell:UITableViewCell = tableView.dequeueReusableCellWithIdentifier("produtoCell") as! UITableViewCell
        
        cell.textLabel?.text = item.nome
        cell.detailTextLabel?.text = "\(item.preco)"
        
        return cell
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let destino = segue.destinationViewController as? NovoProdutoTableViewController {
            destino.marca = marca
        }
    }
}
