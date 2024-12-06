// TriviaAPIRepository.swift
// opentrivia
// created by olivier falahi 2024


import Foundation

final class TriviaAPIRepository: TriviaRepository {

    @available(macOS 12, *)
    private func questionsFrom(output: TriviaAPIOutput) -> [Question] {
            var results: [Question] = []
            for i in 0..<output.results.count {
                let question = Question(
                    difficulty: output.results[i].difficulty,
                    category: output.results[i].category,
                    question: output.results[i].question,
                    correctAnswer: output.results[i].correctAnswer,
                    incorrectAnswers: output.results[i].incorrectAnswers
                )
                results.append(question)
            }
            return results
        }

    @available(macOS 12, *)
    func getQuestions(howMany: Int) async throws -> [Question]{
        do {
            let url = URL(string: "https://opentdb.com/api.php?amount=\(howMany)")!

            let data = try await URLSession.shared.data(from: url).0
            //print(data)
            let output = try JSONDecoder().decode(TriviaAPIOutput.self, from: data)
            //print(output)
            return questionsFrom(output: output)
        } catch {
            print("Please connect to internet")
            return []
        }
    }

    func formatString(from: String) -> String{


        if let data = from.data(using: .utf8),
           let decodedString = String(data: data, encoding: .utf8)?
                .replacingOccurrences(of: "&quot;", with: "\"")
                .replacingOccurrences(of: "&#039;", with: "'")
                .replacingOccurrences(of: "&euml;", with: "ë")
                .replacingOccurrences(of: "&eacute;", with: "é")
                .replacingOccurrences(of: "&amp;", with: "&")
                .replacingOccurrences(of: "&ouml;", with: "ö")
                .replacingOccurrences(of: "&oslash;", with: "ø") {
                return(decodedString)
            print(decodedString)
        } else {
            return from
        }
    }


    func getRandomAnswers(question: Question) -> [Answer]{
        var randomAnswer: [Answer] = []
        randomAnswer.append(Answer(answer: question.correctAnswer, correct: true))


        for i in 0..<question.incorrectAnswers.count {
            randomAnswer.append(Answer(answer: question.incorrectAnswers[i], correct: false))
        }
        if randomAnswer.count > 2 {
            randomAnswer.shuffle()
        }
        //print(randomAnswer)
        return randomAnswer
    }
}