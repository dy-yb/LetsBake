//
//  ImageFileManager.swift
//  LetsBake
//
//  Created by Daye on 2022/04/13.
//

import UIKit

class ImageFileManager {
  func saveImageToDocumentDirectory(imageURL: URL, imageName: String, image: UIImage) {
    guard let data = image.pngData() else {
      print("압축이 실패했습니다.")
      return
    }

    if FileManager.default.fileExists(atPath: imageURL.path) {
      do {
        try FileManager.default.removeItem(at: imageURL)
        print("이미지 삭제 완료")
      } catch {
        print("이미지를 삭제하지 못했습니다.")
      }
    }

    do {
      try data.write(to: imageURL)
      print("이미지 저장완료")
    } catch {
      print("이미지를 저장하지 못했습니다.")
    }
  }

  func loadImageFromDocumentDirectgory(imageName: String?) -> UIImage? {
    guard let imageName = imageName else { return nil }

    if let imageURL = URL(string: imageName) {
      print(imageURL)
      return UIImage(contentsOfFile: imageURL.path)
    }
    return nil
  }

  func deleteImageFromDocumentDirectory(imageName: String) {
    guard let imageURL = URL(string: imageName) else { return }

    if FileManager.default.fileExists(atPath: imageURL.path) {
      do {
        try FileManager.default.removeItem(at: imageURL)
        print("이미지 삭제 완료")
      } catch {
        print("이미지를 삭제하지 못했습니다.")
      }
    }
  }

}
