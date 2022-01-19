//
//  TimerViewController.swift
//  LetsBake
//
//  Created by Daye on 2021/12/09.
//

import UIKit

class TimerViewController: UIViewController {

  // MARK: - Properties

private  var hour: Int = 0
private  var minute: Int = 0
private  var second: Int = 0

  // MARK: - UI

  let timeLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.text = "00:00:00"
    label.font = .systemFont(ofSize: 70, weight: .ultraLight)
    return label
  }()

  let timePicker: UIPickerView = {
    let pickerView = UIPickerView()
    pickerView.translatesAutoresizingMaskIntoConstraints = false
    pickerView.layer.cornerRadius = 10
    return pickerView
  }()

  lazy var buttonStackView: UIStackView = {
    let stackView = UIStackView(arrangedSubviews: [resetTimeButton, setTimeButton, pauseTimeButton])
    stackView.translatesAutoresizingMaskIntoConstraints = false
    stackView.axis = .horizontal
    stackView.alignment = .fill
    stackView.distribution = .fillEqually
    stackView.spacing = 20
    return stackView
  }()

  let setTimeButton: UIButton = {
    let button = UIButton()
    button.translatesAutoresizingMaskIntoConstraints = false
    button.setTitle("시작", for: .normal)
    button.setImage(UIImage(named: "ic_setTimer_50"), for: .normal)
    button.layer.cornerRadius = 10
    button.titleLabel?.font = .boldSystemFont(ofSize: 20)
    return button
  }()

  let pauseTimeButton: UIButton = {
    let button = UIButton()
    button.translatesAutoresizingMaskIntoConstraints = false
    button.setTitle("정지", for: .normal)
    button.setImage(UIImage(named: "ic_pauseTimer_50"), for: .normal)
    button.layer.cornerRadius = 10
    button.setTitleColor(.black, for: .normal)
    button.titleLabel?.font = .boldSystemFont(ofSize: 20)
    return button
  }()

  let resetTimeButton: UIButton = {
    let button = UIButton()
    button.translatesAutoresizingMaskIntoConstraints = false
    button.setTitle("리셋", for: .normal)
    button.setImage(UIImage(named: "ic_resetTimer_50"), for: .normal)
    button.layer.cornerRadius = 10
    button.titleLabel?.font = .boldSystemFont(ofSize: 20)
    button.contentVerticalAlignment = .center
    button.semanticContentAttribute = .forceRightToLeft
    return button
  }()

  let progressView: UIView = {
    let view = UIView()
    view.translatesAutoresizingMaskIntoConstraints = false
    view.backgroundColor = .blue
    return view
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
    progressView.addSubview(timeLabel)
    view.addSubview(buttonStackView)
    view.addSubview(progressView)

    timePicker.dataSource = self
    timePicker.delegate = self
  }

  func layout() {
    NSLayoutConstraint.activate([
      progressView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      progressView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 120),
      progressView.heightAnchor.constraint(equalToConstant: 200),

      timeLabel.topAnchor.constraint(equalTo: progressView.topAnchor, constant: 10),
      timeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),

      timePicker.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      timePicker.centerYAnchor.constraint(equalTo: view.centerYAnchor),
      timePicker.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, constant: -100),
      timePicker.heightAnchor.constraint(equalToConstant: 150),

      buttonStackView.topAnchor.constraint(equalTo: timePicker.bottomAnchor, constant: 50),
      buttonStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      buttonStackView.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, constant: -80),
      buttonStackView.heightAnchor.constraint(equalTo: buttonStackView.widthAnchor, multiplier: 0.3)
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
