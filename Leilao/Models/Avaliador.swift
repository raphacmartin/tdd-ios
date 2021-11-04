//
//  Avaliador.swift
//  Leilao
//
//  Created by Alura Laranja on 04/05/18.
//  Copyright © 2018 Alura. All rights reserved.
//

import Foundation

enum ErroAvaliador: Error {
    case LeilaoSemLance(String)
}

class Avaliador {
    
    private var maiorDeTodos = Double.leastNonzeroMagnitude
    private var menorDeTodos = Double.greatestFiniteMagnitude
    private var maiores = [Lance]()
    
    func avalia(leilao:Leilao) throws {
        if leilao.lances?.count == 0 {
            throw ErroAvaliador.LeilaoSemLance("Não é possível avaliar um leilão sem lances")
        }
        
        guard let lances = leilao.lances else { return }
        
        for lance in lances {
            if lance.valor > maiorDeTodos {
                maiorDeTodos = lance.valor
            }
            if lance.valor < menorDeTodos {
                menorDeTodos = lance.valor
            }
        }
        pegaOsMaioresLancesNoLeilao(leilao)
    }
    
    func maiorLance() -> Double {
        return maiorDeTodos
    }
    
    func menorLance() -> Double {
        return menorDeTodos
    }
    
    func tresMaiores() -> [Lance] {
        return maiores
    }
    
    private func pegaOsMaioresLancesNoLeilao(_ leilao: Leilao) {
        guard let lances = leilao.lances else { return }
        
        maiores = lances.sorted(by: { lance1, lance2 in
            return lance1.valor > lance2.valor
        })
        
        maiores = Array(maiores.prefix(3))
    }
    
    
}
