// The Swift Programming Language
// https://docs.swift.org/swift-book

import Foundation
import Dispatch


// NB: Replace the `DispatchQueue.main.asyncAfter` with your code.
// Once the program is done, call `exit(EXIT_SUCCESS)` to exit the program.

/*DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
    print("I'm done!")
    exit(EXIT_SUCCESS)
}*/

let nbQuestions = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10"]
let triviaApiRepository = TriviaAPIRepository()

if #available(macOS 13, *){
    var score = 0
    var quitGame = true

    print("\u{001B}[32m")
    print("?¿?¿?¿?¿?¿?¿?¿?¿?¿?¿?¿?¿?¿")
    print("?¿?¿?¿?¿?¿?¿?¿?¿?¿?¿?¿?¿?¿")
    print("? WELCOME TO TRIVIA GAME ¿")
    print("?¿?¿?¿?¿?¿?¿?¿?¿?¿?¿?¿?¿?¿")
    print("?¿?¿?¿?¿?¿?¿?¿?¿?¿?¿?¿?¿?¿")
    print("\u{001B}[0m")

    repeat{
        print("How many questions do you want to answer ?")
        var howMany = ""

        repeat {
            print("(from 1 to 10)")
            howMany = readLine(strippingNewline: true)!
        } while !nbQuestions.contains(howMany)

        let questions = try await triviaApiRepository.getQuestions(howMany: Int(howMany)!)

        for i in 0..<questions.count{
            let randAnswer: [Answer] = triviaApiRepository.getRandomAnswers(question: questions[i])

            let formatedCategory = triviaApiRepository.formatString(from: questions[i].category)

            var coloredDifficulty = ""
            switch questions[i].difficulty {
                case "easy":
                    coloredDifficulty = "\u{001B}[32m" + questions[i].difficulty + "\u{001B}[0m"
                    break
                case "medium":
                    coloredDifficulty = "\u{001B}[33m" + questions[i].difficulty + "\u{001B}[0m"
                    break
                case "hard":
                    coloredDifficulty = "\u{001B}[31m" + questions[i].difficulty + "\u{001B}[0m"
                    break
                default:
                    coloredDifficulty = questions[i].difficulty
            }

            print("❓ Question #\(i+1) (\(formatedCategory) - Difficulty : \(coloredDifficulty))")

            let formatedQuestion = triviaApiRepository.formatString(from: questions[i].question)
            print(formatedQuestion)

            for j in 0..<randAnswer.count{
                let formatedAnswer = triviaApiRepository.formatString(from: randAnswer[j].answer)
                print("   \(j+1). \(formatedAnswer)")
            }

            var input = ""
            print("Type your answer and press enter")
            switch randAnswer.count{
                case 4:
                    repeat {
                        print("(between 1 and 4)")
                        input = readLine(strippingNewline: true)!
                    } while input != "1" && input != "2" && input != "3" && input != "4"
                    break
                case 2:
                    repeat {
                        print("(between 1 and 2)")
                        input = readLine(strippingNewline: true)!
                    } while input != "1" && input != "2"
                    break
                default:
                    print("error")
            }
            let answer = Int(input)
            if randAnswer[answer! - 1].correct {
                print("✅ Good answer !!!")
                score += 1
            } else {
                print("❌ Wrong answer !!!")
                for n in 0..<randAnswer.count{
                    if randAnswer[n].correct {
                    print("The good answer was : \(randAnswer[n].answer)")
                    }
                }
            }
            print("Your score : \(score)")
            print("Press enter to continue")
            readLine(strippingNewline: true)
        }
        print("Your final score was : \(score)/\(Int(howMany)!)")

        switch score {
            case 0:
                print("Keep up and try next time 😊")
            case Int(howMany)!:
                print("Very nice job ! You rocks ! 🚀")
            default:
                print("Not bad, keep going ! 👍🏻")
        }

        var quitPrompt = ""

        repeat{
            print("Restart game ? (y/n)")
            quitPrompt = readLine(strippingNewline: true)!
        } while quitPrompt != "y" && quitPrompt != "n"

        if (quitPrompt == "y") {
            quitGame = false
            print("\u{001B}[32m")
            print("?¿?¿?¿?¿?¿?¿?¿?¿?¿?¿?¿?¿?¿")
            print("?¿?¿?¿?¿?¿?¿?¿?¿?¿?¿?¿?¿?¿")
            print("?¿?¿?¿ TRIVIA  GAME ?¿?¿?¿")
            print("?¿?¿?¿?¿?¿?¿?¿?¿?¿?¿?¿?¿?¿")
            print("?¿?¿?¿?¿?¿?¿?¿?¿?¿?¿?¿?¿?¿")
            print("\u{001B}[0m")
        }

        score = 0
        } while !quitGame
    print("💚💚 Thank you for playing 💚💚")
    print("💚💚 Olivier Falahi  ©2024 💚💚")

    exit(EXIT_SUCCESS)
    }

dispatchMain()
