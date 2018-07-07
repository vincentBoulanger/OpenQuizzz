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
		startNewGame()
		let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(dragQuestView(_:)))
		questionView.addGestureRecognizer(panGestureRecognizer)
	}
	@objc func questionsLoaded() {
		activityIndicator.isHidden = true
		newGameButton.isHidden = false
		questionView.title = game.currentQuestion.title
	}
	
	
	@objc func dragQuestView(_ sender: UIPanGestureRecognizer) {
		if game.state == .ongoing {
			switch sender .state {
			case .began, .changed:
				transformQuestionViewWith(gesture: sender)
			case .cancelled, .ended:
				answerQuestion()
			default:
				break
			}
		}
	}

	private func transformQuestionViewWith(gesture: UIPanGestureRecognizer) {
		let translation = gesture.translation(in: questionView)
		let translationTransform = CGAffineTransform(translationX: translation.x, y: translation.y)
		_ = UIScreen.main.bounds.width
		let translationPercent = translation.x/(UIScreen.main.bounds.width / 2)
		let rotationAngle = (CGFloat.pi / 3) * translationPercent
		let rotationTransform = CGAffineTransform(rotationAngle: rotationAngle)
		let transform = translationTransform.concatenating(rotationTransform)
		questionView.transform = transform
		
		if translation.x > 0{
			questionView.style = .correct
		} else {
			questionView.style = .incorrect
		}
	}
	private func answerQuestion() {
		switch questionView.style {
		case .correct:
			game.answerCurrentQuestion(with: true)
		case .incorrect:
			game.answerCurrentQuestion(with: false)
		case .standard:
			break
		}
		scoreLabel.text = "\(game.score) / 10"
		
		let screenWidth = UIScreen.main.bounds.width
		var translationTransform:CGAffineTransform
		if questionView.style == .correct {
			translationTransform = CGAffineTransform(translationX: -screenWidth, y:0)
		} else {
			translationTransform = CGAffineTransform(translationX: -screenWidth, y:0)
		}
		UIView.animate(withDuration: 0.3, animations: {
			self.questionView.transform = translationTransform
		}, completion: {(success) in
			if success {
				self.showQuestionView()
			}
		})
	}

	private func showQuestionView() {
		questionView.transform = .identity
		questionView.transform = CGAffineTransform(scaleX: 0.01, y: 0.01)
		questionView.style = .standard
		switch game.state {
			case .ongoing:
				questionView.title = game.currentQuestion.title
			case .over :
				questionView.title = "Game Over"
		}
		UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: [], animations: {
			self.questionView.transform = .identity
		}, completion: nil)
	}
//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//        // Dispose of any resources that can be recreated.
//    }

	
}

