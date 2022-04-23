//
//  DiaryViewController.swift
//  LetsBake
//
//  Created by Daye on 2021/12/09.
//

import UIKit
import RealmSwift

class DiaryCollectionViewController: UIViewController {
  // MARK: - Properties
  
  static let cellID = "DiaryCollectionViewCell"
  var savedDiary: Results<DiaryModel>?

  // MARK: - UI
  
  lazy var rightPlusButton: UIBarButtonItem = {
    let button = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(writeDiary(_:)))
    button.tag = 1
    return button
  }()
  
  let diaryCollectionView: UICollectionView = {
    let flowLayout = UICollectionViewFlowLayout.init()
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
    flowLayout.scrollDirection = .vertical
    collectionView.translatesAutoresizingMaskIntoConstraints = false
    collectionView.register(DiaryCollectionViewCell.self, forCellWithReuseIdentifier: DiaryCollectionViewController.cellID)
    collectionView.allowsSelection = true
    return collectionView
  }()
  
  // MARK: - Lifecycle
  
  override func viewWillAppear(_ animated: Bool) {
    self.tabBarController?.tabBar.isHidden = false
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.setView()
    self.layout()
    self.loadDiary()
  }
  
  // MARK: - Layout

  func setView() {
    view.backgroundColor = .white
    navigationItem.title = "Diary"
    navigationItem.rightBarButtonItem = self.rightPlusButton
    diaryCollectionView.dataSource = self
    diaryCollectionView.delegate = self
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

  // MARK: - Functions

  func loadDiary() {
//    let diary = DiaryModel.self
    let realm = RealmManager().realm
    savedDiary = realm?.objects(DiaryModel.self).sorted(byKeyPath: "date")
//    print(savedDiary[0].value(forKey: "title"))
    self.diaryCollectionView.reloadData()
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
    if let diary = savedDiary?[indexPath.row] {
      print(diary)
      cell.configure(diary: diary)
    }
    return cell
  }
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return savedDiary?.count ?? 0
  }
}

extension DiaryCollectionViewController: UICollectionViewDelegate {
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    let diaryDetailView = DiaryDetailViewController()
    navigationController?.pushViewController(diaryDetailView, animated: true)
  }
}

extension DiaryCollectionViewController: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: (view.frame.width - 50), height: (view.frame.width - 50) / 2)
  }
  
  // 셀 간 상하 간격
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    return 20
  }
  
  // 셀 간 좌우 간격
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
    return 5
  }
  
  // collectionView internal margin
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
    return UIEdgeInsets(top: 2.5, left: 2.5, bottom: 2.5, right: 2.5)
  }
}
