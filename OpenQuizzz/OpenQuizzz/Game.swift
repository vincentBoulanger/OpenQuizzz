//
//  Game.swift
//  OpenQuizzz
//
//  Created by VINCENT BOULANGER on 06/07/2018.
//  Copyright © 2018 fr.VincentBoulanger. All rights reserved.
//

import Foundation
class Game {
	var score = 0
	
	private var questions = [Question]()
	private var currentIndex = 0
	
	var state: State = .ongoing
	
	enum State {
		case ongoing, over
	}
	
	var currentQuestion: Question {
		return questions[currentIndex]
	}
	
	
	
	func answerCurrentQuestion(with answer: Bool) {
		if (currentQuestion.isCorrect && answer) || (!currentQuestion.isCorrect && !answer) {
			score += 1
		}
		goToNextQuestion()
	}
	
	private func goToNextQuestion() {
		if currentIndex < questions.count - 1 {
			currentIndex += 1
		} else {
			finishGame()
		}
	}
	
	private func finishGame() {
		state = .over
	}
	private func receiveQuestions(_ questions: [Question]) {
		self.questions = questions
		state = .ongoing
	}
	func refresh() {
		score = 0
		currentIndex = 0
		state = .over
		
	}
}
