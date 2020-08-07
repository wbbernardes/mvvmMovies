//
//  BaseViewModel.swift
//  mvvmMovies
//
//  Created by Wesley Brito on 03/08/20.
//  Copyright © 2020 wb. All rights reserved.
//

import Foundation
import Moya
import RxSwift

class BaseViewModel {
    var errorObject: PublishSubject<String> = PublishSubject<String>()
    
    public func errorRequest(moyaError: MoyaError) {
        switch moyaError.response?.statusCode {
        case 401:
            self.errorObject.onNext("Usuário não autorizado")
        case 500:
            self.errorObject.onNext("Erro na Comunicação com o Servidor")
        default:
            self.errorObject.onNext("Erro na Comunicação com o Servidor")
        }
    }
}
