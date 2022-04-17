//
//  CustomLaytout.swift
//  InfiniteCarouselExample
//
//  Created by Toshiharu Imaeda on 2022/04/16.
//

import UIKit

protocol CustomLayoutDelegate: AnyObject {
  // TODO: サイズ計算に必要な情報のうち外部に問い合わせるメソッドを用意する
}

final class CustomLayout: UICollectionViewLayout {
  weak var delegate: CustomLayoutDelegate?

  private var attributesArray: [UICollectionViewLayoutAttributes] = []
  private var padding: CGFloat = 10
  private var contentWidth: CGFloat = 0
  private var contentHeight: CGFloat {
    collectionView?.bounds.height ?? 0
  }

  convenience init(delegate: CustomLayoutDelegate) {
    self.init()
    self.delegate = delegate
  }

  /// セルの計算をするための処理を記述するメソッド
  /// サイズ情報を保存しておく
  override func prepare() {
    super.prepare()

    guard attributesArray.isEmpty, let collectionView = collectionView else {
      return
    }

    for item in 0..<collectionView.numberOfItems(inSection: 0) {
      let indexPath = IndexPath(item: item, section: 0)
      let itemWidth = collectionView.bounds.width
      let itemHeight = collectionView.bounds.height
      let offset: CGPoint = .init(x: itemWidth * CGFloat(item), y: 0)
      let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
      let frame = CGRect(origin: offset, size: .init(width: itemWidth, height: itemHeight))
      attributes.frame = frame
      attributesArray.append(attributes)
      contentWidth = max(contentWidth, frame.maxX)
    }
  }
  
  /// ScrollViewのcontentSizeと同じ
  override var collectionViewContentSize: CGSize {
    .init(width: contentWidth, height: contentHeight)
  }
  
  /// 表示領域内に表示する要素情報を返す
  /// - Parameter rect: 表示領域
  /// - Returns: 表示要素
  override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
    var visibleLayoutAttributes: [UICollectionViewLayoutAttributes] = []
    for attributes in attributesArray {
      if attributes.frame.intersects(rect) {
        visibleLayoutAttributes.append(attributes)
      }
    }
    return visibleLayoutAttributes
  }
}
