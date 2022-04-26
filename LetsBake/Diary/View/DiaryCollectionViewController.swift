//
//  DiaryViewController.swift
//  LetsBake
//
//  Created by Daye on 2021/12/09.
//

import UIKit
import RealmSwift

enum CollectionViewMode {
  case view
  case remove
}

class DiaryCollectionViewController: UIViewController {
  // MARK: - Properties
  
  static let cellID = "DiaryCollectionViewCell"
  var savedDiary: Results<DiaryModel>?
//  var selectedIndexPath: [IndexPath : Bool] = [:]
  var collectionViewMode: CollectionViewMode = .view
//  {
//    didSet {
//      switch collectionViewMode {
//      case .view:
//        for (key, value) in selectedIndexPath {
//          if value {
//            self.diaryCollectionView.deselectItem(at: key, animated: true)
//          }
//        }
//        selectedIndexPath.removeAll()
//
//      case .remove:
//        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "삭제", style: .plain, target: self, action: #selector(deleteDiary(_:)) )
//        self.diaryCollectionView.allowsMultipleSelection = true
//      }
//    }
//  }

  // MARK: - UI

  lazy var longPressGesture: UILongPressGestureRecognizer = {
    let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPressGesture))
    longPressGesture.minimumPressDuration = 1.0
    return longPressGesture
  }()

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
    self.view.backgroundColor = .white
    self.view.gestureRecognizers = [longPressGesture]
    self.navigationItem.title = "Diary"
    self.navigationItem.rightBarButtonItem = self.rightPlusButton
    self.diaryCollectionView.dataSource = self
    self.diaryCollectionView.delegate = self
    self.view.addSubview(diaryCollectionView)
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
    let realm = RealmManager().realm
    savedDiary = realm?.objects(DiaryModel.self).sorted(byKeyPath: "date")
  }

  @objc func writeDiary(_ send: Any) {
    self.hidesBottomBarWhenPushed = true
    self.navigationController?.pushViewController(DiaryWriteViewController(), animated: true)
    print("called")
  }

  @objc func deleteDiary(_ sender: Any) {
//    var willDeleteDiaryIndexPath: [IndexPath] = []
//
//    for (key, value) in selectedIndexPath {
//      if value {
//        willDeleteDiaryIndexPath.append(key)
//      }
//    }
//    RealmManager().deleteObjcets(objc: savedDiary)
////    for i in willDeleteDiaryIndexPath.sorted(by: { $0.item > $1.item }) {
////
////    }
//
  }
}

// MARK: - Extensions

extension DiaryCollectionViewController: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DiaryCollectionViewController.cellID, for: indexPath) as? DiaryCollectionViewCell else {
      return UICollectionViewCell()
    }
    if let diary = savedDiary?[indexPath.row] {
      cell.configure(diary: diary)
    }
    return cell
  }
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return savedDiary?.count ?? 0
  }
}

extension DiaryCollectionViewController {
  @objc func handleLongPressGesture() {
    self.collectionViewMode = .remove
  }
}

extension DiaryCollectionViewController: UICollectionViewDelegate {
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    switch collectionViewMode {
    case .view:
      let diaryDetailView = DiaryDetailViewController()
      let selectedDiary = self.savedDiary?[indexPath.row]
      diaryDetailView.selectedDiary = selectedDiary
      diaryDetailView.indexPath = indexPath
      diaryDetailView.delegate = self
      navigationController?.pushViewController(diaryDetailView, animated: true)
    case .remove:
      let alert = UIAlertController(title: "삭제하기", message: "해당 다이어리를 삭제하시겠어요?", preferredStyle: .alert)
      let deleteAction = UIAlertAction(title: "삭제", style: .default, handler: nil)
      let cancelAction = UIAlertAction(title: "취소", style: .cancel, handler: nil)
      alert.addAction(cancelAction)
      alert.addAction(deleteAction)
      present(alert, animated: true, completion: nil)
      print("is enabled")
    }
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

extension DiaryCollectionViewController: DiaryDetailViewDelegate {
  func didSelectDelete(indexPath: IndexPath) {
  
  }
}
