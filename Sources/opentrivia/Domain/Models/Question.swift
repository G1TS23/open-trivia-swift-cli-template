// Question.swift
// opentrivia
// created by olivier falahi 2024

import Foundation

public struct Question {

    /// The difficulty
    public let difficulty: String
    /// The category
    public let category: String
    /// The question itself
    public let question: String
    /// The correct answer
    public let correctAnswer: String
    /// An array of three incorrect answers.
    public let incorrectAnswers: [String]
}