//
//  CircleProgressViewController.swift
//  LetsBake
//
//  Created by Daye on 2022/01/09.
//

import Foundation
import UIKit

class CircularProgressBarView: UIView {

  // MARK: - Properties -

  private var circleLayer = CAShapeLayer()
  private var progressLayer = CAShapeLayer()
  private var startPoint = CGFloat(-Double.pi / 2)
  private var endPoint = CGFloat(3 * Double.pi / 2)

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
