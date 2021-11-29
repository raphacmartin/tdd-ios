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
    
    var daoFalso: MockLeilaoDao!
    var avaliador: Avaliador!
    var pagamentos: MockRepositorioDePagamento!

    override func setUpWithError() throws {
        daoFalso = MockLeilaoDao().withEnabledSuperclassSpy()
        avaliador = Avaliador()
        pagamentos = MockRepositorioDePagamento().withEnabledSuperclassSpy()
    }

    override func tearDownWithError() throws {
        
    }

    func testDeveGerarPagamentoParaUmLeilaoEncerrado() {
        let ps4 = CriadorDeLeilao()
            .para(descricao: "PS4")
            .lance(Usuario(nome: "José"), 2000)
            .lance(Usuario(nome: "Maria"), 2500)
            .constroi()
        
        stub(daoFalso) { daoFalso in
            when(daoFalso.encerrados()).thenReturn([ps4])
        }
        
        let geradorDePagamento = GeradorDePagamento(daoFalso, avaliador, pagamentos)
        geradorDePagamento.gera()
        
        let capturadorDeArgumento = ArgumentCaptor<Pagamento>()
        verify(pagamentos).salva(capturadorDeArgumento.capture())
        
        let pagamentoGerado = capturadorDeArgumento.value
        
        XCTAssertEqual(2500, pagamentoGerado?.getValor())
    }
    
    func testDeveEmpurrarParaProximoDiaUtil() {
        let iPhone = CriadorDeLeilao()
            .para(descricao: "iPhone")
            .lance(Usuario(nome: "Joao"), 2000)
            .lance(Usuario(nome: "Maria"), 2000)
            .constroi()
        
        stub(daoFalso) { daoFalso in
            when(daoFalso.encerrados())
                .thenReturn([iPhone])
        }
        
        let formatador = DateFormatter()
        formatador.dateFormat = "yyyy/MM/dd"
        guard let dataAntiga = formatador.date(from: "2021/11/27") else { return }
        
        let geradorDePagamento = GeradorDePagamento(daoFalso, avaliador, pagamentos, dataAntiga)
        geradorDePagamento.gera()
        
        let capturadorDeArgumento = ArgumentCaptor<Pagamento>()
        verify(pagamentos).salva(capturadorDeArgumento.capture())
        
        let pagamentoGerado = capturadorDeArgumento.value
        
        let formatadorDeData = DateFormatter()
        formatadorDeData.dateFormat = "ccc"
        
        guard let dataDoPagamento = pagamentoGerado?.getData() else { return }
        let diaDaSemana = formatadorDeData.string(from: dataDoPagamento)
        
        XCTAssertEqual("Mon", diaDaSemana)
    }

}
