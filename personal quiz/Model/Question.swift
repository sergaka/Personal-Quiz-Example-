//
//  Question.swift
//  personal quiz
//
//  Created by Sergiy Fugol on 5/24/17.
//  Copyright © 2019 Sergiy Fugol. All rights reserved.
//

struct Question {
  var text: String
  var type: ResponceType
  var answers: [Answer]
}

extension Question {
  static func loadData() -> [Question] {
    return [
      Question(
        text: "What type of food do you like most?",
        type: .single,
        answers: [
          Answer(text: "Steak", type: .dog),
          Answer(text: "Fish", type: .cat),
          Answer(text: "Carrots", type: .rabbit),
          Answer(text: "Corn", type: .turtle),
        ]
      ),
      Question(
        text: "What do you like to do?",
        type: .multiple,
        answers: [
          Answer(text: "Walk", type: .dog),
          Answer(text: "Sleep", type: .cat),
          Answer(text: "Hugs", type: .rabbit),
          Answer(text: "Swim", type: .turtle),
        ]
      ),
      Question(
        text: "How do you like traveling by car?",
        type: .ranged,
        answers: [
          Answer(text: "Hate", type: .cat),
          Answer(text: "Scare", type: .rabbit),
          Answer(text: "Like", type: .turtle),
          Answer(text: "Love", type: .dog),
        ]
      ),
    ]
  }
}
