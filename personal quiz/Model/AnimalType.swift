//
//  AnimalType.swift
//  personal quiz
//
//  Created by Sergiy Fugol on 5/24/17.
//  Copyright © 2019 Sergiy Fugol. All rights reserved.
//

enum AnimalType: Character {
  case dog = "🐶"
  case cat = "🐈"
  case rabbit = "🐇"
  case turtle = "🐢"

  var definition: String {
    switch self {
    case .dog:
      return "You like to be with friends. You surround yourself people who are ready to help them like a faithful dog."
    case .cat:
      return "It’s most important that you surround yourself with positivity always, and have it in your mind at all times."
    case .rabbit:
      return "Keep people in your life that will change it for the better."
    case .turtle:
      return "You need to associate with people that inspire you, people that challenge you to rise higher, people that make you better."
    }
  }
}
