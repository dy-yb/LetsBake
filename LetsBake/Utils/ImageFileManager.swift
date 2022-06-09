//
//  ImageFileManager.swift
//  LetsBake
//
//  Created by Daye on 2022/04/13.
//

import UIKit

class ImageFileManager {
  let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first

  func saveImageToDocumentDirectory(imageName: String, image: UIImage) -> String? {
    guard let documentDirectory = documentDirectory else { return nil }
    let imageURL = documentDirectory.appendingPathComponent("\(imageName).png")

    guard let data = image.pngData() else {
      print("압축이 실패했습니다.")
      return nil
    }

    do {
      try data.write(to: imageURL)
      print("이미지 저장완료")
    } catch {
      print("이미지를 저장하지 못했습니다.")
    }
    return "\(imageURL)"
  }

  func loadImageFromDocumentDirectgory(imageName: String?) -> UIImage? {
    guard let imageName = imageName else { return nil }

    if let imageURL = URL(string: imageName) {
      return UIImage(contentsOfFile: imageURL.path)
    }
    return nil
  }

  func deleteImageFromDocumentDirectory(imageName: String) {
    if let imageURL = URL(string: imageName) {
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
}
