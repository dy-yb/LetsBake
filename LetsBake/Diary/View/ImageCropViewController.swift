//
//  ViewController.swift
//  LetsBake
//
//  Created by Daye on 2022/02/28.
//

import UIKit

class ImageCropViewController: UIViewController {
  lazy var scrollView: UIScrollView = {
    let scrollView = UIScrollView()
    scrollView.backgroundColor = .purple
    scrollView.translatesAutoresizingMaskIntoConstraints = false
    scrollView.delegate = self
    scrollView.minimumZoomScale = 1
    scrollView.maximumZoomScale = 2
    return scrollView
  }()

  let contentView: UIView = {
    let contentView = UIView()
    contentView.backgroundColor = .yellow
    contentView.translatesAutoresizingMaskIntoConstraints = false
    return contentView
  }()

  let imageView: UIImageView = {
    let imageView = UIImageView()
    imageView.backgroundColor = .green
    imageView.contentMode = .scaleAspectFit
//    imageView.image = UIImage(named: "lemoncake")
    imageView.translatesAutoresizingMaskIntoConstraints = false
    return imageView
  }()

  let cropView: UIView = {
    let view = UIView()
    view.backgroundColor = .gray
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()

  lazy var cropButton: UIButton = {
    let cropButton = UIButton()
    cropButton.translatesAutoresizingMaskIntoConstraints = false
    cropButton.titleLabel?.text = "Submit"
    cropButton.addTarget(self, action: #selector(clickedCropButton(_:)), for: .touchUpInside)
    return cropButton
  }()

  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .white
    setView()
    layout()

  }

  func setView() {
    view.addSubview(scrollView)
    scrollView.addSubview(contentView)
    scrollView.addSubview(imageView)
    scrollView.addSubview(cropView)
    scrollView.addSubview(cropButton)
  }

  func layout() {
    NSLayoutConstraint.activate([
      scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
      scrollView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
      scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
      scrollView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),

      contentView.widthAnchor.constraint(equalToConstant: scrollView.frame.width),
      // 작은 화면에서 스크롤 안되는 문제 해결 해야함
      contentView.heightAnchor.constraint(equalToConstant: scrollView.frame.height+300),
      contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
      contentView.rightAnchor.constraint(equalTo: scrollView.rightAnchor),
      contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
      contentView.leftAnchor.constraint(equalTo: scrollView.leftAnchor),

      imageView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
      imageView.centerYAnchor.constraint(equalTo: scrollView.centerYAnchor),
      imageView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
      imageView.heightAnchor.constraint(equalTo: scrollView.heightAnchor, constant: -300),

      cropView.widthAnchor.constraint(equalToConstant: 320),
      cropView.heightAnchor.constraint(equalToConstant: 170),
      cropView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
      cropView.centerYAnchor.constraint(equalTo: scrollView.centerYAnchor),

      cropButton.topAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: 10),
      cropButton.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor)
    ])
  }

  @objc func clickedCropButton(_ sender: Any) {
    guard let imageToCrop = imageView.image else { return }
    let cropRect = CGRect(x: cropView.frame.origin.x - imageView.realImageRect().origin.x,
                          y: cropView.frame.origin.y - imageView.realImageRect().origin.y,
                          width: cropView.frame.width,
                          height: cropView.frame.height)
    let croppedImage = ImageCropHandler.shardInstance.cropImage(imageToCrop, toRect: cropRect, imageViewWidth: imageView.frame.width, imageViewHeight: imageView.frame.height)
    imageView.image = croppedImage
    scrollView.zoomScale = 1
    }
  }

extension ImageCropViewController: UIScrollViewDelegate {
  func viewForZooming(in scrollView: UIScrollView) -> UIView? {
    return imageView
  }
}
