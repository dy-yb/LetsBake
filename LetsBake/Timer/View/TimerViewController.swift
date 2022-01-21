//
//  TimerViewController.swift
//  LetsBake
//
//  Created by Daye on 2021/12/09.
//

import UIKit

class TimerViewController: UIViewController {

  // MARK: - Properties

  enum TimerButtonTag: Int {
    case start = 1
    case stop = 2
    case reset = 3
  }

  var timer: Timer?
  var timeCount = 0

  private var hour: Int = 0
  private var minute: Int = 0
  private var second: Int = 0

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
    let stackView = UIStackView(arrangedSubviews: [resetTimerButton, stopTimerButton, startTimerButton])
    stackView.translatesAutoresizingMaskIntoConstraints = false
    stackView.axis = .horizontal
    stackView.alignment = .fill
    stackView.distribution = .fillEqually
    stackView.spacing = 5
    return stackView
  }()

  lazy var startTimerButton: UIButton = {
    let button = UIButton()
    button.translatesAutoresizingMaskIntoConstraints = false
    button.setImage(UIImage(named: "ic_startTimer_50_on"), for: .normal)
    button.setImage(UIImage(named: "ic_startTimer_50_off"), for: .disabled)
    button.contentMode = .scaleToFill
    button.imageEdgeInsets = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
    button.layer.cornerRadius = 10
    button.titleLabel?.font = .boldSystemFont(ofSize: 20)
    button.addTarget(self, action: #selector(clickedStartTimeButton(_:)), for: .touchUpInside)
    button.tag = TimerButtonTag.start.rawValue
    return button
  }()

  lazy var stopTimerButton: UIButton = {
    let button = UIButton()
    button.translatesAutoresizingMaskIntoConstraints = false
    button.isEnabled = false
    button.setImage(UIImage(named: "ic_stopTimer_50_on"), for: .normal)
    button.setImage(UIImage(named: "ic_stopTimer_50_off"), for: .disabled)
    button.contentMode = .scaleToFill
    button.imageEdgeInsets = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
    button.layer.cornerRadius = 10
    button.titleLabel?.font = .boldSystemFont(ofSize: 20)
    button.addTarget(self, action: #selector(clickedStopTimeButton(_:)), for: .touchUpInside)
    button.tag = TimerButtonTag.stop.rawValue
    return button
  }()

  lazy var resetTimerButton: UIButton = {
    let button = UIButton()
    button.translatesAutoresizingMaskIntoConstraints = false
    button.isEnabled = false
    button.setImage(UIImage(named: "ic_resetTimer_50_on"), for: .normal)
    button.setImage(UIImage(named: "ic_resetTimer_50_off"), for: .disabled)
    button.contentMode = .scaleToFill
    button.imageEdgeInsets = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
    button.layer.cornerRadius = 10
    button.titleLabel?.font = .boldSystemFont(ofSize: 20)
    button.addTarget(self, action: #selector(clickedResetTimeButton(_:)), for: .touchUpInside)
    button.tag = TimerButtonTag.reset.rawValue
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

  func makeTimeLabel(count: Int) -> (String, String, String) {
    let countSec = count
    let countMin = count % 60
    let countHour = (count / 60) % 60

    return (String(countSec), String(countMin), String(countHour))
  }

  @objc func excuteTimePicker(_ sender: Any) {
    print("timer")
  }
  @objc func clickedStartTimeButton(_ sender: UIButton) {
    resetTimerButton.isEnabled = false
    stopTimerButton.isEnabled = true
    startTimerButton.isEnabled = false

    timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true, block: { (_) in self.timeCount += 1
      DispatchQueue.main.async {
        let timeString = self.makeTimeLabel(count: self.timeCount)
        self.timeLabel.text = timeString.0
//        self.decimalLabel.text = ".\(timeString.1)"
      }
    })
  }
  @objc func clickedResetTimeButton(_ sender: UIButton) {
    resetTimerButton.isEnabled = false
    startTimerButton.isEnabled = true
  }
  @objc func clickedStopTimeButton(_ sender: UIButton) {
    stopTimerButton.isEnabled = false
    startTimerButton.isEnabled = true
    resetTimerButton.isEnabled = true
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
