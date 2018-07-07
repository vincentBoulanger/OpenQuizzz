//
//  ViewController.swift
//  OpenQuizzz
//
//  Created by Vincent Boulanger on 15/06/2018.
//  Copyright © 2018 fr.VincentBoulanger. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

	@IBOutlet weak var newGameButton: UIButton!
	@IBOutlet weak var activityIndicator: UIActivityIndicatorView!
	@IBOutlet weak var scoreLabel: UILabel!
	@IBOutlet weak var questionView: QuestionView!
	var game = Game()
	
	private func startNewGame() {
		activityIndicator.isHidden = false
		newGameButton.isHidden = true
		questionView.title = "Loading"
		questionView.style = .standard
		scoreLabel.text = "0 / 10"
		game.refresh()
	}

	@IBAction func didTapNewGameButton() {
		startNewGame()
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		let name = Notification.Name(rawValue: "QuestionsLoaded")
		NotificationCenter.default.addObserver(self, selector: #selector(questionsLoaded), name: name, object: nil)
		//startNewGame()

	}
	@objc func questionsLoaded() {
	activityIndicator.isHidden = true
		newGameButton.isHidden = false
		questionView.title = game.currentQuestion.title
	}
	




//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//        // Dispose of any resources that can be recreated.
//    }

	
}

