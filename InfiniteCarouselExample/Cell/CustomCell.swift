//
//  CustomCell.swift
//  InfiniteCarouselExample
//
//  Created by Toshiharu Imaeda on 2022/04/17.
//

import UIKit
import SDWebImage

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
    guard let url = URL(string: urlString) else { return }
    imageView.sd_setImage(with: url)
  }
  
}
