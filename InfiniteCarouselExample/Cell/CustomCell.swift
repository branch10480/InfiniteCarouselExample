//
//  CustomCell.swift
//  InfiniteCarouselExample
//
//  Created by Toshiharu Imaeda on 2022/04/17.
//

import UIKit

class CustomCell: UICollectionViewCell {
  @IBOutlet weak var imageView: UIImageView!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    setup()
  }
  
  private func setup() {
    imageView.contentMode = .scaleAspectFill
  }
  
  func configure(url urlString: String) {
    guard let url = URL(string: urlString), let data = try? Data(contentsOf: url) else {
      return
    }
    let image = UIImage(data: data)
    imageView.image = image
  }
  
}
