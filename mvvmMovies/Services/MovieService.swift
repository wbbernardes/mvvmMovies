//
//  MovieService.swift
//  mvvmMovies
//
//  Created by Wesley Brito on 26/04/20.
//  Copyright © 2020 wb. All rights reserved.
//

import Foundation
import RxSwift
import Moya
import RxCocoa

class MovieService {
    var movieProvider = MoyaProvider<MovieProvider>()

    init(stub: Bool = false ) {
        movieProvider = stub ? MoyaProvider<MovieProvider>(stubClosure: MoyaProvider.immediatelyStub) : MoyaProvider<MovieProvider>()
    }

    func fetchMovies(page: Int) -> Single<Response> {
        return movieProvider.rx.request(.getMovies(page: page)).filterSuccessfulStatusCodes()
    }

    func fetchMovieDetail(movieId: Int) -> Single<Response> {
        return movieProvider.rx.request(.getMoviesDetail(movieId: movieId)).filterSuccessfulStatusCodes()
    }

    func fetchMovieTrailer(movieId: Int) -> Single<Response> {
        return movieProvider.rx.request(.getMoviesTrailer(movieId: movieId)).filterSuccessfulStatusCodes()
    }
}
