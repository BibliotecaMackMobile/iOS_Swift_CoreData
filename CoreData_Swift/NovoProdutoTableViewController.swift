//
//  NovoProdutoTableViewController.swift
//  CoreData_Swift
//
//  Created by joaquim on 15/04/15.
//  Copyright (c) 2015 Joaquim Pessoa Filho. All rights reserved.
//

import UIKit

class NovoProdutoTableViewController: UITableViewController
{
    
    @IBOutlet weak var nomeText: UITextField!
    @IBOutlet weak var precoText: UITextField!
    @IBOutlet weak var marcaText: UILabel!
    var marca:Marca?
    
    override func viewWillAppear(animated: Bool) {
        marcaText.text = marca?.nome
    }

    @IBAction func salvarProduto(sender: AnyObject)
    {
        var produto = ProdutoManager.sharedInstance.novoProduto()
        produto.nome = nomeText.text
        produto.preco = (precoText.text as NSString).doubleValue
        produto.marca = marca!
        // Notem que a linha a seguir nao eh necessaria
        // o CoreData trata de fazer a atribuicao
        // mas tambem nao tem problema descomentar esta linha
//        marca?.addProduto(produto)
        ProdutoManager.sharedInstance.salvar()
        self.navigationController?.popViewControllerAnimated(true)
    }
}