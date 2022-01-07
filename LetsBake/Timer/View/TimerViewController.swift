//
//  TimerViewController.swift
//  LetsBake
//
//  Created by Daye on 2021/12/09.
//

import UIKit

class TimerViewController: UIViewController {
  // MARK: - Properties

//  static let cellID = "TimerViewCell"
  var hour: Int = 0
  var minute: Int = 0
  var second: Int = 0

  // MARK: - UI

  let timeLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.text = "00:00"
    label.font = .systemFont(ofSize: 70, weight: .ultraLight)
    return label
  }()

  let timePicker: UIPickerView = {
    let pickerView = UIPickerView()
    pickerView.translatesAutoresizingMaskIntoConstraints = false
    pickerView.backgroundColor = .mainColor
    pickerView.layer.cornerRadius = 10
    return pickerView
  }()

  let buttonStackView: UIStackView = {
    let stackView = UIStackView()
    stackView.translatesAutoresizingMaskIntoConstraints = false
    stackView.backgroundColor = .yellow
    stackView.alignment = .center
    stackView.distribution = .fillEqually
    stackView.spacing = 50
    return stackView
  }()

  let setTimeButton: UIButton = {
    let button = UIButton()
    button.translatesAutoresizingMaskIntoConstraints = false
    button.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
    button.setTitle("시작", for: .normal)
    button.backgroundColor = .orange
    button.layer.cornerRadius = 10
    return button
  }()

  let pauseTimeButton: UIButton = {
    let button = UIButton()
    button.translatesAutoresizingMaskIntoConstraints = false
    button.setTitle("정지", for: .normal)
    button.backgroundColor = .orange
    button.layer.cornerRadius = 10
    return button
  }()

  let resetTimeButton: UIButton = {
    let button = UIButton()
    button.translatesAutoresizingMaskIntoConstraints = false
    button.setTitle("리셋", for: .normal)
    button.backgroundColor = .orange
    button.layer.cornerRadius = 10
    return button
  }()

  // MARK: - Lifecycle

  override func viewDidLoad() {
    super.viewDidLoad()
    setView()
    layout()
  }

  // MARK: - Layout

  func setView() {
    view.backgroundColor = .white
    view.addSubview(timePicker)
    view.addSubview(timeLabel)
    view.addSubview(buttonStackView)
    buttonStackView.addSubview(setTimeButton)
    buttonStackView.addSubview(pauseTimeButton)
    buttonStackView.addSubview(resetTimeButton)

    timePicker.dataSource = self
    timePicker.delegate = self
  }

  func layout() {

//    setTimeButton.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
//    pauseTimeButton.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
//    resetTimeButton.frame = CGRect(x: 0, y: 0, width: 50, height: 50)

    NSLayoutConstraint.activate([
      timeLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 120),
      timeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),

      timePicker.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      timePicker.centerYAnchor.constraint(equalTo: view.centerYAnchor),
      timePicker.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, constant: -50),
      timePicker.heightAnchor.constraint(equalToConstant: 150),

      buttonStackView.topAnchor.constraint(equalTo: timePicker.bottomAnchor, constant: 30),
      buttonStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      buttonStackView.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, constant: -50),
      buttonStackView.heightAnchor.constraint(equalToConstant: 150)

//      pauseTimeButton.topAnchor.constraint(equalTo: timePicker.bottomAnchor, constant: 50),
//      pauseTimeButton.centerXAnchor.constraint(equalTo: buttonStackView.centerXAnchor),
//
//      resetTimeButton.topAnchor.constraint(equalTo: timePicker.bottomAnchor, constant: 50),
//      resetTimeButton.rightAnchor.constraint(equalTo: pauseTimeButton.leftAnchor, constant: -50),
//
//      setTimeButton.topAnchor.constraint(equalTo: timePicker.bottomAnchor, constant: 50),
//      setTimeButton.leftAnchor.constraint(equalTo: pauseTimeButton.rightAnchor, constant: 50)

    ])
  }

  @objc func excuteTimePicker(_ sender: Any) {
    print("timer")
  }

}

extension TimerViewController: UIPickerViewDelegate, UIPickerViewDataSource {
  func numberOfComponents(in pickerView: UIPickerView) -> Int {
    return 3
  }

  func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
    switch component {
    case 0:
      return 25
    case 1, 2:
      return 60
    default:
      return 0
    }
  }

  func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
    return pickerView.frame.size.width/3
  }

  func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
    switch component {
    case 0:
      return "\(row) hour"
    case 1:
      return "\(row) min"
    case 2:
      return "\(row) sec"
    default:
      return ""
    }
  }

  func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
    switch component {
    case 0:
      hour = row
    case 1:
      minute = row
    case 2:
      second = row
    default:
      break;
    }
  }
}
