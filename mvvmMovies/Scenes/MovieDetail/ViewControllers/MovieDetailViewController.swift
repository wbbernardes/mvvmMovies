//
//  MovieDetailViewController.swift
//  mvvmMovies
//
//  Created by Wesley Brito on 29/07/20.
//  Copyright © 2020 wb. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import Kingfisher

class MovieDetailViewController: UIViewController {

    @IBOutlet weak var banerImageView: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var trailerButton: UIButton! {
        didSet {
            trailerButton.layer.cornerRadius = 15
            trailerButton.layer.borderWidth = 2.0
            trailerButton.layer.borderColor = #colorLiteral(red: 0.3333333433, green: 0.3333333433, blue: 0.3333333433, alpha: 1)
        }
    }
    
    var movieId: Int = 0
    let disposeBag = DisposeBag()
    private var movieDetailViewModel = MovieDetailViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
        movieDetailViewModel.fetchMovieDetailViewModel(movieId: movieId)
    }

    func bindViewModel() {
        movieDetailViewModel.movieDetail.subscribe(onNext: { [weak self] (movieDetail) in
            guard let self = self,
                let bannerUrl = URL(string: "https://image.tmdb.org/t/p/w342\(movieDetail.backdropPath)") else { return }
            self.navigationItem.title = movieDetail.title
            self.banerImageView.kf.setImage(with: bannerUrl)
            self.descriptionLabel.text = movieDetail.overview
        }).disposed(by: disposeBag)

        trailerButton.rx.tap.bind { [weak self] _ in
            guard let self = self else { return }
            self.performSegue(withIdentifier: "trailerSegue", sender: self.movieDetailViewModel.getTrailerKey())
        }.disposed(by: disposeBag)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination
        if let movieTraillerViewController = destination as? MovieTraillerViewController,
            let trailerKey = sender as? String {
            movieTraillerViewController.youtubeKey = trailerKey
        }
    }
}
