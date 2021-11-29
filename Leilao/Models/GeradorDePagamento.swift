//
//  GeradorDePagamento.swift
//  Leilao
//
//  Created by Raphael Martin on 04/11/21.
//  Copyright © 2021 Alura. All rights reserved.
//

import Foundation

class GeradorDePagamento {
    private var leiloes: LeilaoDao
    private var avaliador: Avaliador
    private var repositorioDePagamento: RepositorioDePagamento
    private var data: Date
    
    init(_ leiloes: LeilaoDao, _ avaliador: Avaliador, _ repositorioDePagamento: RepositorioDePagamento, _ data: Date) {
        self.leiloes = leiloes
        self.avaliador = avaliador
        self.repositorioDePagamento = repositorioDePagamento
        self.data = data
    }
    
    convenience init(_ leiloes: LeilaoDao, _ avaliador: Avaliador, _ repositorioDePagamento: RepositorioDePagamento) {
        self.init(leiloes, avaliador, repositorioDePagamento, Date())
    }
    
    func gera() {
        let leiloesEncerrados = self.leiloes.encerrados()
        
        for leilao in leiloesEncerrados {
            try? avaliador.avalia(leilao: leilao)
            
            let novoPagamento = Pagamento(avaliador.maiorLance(), proximoDiaUtil())
            repositorioDePagamento.salva(novoPagamento)
        }
    }
    
    func proximoDiaUtil() -> Date {
        var dataAtual = data
        while Calendar.current.isDateInWeekend(dataAtual) {
            dataAtual = Calendar.current.date(byAdding: .day, value: 1, to: dataAtual)!
        }
        return dataAtual
    }
}
