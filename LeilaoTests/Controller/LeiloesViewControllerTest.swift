//
//  LeiloesViewControllerTest.swift
//  LeilaoTests
//
//  Created by Raphael Martin on 29/11/21.
//  Copyright © 2021 Alura. All rights reserved.
//

import XCTest
@testable import Leilao

class LeiloesViewControllerTest: XCTestCase {

    override func setUpWithError() throws {

    }

    override func tearDownWithError() throws {

    }
    
    func testTableViewNaoDeveEstarNilAposViewDidLoad() {
        let sut = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "home") as! LeiloesViewController
        _ = sut.view
        
        XCTAssertNotNil(sut.tableView)
    }

}
