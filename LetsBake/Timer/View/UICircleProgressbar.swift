//
//  CircleProgressViewController.swift
//  LetsBake
//
//  Created by Daye on 2022/01/09.
//

import Foundation
import UIKit

//class UICirecleProgressbar: UIView {
//    // 전역변수
//    let circle = CAShapeLayer()
//    let pause = CAShapeLayer()
//    let progress = CAShapeLayer()
//    let masks = CAShapeLayer()
//    let black = UIColor.black.cgColor
//    // 초기값
//    var value:CGFloat = 0.0
//
//    required init?(coder: NSCoder) {
//        super.init(coder: coder)
//        start()
//    }
//
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        start()
//    }
//
//    func start() {
//        // 크기
//        let rect = self.bounds
//        let pauseRect = rect.insetBy(dx: rect.width/3, dy: rect.height/3)
//        let radius = min(rect.width, rect.height) / 2
//        let center = CGPoint(x: rect.midX, y: rect.midY)
//        // 레이어 추가
//        for layer in [progress, pause, circle] {
//            layer.strokeColor = black
//            layer.fillColor = nil
//            self.layer.addSublayer(layer)
//        }
//        // 프로그레스 두께 및 색상
//        progress.lineWidth = 15
//        progress.strokeColor = UIColor.green.cgColor
//        // 일시 정지 버튼 색상
//        pause.fillColor = black
//        // 패스 설정
//        pause.path = UIBezierPath(rect: pauseRect).cgPath
//      circle.path = UIBezierPath(ovalIn: rect).cgPath
//        progress.path = UIBezierPath(arcCenter: center, radius: radius, startAngle: 0, endAngle: CGFloat(2 * M_PI), clockwise: true).cgPath
//      masks.path = UIBezierPath(ovalIn: rect).cgPath
//        // 마스크 설정, 외곽 테두리 안보이게
//        progress.mask = masks
//        progress.strokeStart = 0
//        // 상태 갱신
//        update()
//    }
//
//    func update() {
//        // 1.0 되면 다시 시작
//        if value <= 1.0 {
//            value += 0.01
//        } else {
//            value = 0.0
//        }
//        // 0.1초 후에 재귀시작
////      let delayTime = dispatch_time(dispatch_time_t(DISPATCH_TIME_NOW), Int64(0.1 * Double(NSEC_PER_SEC)))
////        dispatch_after(delayTime, dispatch_get_main_queue()) {
////            self.progress.strokeEnd = self.value
////            self.Update()
////        }
//    }
//
//
//}

class UICircleProgressbar: UIView {

  // MARK: - Properties

  lazy var circlePath = UIBezierPath(arcCenter: CGPoint(x: self.frame.size.width / 2.0, y: self.frame.size.height / 2.0), radius: frame.size.width, startAngle: CGFloat(0), endAngle: CGFloat(1.5*Double.pi), clockwise: true)

  let circleProgress = CAShapeLayer()

  override init(frame: CGRect) {
    super.init(frame: frame)
    setView()
  }

  required init?(coder: NSCoder) {
    super.init(coder: coder)
    setView()
  }

  func setView() {
    circleProgress.path = circlePath.cgPath
    circleProgress.fillColor = UIColor.clear.cgColor
    circleProgress.strokeColor = UIColor.black.cgColor
    layer.addSublayer(circleProgress)
  }
}
