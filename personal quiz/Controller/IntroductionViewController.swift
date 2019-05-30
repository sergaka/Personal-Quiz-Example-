//
//  IntroductionViewController.swift
//  personal quiz
//
//  Created by Sergiy Fugol on 5/24/17.
//  Copyright © 2019 Sergiy Fugol. All rights reserved.
//

import UIKit

class IntroductionViewController: UIViewController {

  //MARK: - IB Outlets
  @IBOutlet var introduseLabels: [UILabel]!
  @IBOutlet weak var introduseButton: UIButton!

  //MARK: - IB Action
  @IBAction func unwind(segue: UIStoryboardSegue) {
  }

  // MARK: - Stored Properties
  var fontSize = 17

  override func viewDidLoad() {
    super.viewDidLoad()

    /// Font size dependence of screen size
    if UIScreen.main.bounds.width > 375 {
      fontSize = 22
    } else if UIScreen.main.bounds.width > 320 {
      fontSize = 20
    }
    /// Save font size to User Defaults
    UserDefaults.standard.set(fontSize, forKey: "FontSize")
    
   // guard let fontSize = fontSize else { return }

    introduseButton.titleLabel?.font = UIFont.systemFont(ofSize: CGFloat(fontSize))
    for label in introduseLabels {
      label.font = UIFont.systemFont(ofSize: CGFloat(fontSize + 10))
    }
  }
}
