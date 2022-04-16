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
  private var contentHeight: CGFloat = 0

  /// セルの計算をするための処理を記述するメソッド
  /// サイズ情報を保存しておく
  override func prepare() {
    super.prepare()
  }
  
  /// ScrollViewのcontentSizeと同じ
  override var collectionViewContentSize: CGSize {
    super.collectionViewContentSize
  }
  
  /// 表示領域内に表示する要素情報を返す
  /// - Parameter rect: 表示領域
  /// - Returns: 表示要素
  override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
    super.layoutAttributesForElements(in: rect)
  }
}
