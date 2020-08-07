//
//  MovieViewController.swift
//  mvvmMovies
//
//  Created by Wesley Brito on 26/04/20.
//  Copyright © 2020 wb. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import Kingfisher

class MovieViewController: UIViewController, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    let disposeBag = DisposeBag()
    private var movieViewModel = MovieListViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.title = movieViewModel.title
        bindViewModel()
        movieViewModel.fetchMoviesViewModel()
        
    }

    func bindViewModel() {
        ///Bind TableView
        movieViewModel.movieList.asDriver().drive(tableView.rx.items(cellIdentifier: "movieCell", cellType: MovieTableViewCell.self)) { (index, viewModel, cell) in
            cell.titleLabel.text = viewModel.title
            cell.releaseDateLabel.text = viewModel.releaseDateFormatter
            cell.votePercentageLabel.text = "\(viewModel.voteAverage) %"
            if let posterUrl = URL(string: "https://image.tmdb.org/t/p/w342\(viewModel.posterPath)") {
                cell.posterImageView.kf.setImage(with: posterUrl)
            }
        }.disposed(by: disposeBag)
        
        ///Bind selectedCell TableView
        self.tableView.rx.itemSelected.bind { [weak self] (indexPath) in
            guard let self = self else { return }
            self.tableView.deselectRow(at: indexPath, animated: true)
            self.performSegue(withIdentifier: "detailSegue", sender: self.movieViewModel.getMovieId(index: indexPath.row))
        }.disposed(by: disposeBag)
    }

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination
        if let movieDetailViewController = destination as? MovieDetailViewController,
            let movieId = sender as? Int {
            movieDetailViewController.movieId = movieId
        }
    }
}

extension MovieViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offset: CGFloat = 200
        let bottomEdge = scrollView.contentOffset.y + scrollView.frame.size.height;
        if (bottomEdge + offset >= scrollView.contentSize.height) {
            // Load next batch of products
            movieViewModel.loadMoreMovies()
        }
    }
}
