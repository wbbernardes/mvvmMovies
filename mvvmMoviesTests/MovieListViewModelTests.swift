//
//  MovieListViewModelTests.swift
//  mvvmMoviesTests
//
//  Created by Wesley Brito on 22/07/20.
//  Copyright © 2020 wb. All rights reserved.
//

import XCTest
@testable import mvvmMovies

class MovieListViewModelTests: XCTestCase {

    var movieListViewModel: MovieListViewModel!

    
    override func setUpWithError() throws {
        movieListViewModel = MovieListViewModel(stub: true)
        
    }

    override func tearDownWithError() throws {
        movieListViewModel = nil
    }

    func test_if_request_api() {
        _ = movieListViewModel.fetchMovieViewModels()
    }

}
