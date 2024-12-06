// TriviaAPIOutput.swift
// opentrivia
// created by olivier falahi 2024

struct TriviaAPIOutput: Decodable {

    let results: [Results]

    enum CodingKeys: String, CodingKey {
        case results = "results"
    }

    struct Results: Decodable{
        let difficulty: String
        let category: String
        let question : String
        let correctAnswer: String
        let incorrectAnswers: [String]

        enum CodingKeys: String, CodingKey {
                    case difficulty = "difficulty"
                    case category = "category"
                    case question = "question"
                    case correctAnswer = "correct_answer"
                    case incorrectAnswers = "incorrect_answers"
                }

    }

}