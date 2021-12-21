//
//  DiaryViewController.swift
//  LetsBake
//
//  Created by Daye on 2021/12/09.
//

import UIKit

class DiaryCollectionViewController: UIViewController {
  // MARK: - Properties

  static let cellID = "DiaryCollectionViewCell"

  // MARK: - UI

  lazy var rightPlusButton: UIBarButtonItem = {
    let button = UIBarButtonItem(barButtonSystemItem: .add, target: self, action:  #selector(writeDiary(_:)))
    button.tag = 1
    return button
  }()

  let diaryCollectionView: UICollectionView = {
    let flowLayout = UICollectionViewFlowLayout.init()
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
    flowLayout.scrollDirection = .vertical
    collectionView.translatesAutoresizingMaskIntoConstraints = false
    collectionView.register(DiaryCollectionViewCell.self, forCellWithReuseIdentifier: DiaryCollectionViewController.cellID)
    return collectionView
  }()

  // MARK: - Lifecycle

  override func viewDidLoad() {
    super.viewDidLoad()
    setView()
    layout()
  }

  // MARK: - Layout

  func setView() {
    view.backgroundColor = .brown
    navigationItem.title = "Diary"
    navigationItem.rightBarButtonItem = self.rightPlusButton
    diaryCollectionView.dataSource = self
    view.addSubview(diaryCollectionView)
  }

  func layout() {
    NSLayoutConstraint.activate([
      diaryCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
      diaryCollectionView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
      diaryCollectionView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
      diaryCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
    ])
  }

  @objc func writeDiary(_ send: Any) {
    self.hidesBottomBarWhenPushed = true
    self.navigationController?.pushViewController(DiaryWriteViewController(), animated: true)
    print("called")
  }
}

// MARK: - Extensions

extension DiaryCollectionViewController: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DiaryCollectionViewController.cellID, for: indexPath) as? DiaryCollectionViewCell else {
      return UICollectionViewCell()
    }
    return cell
  }

  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 3
  }
}

extension DiaryCollectionViewController: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: (view.frame.width - 50), height: (view.frame.width - 50) / 3)
  }

  // 셀 간 상하 간격
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    return 2.5
  }

  // 셀 간 좌우 간격
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
    return 2.5
  }

  // collectionView internal margin
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
    return UIEdgeInsets(top: 2.5, left: 2.5, bottom: 2.5, right: 2.5)
  }
}
