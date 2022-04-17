//
//  CustomLaytout.swift
//  InfiniteCarouselExample
//
//  Created by Toshiharu Imaeda on 2022/04/16.
//

import UIKit

final class CustomLayout: UICollectionViewLayout {
  private var attributesArray: [UICollectionViewLayoutAttributes] = []
  private var padding: CGFloat = 10
  private var contentWidth: CGFloat = 0
  private var contentHeight: CGFloat {
    collectionView?.bounds.height ?? 0
  }

  var currentIndex: Int? {
    guard let collectionView = collectionView else { return nil }
    let visibleRect = CGRect(origin: .init(x: collectionView.contentOffset.x, y: 0), size: collectionView.bounds.size)
    let attributes = layoutAttributesForNeabyCenterX(in: visibleRect, collectionView: collectionView)
    return attributes?.indexPath.row
  }

  override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
    true
  }

  /// セルの計算をするための処理を記述するメソッド
  /// サイズ情報を保存しておく
  override func prepare() {
    guard let collectionView = collectionView else {
      return
    }

    attributesArray = []

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

  /// 指を離したときにどの位置まで自動スクロールするかを決める（ページングアニメーション）
  override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {
    guard let collectionView = collectionView else {
      return proposedContentOffset
    }
    let visibleRect = CGRect(origin: collectionView.contentOffset, size: collectionView.bounds.size)
    // 表示領域のAttributesを取得
    guard let targetAttributes = layoutAttributesForElements(in: visibleRect)?.sorted(by: { $0.frame.minX < $1.frame.minX }) else {
      return proposedContentOffset
    }
    let nextAttributes: UICollectionViewLayoutAttributes?
    if velocity.x == 0 {
      // スワイプせずに指を離した -> 画面中央から一番近い要素を取得する
      nextAttributes = layoutAttributesForNeabyCenterX(in: visibleRect, collectionView: collectionView)
    } else if velocity.x > 0 {
      // 左スワイプ
      nextAttributes = targetAttributes.last
    } else {
      // 右スワイプ
      nextAttributes = targetAttributes.first
    }
    return nextAttributes?.frame.origin ?? proposedContentOffset
  }

  /// 表示領域の中央に一番近いLayoutAttributesを返す
  private func layoutAttributesForNeabyCenterX(in rect: CGRect, collectionView: UICollectionView) -> UICollectionViewLayoutAttributes? {
    var currentDistance: CGFloat = .infinity
    var attributes: UICollectionViewLayoutAttributes?
    let attributesArray = layoutAttributesForElements(in: rect) ?? []
    for elm in attributesArray {
      let distance = abs(elm.frame.midX - rect.midX)
      if distance < currentDistance {
        attributes = elm
        currentDistance = distance
      }
    }
    return attributes
  }
}
