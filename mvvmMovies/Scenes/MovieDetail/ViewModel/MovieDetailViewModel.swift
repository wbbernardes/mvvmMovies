//
//  MovieDetailViewModel.swift
//  mvvmMovies
//
//  Created by Wesley Brito on 04/08/20.
//  Copyright © 2020 wb. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import Moya

final class MovieDetailViewModel: BaseViewModel {
    let disposeBag = DisposeBag()
    private let movieService: MovieService
    
    var movieDetail = BehaviorRelay<MovieDetail>(value: MovieDetail(id: 0, title: "", overview: "", backdropPath: "", posterPath: ""))
    var movieTrailerKey = BehaviorRelay<[MovieTrailerKey]>(value: [])
    
    init (stub: Bool = false) {
        self.movieService = MovieService(stub: stub)
    }

    func fetchMovieDetailViewModel(movieId: Int) {
        let dispatchGroup = DispatchGroup()
        
        dispatchGroup.enter()
        movieService.fetchMovieDetail(movieId: movieId).subscribe(onSuccess: { [weak self] (response) in
            guard let self = self else { return }
            do {
                let object = try JSONDecoder().decode(MovieDetail.self, from: response.data)
                self.movieDetail.accept(object)
                dispatchGroup.leave()
            } catch {
                self.errorObject.onNext("Erro na no parse")
                self.errorObject.onCompleted()
                dispatchGroup.leave()
            }
        }, onError: { [weak self] error in
            guard let self = self,
            let moyaError = error as? MoyaError else { return }
            self.errorRequest(moyaError: moyaError)
            dispatchGroup.leave()
        }).disposed(by: disposeBag)

        dispatchGroup.enter()
        movieService.fetchMovieTrailer(movieId: movieId).subscribe(onSuccess: { [weak self] (response) in
            guard let self = self else { return }
            do {
                let object = try JSONDecoder().decode(MovieTrailer.self, from: response.data)
                self.movieTrailerKey.accept(object.results)
                dispatchGroup.leave()
            } catch {
                self.errorObject.onNext("Erro na no parse")
                self.errorObject.onCompleted()
                dispatchGroup.leave()
            }
            }, onError: { [weak self] error in
                guard let self = self,
                let moyaError = error as? MoyaError else { return }
                self.errorRequest(moyaError: moyaError)
                dispatchGroup.leave()
        }).disposed(by: disposeBag)
        
        dispatchGroup.notify(queue: .main) { }
    }

    func getTrailerKey() -> String {
        if movieTrailerKey.value.count > 0 {
            return movieTrailerKey.value[0].key
        }
        return ""
    }
}
