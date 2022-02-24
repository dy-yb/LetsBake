//
//  TimerViewController.swift
//  LetsBake
//
//  Created by Daye on 2021/12/09.
//

import UIKit

class TimerViewController: UIViewController {

  // MARK: - Properties

  private let timerViewModel = TimerViewModel()

  enum TimerButtonTag: Int {
    case start = 1
    case pause = 2
    case stop = 3
  }

  private var timer: Timer?
  private var timeCount = 0

  private var inputHour: Int = 0
  private var inputMinute: Int = 0
  private var inputSecond: Int = 0

  // MARK: - UI

  private let timeLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.text = "00:00:00"
    label.font = .systemFont(ofSize: 70, weight: .ultraLight)
    return label
  }()

  private let timePicker: UIPickerView = {
    let pickerView = UIPickerView()
    pickerView.translatesAutoresizingMaskIntoConstraints = false
    return pickerView
  }()

  private lazy var buttonStackView: UIStackView = {
    let stackView = UIStackView(arrangedSubviews: [startTimerButton, pauseTimerButton, stopTimerButton])
    stackView.translatesAutoresizingMaskIntoConstraints = false
    stackView.axis = .horizontal
    stackView.alignment = .fill
    stackView.distribution = .fillEqually
    stackView.spacing = 5
    return stackView
  }()

  private lazy var startTimerButton: UIButton = {
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

  private lazy var stopTimerButton: UIButton = {
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

  private lazy var pauseTimerButton: UIButton = {
    let button = UIButton()
    button.translatesAutoresizingMaskIntoConstraints = false
    button.isEnabled = false
    button.setImage(UIImage(named: "ic_pauseTimer_50_on"), for: .normal)
    button.setImage(UIImage(named: "ic_pauseTimer_50_off"), for: .disabled)
    button.contentMode = .scaleToFill
    button.imageEdgeInsets = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
    button.layer.cornerRadius = 10
    button.titleLabel?.font = .boldSystemFont(ofSize: 20)
    button.addTarget(self, action: #selector(clickedPauseTimeButton(_:)), for: .touchUpInside)
    button.tag = TimerButtonTag.pause.rawValue
    return button
  }()

  private let progressView: UIView = {
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
    setBinding()
  }

  // MARK: - Layout

  func setView() {
    view.backgroundColor = .white
    navigationItem.title = "타이머"
    view.addSubview(timePicker)
    progressView.addSubview(timeLabel)
    view.addSubview(buttonStackView)
    view.addSubview(progressView)

    timePicker.setPickerLabelsWith(labels: ["시간", "분", "초"])
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
      timePicker.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, constant: -50),
      timePicker.heightAnchor.constraint(equalToConstant: 200),

      buttonStackView.topAnchor.constraint(equalTo: timePicker.bottomAnchor, constant: 50),
      buttonStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      buttonStackView.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, constant: -80),
      buttonStackView.heightAnchor.constraint(equalTo: buttonStackView.widthAnchor, multiplier: 0.3)
    ])
  }

  // MARK: - functions

  func setBinding() {
    timerViewModel.time.subscribe { value in
      DispatchQueue.main.async {
        self.timeLabel.text = value
      }
    }
  }

  @objc func excuteTimeCount() {
    if timeCount != 0 {
      timeCount -= 1
      timerViewModel.setTimeLabel(timeCount: timeCount)
    } else {
      stopTimerButton.isEnabled = false
      startTimerButton.isEnabled = true
      pauseTimerButton.isEnabled = false
      timer?.invalidate()
    }
  }

  @objc func clickedStartTimeButton(_ sender: UIButton) {
    if timeCount != 0 {
      UIView.animate(withDuration: 0.5, animations: {
        self.buttonStackView.transform = CGAffineTransform(translationX: 0, y: -100)
      })
      timePicker.reloadInputViews()
      pauseTimerButton.isEnabled = true
      stopTimerButton.isEnabled = true
      startTimerButton.isEnabled = false
      timePicker.isHidden = true

          if timer == nil {
            timeCount = timerViewModel.setTimeCount(hour: inputHour, minute: inputMinute, second: inputSecond)
          }
      timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(excuteTimeCount), userInfo: nil, repeats: true)
    }
  }

  @objc func clickedPauseTimeButton(_ sender: UIButton) {
    pauseTimerButton.isEnabled = false
    startTimerButton.isEnabled = true
    stopTimerButton.isEnabled = true
    timer?.invalidate()
  }

  @objc func clickedStopTimeButton(_ sender: UIButton) {
    UIView.animate(withDuration: 0.5, animations: {
      self.buttonStackView.transform = CGAffineTransform(translationX: 0, y: 0)
    })
    stopTimerButton.isEnabled = false
    startTimerButton.isEnabled = true
    pauseTimerButton.isEnabled = false
    timePicker.isHidden = false
    timer?.invalidate()

    timePicker.selectRow(0, inComponent: 0, animated: false)
    timePicker.selectRow(0, inComponent: 1, animated: false)
    timePicker.selectRow(0, inComponent: 2, animated: false)
    inputHour = 0
    inputMinute = 0
    inputSecond = 0
    timeCount = timerViewModel.setTimeCount(hour: 0, minute: 0, second: 0)
    timerViewModel.setTimeLabel(timeCount: timeCount)
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
    return pickerView.frame.size.width / 3
  }
  func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
    return 30
  }

  func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
    switch component {
    case 0:
      return "\(row)"
    case 1:
      return "\(row)"
    case 2:
      return "\(row)"
    default:
      return ""
    }
  }

  func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
    switch component {
    case 0:
      inputHour = row
    case 1:
      inputMinute = row
    case 2:
      inputSecond = row
    default:
      break;
    }
    timeCount = timerViewModel.setTimeCount(hour: inputHour, minute: inputMinute, second: inputSecond)
    timerViewModel.setTimeLabel(timeCount: timeCount)
  }
}
