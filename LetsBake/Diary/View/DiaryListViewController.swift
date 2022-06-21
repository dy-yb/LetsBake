//
//  DiaryViewController.swift
//  LetsBake
//
//  Created by Daye on 2021/12/09.
//

import UIKit

enum CollectionViewMode {
  case view
  case remove
}

class DiaryListViewController: UIViewController {
  
  // MARK: - Properties
  
  static let cellID = "DiaryCollectionViewCell"
//  var diaryViewModel: DiaryViewModel?
  var diaryDataManager = CoreDataManager.shared
  
  lazy var savedDiary: [DiaryModel]? = {
    return self.diaryDataManager.fetchDiary()
  }()
  var collectionViewMode: CollectionViewMode = .view
  
  // MARK: - UI
  
  lazy var rightBarButtonItem: UIBarButtonItem = {
    let barButtonItem = UIBarButtonItem(title: "추가", style: .plain, target: self, action: #selector(clickRightBarButtonItem(_:)))
    return barButtonItem
  }()
  
  lazy var leftBarButtonItem: UIBarButtonItem = {
    let barButtonItem = UIBarButtonItem(title: "삭제", style: .plain, target: self, action: #selector(clickLeftBarButtonItem(_:)))
    return barButtonItem
  }()
  
  let diaryCollectionView: UICollectionView = {
    let flowLayout = UICollectionViewFlowLayout.init()
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
    flowLayout.scrollDirection = .vertical
    collectionView.translatesAutoresizingMaskIntoConstraints = false
    collectionView.register(DiaryCollectionViewCell.self, forCellWithReuseIdentifier: DiaryListViewController.cellID)
    collectionView.allowsSelection = true
    return collectionView
  }()
  
  // MARK: - Lifecycle
  
  override func viewWillAppear(_ animated: Bool) {
    self.tabBarController?.tabBar.isHidden = false
    self.diaryCollectionView.reloadData()
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.setView()
    self.setNavigationBar()
    self.layout()
  }
  
  // MARK: - Layout
  
  func setView() {
    self.view.backgroundColor = .white
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
  
  func setNavigationBar() {
    self.navigationItem.title = "베이킹 일지"
    self.navigationItem.rightBarButtonItem = self.rightBarButtonItem
    self.navigationItem.leftBarButtonItem = self.leftBarButtonItem
  }
  
  // MARK: - Functions
  
  @objc func clickRightBarButtonItem(_ send: Any) {
    switch collectionViewMode {
    case .view:
      self.hidesBottomBarWhenPushed = true
      self.navigationController?.pushViewController(DiaryWriteViewController(), animated: true)
      print("called")
    case .remove:
      self.collectionViewMode = .view
      self.rightBarButtonItem.title = "추가"
      self.leftBarButtonItem.title = "삭제"
    }
  }
  
  @objc func clickLeftBarButtonItem(_ sender: UIBarButtonItem) {
    switch collectionViewMode {
    case .view:
      self.collectionViewMode = .remove
      self.rightBarButtonItem.title = "완료"
      self.leftBarButtonItem.title = nil
    case .remove:
      self.collectionViewMode = .view
      self.leftBarButtonItem.title = "삭제"
    }
  }
  
  func tapDeleteAlertAction(indexPath: IndexPath) {
        if let savedDiary = savedDiary {
//          diaryDataManager.deleteDiary(diary: savedDiary[indexPath.row])
          ImageFileManager().deleteImageFromDocumentDirectory(imageName: savedDiary[indexPath.row].photo)
        }
    self.diaryCollectionView.deleteItems(at: [indexPath])
  }
}

// MARK: - Extensions

extension DiaryListViewController: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DiaryListViewController.cellID, for: indexPath) as? DiaryCollectionViewCell else {
      return UICollectionViewCell()
    }
    if let savedDiary = savedDiary {
      cell.configure(diary: savedDiary[indexPath.row])
    }
    return cell
  }
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return savedDiary?.count ?? 0
  }
}

extension DiaryListViewController: UICollectionViewDelegate {
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    switch collectionViewMode {
    case .view:
      if let savedDiary = self.savedDiary {
        let selectedDiary = savedDiary[indexPath.row]
        let diaryDetailView = DiaryDetailViewController()
        diaryDetailView.setData(selectedDiary: selectedDiary)
        diaryDetailView.indexPath = indexPath
        navigationController?.pushViewController(diaryDetailView, animated: true)
        
      }
    case .remove:
      let alert = UIAlertController(title: "삭제하기", message: "해당 다이어리를 삭제하시겠어요?", preferredStyle: .alert)
      let deleteAction = UIAlertAction(title: "삭제", style: .default, handler: { _ in
        self.tapDeleteAlertAction(indexPath: indexPath)
      })
      let cancelAction = UIAlertAction(title: "취소", style: .cancel, handler: nil)
      alert.addAction(cancelAction)
      alert.addAction(deleteAction)
      present(alert, animated: true, completion: nil)
      print("is enabled")
    }
  }
}

extension DiaryListViewController: UICollectionViewDelegateFlowLayout {
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
