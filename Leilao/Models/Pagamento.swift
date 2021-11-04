//
//  Pagamento.swift
//  Leilao
//
//  Created by Raphael Martin on 04/11/21.
//  Copyright © 2021 Alura. All rights reserved.
//

import Foundation

class Pagamento {
    private var valor: Double
    private var data: Date
    
    init(_ valor: Double, _ data: Date) {
        self.valor = valor
        self.data = data
    }
    
    func getValor() -> Double {
        return valor
    }
    
    func getData() -> Date {
        return data
    }
}
