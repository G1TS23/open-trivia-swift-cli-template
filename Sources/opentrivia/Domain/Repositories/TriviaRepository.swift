// TriviaRepository.swift
// opentrivia
// created by olivier falahi 2024

import Foundation

/// Handle trivia data
public protocol TriviaRepository {

    /// Get questions from open trivia
    /// - Paramter howMany: number of question
    /// - Return: An array of `Question`.
    @available(macOS 12, *)
    func getQuestions(howMany: Int) async throws -> [Question]

    /// Randomize answer
    func getRandomAnswers(question: Question) -> [Answer]

    /// Return formated string
    func formatString(from: String) -> String
}