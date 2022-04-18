//
//  CustomRefreshControl.swift
//  InfiniteCarouselExample
//
//  Created by Toshiharu Imaeda on 2022/04/18.
//

import UIKit

class CustomRefreshControl: UIRefreshControl {
  override func layoutSubviews() {
    self.frame.origin.y += 64
  }
}
