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
  }
  
  func configure(url urlString: String) {
    guard let url = URL(string: urlString), let data = try? Data(contentsOf: url) else {
      return
    }
    imageView.image = UIImage(data: data)
  }
  
}
