//
//  MovieListViewModel.swift
//  mvvmMovies
//
//  Created by Wesley Brito on 26/04/20.
//  Copyright © 2020 wb. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import Moya

final class MovieListViewModel: BaseViewModel {
    let title = "Filmes"
    let disposeBag = DisposeBag()
    private var page: Int = 1
    private let movieService: MovieService
    var movieList = BehaviorRelay<[Movie]>(value: [])
    var totalPages = 0
    
    init (stub: Bool = false) {
        self.movieService = MovieService(stub: stub)
    }
    
    func fetchMoviesViewModel(page: Int = 1, isLoading: Bool = false) {
        movieService.fetchMovies(page: page).subscribe(onSuccess: { [weak self] response in
            guard let self = self else { return }
            do {
                let object = try JSONDecoder().decode(MovieList.self, from: response.data)
                self.totalPages = object.totalPages
                self.movieList.accept(isLoading ? self.movieList.value + object.list : object.list)
            } catch {
                self.errorObject.onNext("Erro na no parse")
                self.errorObject.onCompleted()
            }
        }, onError: { [weak self] error in
            guard let self = self,
            let moyaError = error as? MoyaError else { return }
            self.errorRequest(moyaError: moyaError)
        }).disposed(by: disposeBag)
    }

    func loadMoreMovies() {
        if page <= self.totalPages {
            page += 1
            fetchMoviesViewModel(page: page, isLoading: true)
        }
    }

    func getMovieId(index: Int) -> Int {
        return movieList.value[index].id
    }
}
