//
//  LeiloesViewController.swift
//  Leilao
//
//  Created by Raphael Martin on 29/11/21.
//  Copyright © 2021 Alura. All rights reserved.
//

import UIKit

class LeiloesViewController: UIViewController, UITableViewDataSource {
    // MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Atributos
    private var listaDeLeiloes = [Leilao]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listaDeLeiloes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let celulaLeilao = tableView.dequeueReusableCell(withIdentifier: "LeilaoTableViewCell", for: indexPath)
        
        return celulaLeilao
    }
    
    // MARK: - Métodos
    func addLeilao(_ leilao: Leilao) {
        listaDeLeiloes.append(leilao)
        tableView.reloadData()
    }
}
