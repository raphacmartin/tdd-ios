//
//  GeradorDePagamentoTests.swift
//  LeilaoTests
//
//  Created by Raphael Martin on 04/11/21.
//  Copyright © 2021 Alura. All rights reserved.
//

import XCTest
import Cuckoo
@testable import Leilao

class GeradorDePagamentoTests: XCTestCase {

    override func setUpWithError() throws {
        
    }

    override func tearDownWithError() throws {
        
    }

    func testDeveGerarPagamentoParaUmLeilaoEncerrado() {
        let ps4 = CriadorDeLeilao()
            .para(descricao: "PS4")
            .lance(Usuario(nome: "José"), 2000)
            .lance(Usuario(nome: "Maria"), 2500)
            .constroi()
        
        let daoFalso = MockLeilaoDao().withEnabledSuperclassSpy()
        
        stub(daoFalso) { daoFalso in
            when(daoFalso.encerrados()).thenReturn([ps4])
        }
        
        let avaliador = Avaliador()
        
        let pagamentos = MockRepositorioDePagamento().withEnabledSuperclassSpy()
        
        let geradorDePagamento = GeradorDePagamento(daoFalso, avaliador, pagamentos)
        geradorDePagamento.gera()
        
        let capturadorDeArgumento = ArgumentCaptor<Pagamento>()
        verify(pagamentos).salva(capturadorDeArgumento.capture())
        
        let pagamentoGerado = capturadorDeArgumento.value
        
        XCTAssertEqual(2500, pagamentoGerado?.getValor())
    }

}
