//
//  MovieTraillerViewController.swift
//  mvvmMovies
//
//  Created by Wesley Brito on 05/08/20.
//  Copyright © 2020 wb. All rights reserved.
//

import UIKit
import YouTubePlayerSwift

class MovieTraillerViewController: UIViewController {

    @IBOutlet weak var playerView: YouTubePlayerView!
    
    var youtubeKey: String = ""
    @IBOutlet var tapOutsideRecognizer: UITapGestureRecognizer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        playerView.play(videoID: youtubeKey)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if self.tapOutsideRecognizer != nil {
            self.view.window?.removeGestureRecognizer(self.tapOutsideRecognizer)
            self.tapOutsideRecognizer = nil
        }
    }

    func close(sender: AnyObject) {
        self.dismiss(animated: true, completion: nil)
    }

    @IBAction func hadleTapBehind(_ sender: UITapGestureRecognizer) {
        if (sender.state == UIGestureRecognizer.State.ended) {
            let location: CGPoint = sender.location(in: self.playerView)
            if (!self.view.point(inside: location, with: nil)) {
                self.view.window?.removeGestureRecognizer(sender)
                self.close(sender: sender)
            }
        }
    }
}
