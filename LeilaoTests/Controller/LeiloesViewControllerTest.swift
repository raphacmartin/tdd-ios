//
//  LeiloesViewControllerTest.swift
//  LeilaoTests
//
//  Created by Raphael Martin on 29/11/21.
//  Copyright © 2021 Alura. All rights reserved.
//

import XCTest
@testable import Leilao
import Cuckoo

class LeiloesViewControllerTest: XCTestCase {

    var sut: LeiloesViewController!
    var tableView: UITableView!
    
    override func setUpWithError() throws {
        sut = (UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "home") as! LeiloesViewController)
        // Força chamada do viewDidLoad()
        _ = sut.view
        tableView = sut.tableView
    }

    override func tearDownWithError() throws {

    }
    
    func testTableViewNaoDeveEstarNilAposViewDidLoad() {
        XCTAssertNotNil(sut.tableView)
    }
    
    func testDataSourceDaTableViewNaoDeveSerNil() {
        XCTAssertNotNil(tableView.dataSource)
        XCTAssertNotNil(tableView.dataSource is LeiloesViewController)
    }
    
    func testNumberOfRowsInSectionDeveSerQuantidadeDeLeiloesDaLista() {
        XCTAssertEqual(0, tableView.numberOfRows(inSection: 0))
        
        sut.addLeilao(Leilao(descricao: "PS4"))
        XCTAssertEqual(1, tableView.numberOfRows(inSection: 0))
        
        sut.addLeilao(Leilao(descricao: "iPhone"))
        XCTAssertEqual(2, tableView.numberOfRows(inSection: 0))
    }

    func testCellForRowDeveRetornarLeilaoTableViewCell() {
        sut.addLeilao(Leilao(descricao: "TV Led"))
        
        let celula = tableView.cellForRow(at: IndexPath(row: 0, section: 0))
        
        XCTAssertTrue(celula is LeilaoTableViewCell)
    }
    
    func testCellForRowDeveChamarDequeueReusableCell() {
        let mockTableView = MockTableView()
        mockTableView.dataSource = sut
        
        mockTableView.register(LeilaoTableViewCell.self, forCellReuseIdentifier: "LeilaoTableViewCell")
        
        sut.addLeilao(Leilao(descricao: "Macbook Pro"))
        mockTableView.reloadData()
        
        _ = mockTableView.cellForRow(at: IndexPath(row: 0, section: 0))
        
        XCTAssertTrue(mockTableView.celulaFoiReutilizada)
    }
}

extension LeiloesViewControllerTest {
    class MockTableView: UITableView {
        var celulaFoiReutilizada = false
        
        override func dequeueReusableCell(withIdentifier identifier: String, for indexPath: IndexPath) -> UITableViewCell {
            celulaFoiReutilizada = true
            return super.dequeueReusableCell(withIdentifier: "LeilaoTableViewCell", for: indexPath)
        }
    }
}
