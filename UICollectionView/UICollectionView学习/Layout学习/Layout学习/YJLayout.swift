//
//  YJLayout.swift
//  Layout学习
//
//  Created by ddn on 16/9/22.
//  Copyright © 2016年 张永俊. All rights reserved.
//
/*
 执行顺序
 prepare()
 collectionViewContentSize
 layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]?
 */
import UIKit

class YJLayout: UICollectionViewLayout {

    var attrs = [UICollectionViewLayoutAttributes]()
    
    override func prepare() {
        super.prepare()
        
        let count = collectionView!.numberOfItems(inSection: 0)
        
        attrs.removeAll()
        
        for i in 0..<count {
            attrs.append(layoutAttributesForItem(at: IndexPath(item: i, section: 0))!)
        }
        
    }
    
    //返回一个区域的布局
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        return attrs
    }
    
    //返回指定indexPath的布局
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        
//        let count = collectionView!.numberOfItems(inSection: indexPath.section)
        
//        let baseW: CGFloat = collectionView!.bounds.size.width
//        let baseH: CGFloat = collectionView!.bounds.size.height
//        
//        let dis: CGFloat = (collectionView!.bounds.size.height - baseH) / CGFloat(count - 1)
        
        let attr = UICollectionViewLayoutAttributes(forCellWith: indexPath)
        
//        attr.frame = CGRect(x: 10, y: 10, width: 100, height: 100)
//        attr.bounds = CGRect(x: 0, y: 0, width: 100, height: 100)
        
        attr.frame = collectionView!.bounds
//        attr.zIndex = count - indexPath.item
        attr.alpha = 1
        attr.isHidden = false
        
        var transform = CATransform3DIdentity
        
        transform = CATransform3DTranslate(transform, 0, 200, 0)
        transform.m34 = -1.0/700
        transform = CATransform3DRotate(transform, -CGFloat.pi / 3, 1, 0, 0)
        transform = CATransform3DScale(transform, 0.7, 0.7, 1)
        transform = CATransform3DTranslate(transform, 0, 0, -CGFloat(indexPath.item * 100))
        attr.transform3D = transform
        
        return attr
    }
    
    //布局header或者footer
    override func layoutAttributesForSupplementaryView(ofKind elementKind: String, at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        return super.layoutAttributesForSupplementaryView(ofKind: elementKind, at: indexPath)
    }
    
    //布局装饰视图
    override func layoutAttributesForDecorationView(ofKind elementKind: String, at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        return super.layoutAttributesForDecorationView(ofKind: elementKind, at: indexPath)
    }
    
    //返回contentOffset
    override var collectionViewContentSize: CGSize {
        let result = attrs.reduce((0, 0)) { (result, attr) -> (CGFloat, CGFloat) in
            return (max(CGFloat(result.0), attr.frame.maxX), max(CGFloat(result.1), attr.frame.maxY))
        }
        return CGSize(width: result.0, height: result.1)
    }
    
    //返回一个失效的上下文来决定哪里或哪些需要重新布局
    override func invalidationContext(forBoundsChange newBounds: CGRect) -> UICollectionViewLayoutInvalidationContext {
        return super.invalidationContext(forBoundsChange: newBounds)
    }
    
    //是否要重新布局根据newBounds
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        let oldBounds = collectionView!.bounds
        if newBounds.size != oldBounds.size {
            return true
        }
        return false
    }
    
    //是否要重新布局根据preferredAttributes和originalAttributes
    override func shouldInvalidateLayout(forPreferredLayoutAttributes preferredAttributes: UICollectionViewLayoutAttributes, withOriginalAttributes originalAttributes: UICollectionViewLayoutAttributes) -> Bool {
        return super.shouldInvalidateLayout(forPreferredLayoutAttributes: preferredAttributes, withOriginalAttributes: originalAttributes)
    }
    
    //根据preferredAttributes和originalAttributes返回一个失效的上下文
    override func invalidationContext(forPreferredLayoutAttributes preferredAttributes: UICollectionViewLayoutAttributes, withOriginalAttributes originalAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutInvalidationContext {
        return super.invalidationContext(forPreferredLayoutAttributes: preferredAttributes, withOriginalAttributes: originalAttributes)
    }
    
    //返回一个最终conentOffset，当滑动结束
    override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {
        return super.targetContentOffset(forProposedContentOffset: proposedContentOffset, withScrollingVelocity: velocity)
    }
    
    //返回一个最终conentOffset，当切换或者更新布局之后
    override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint) -> CGPoint {
        return super.targetContentOffset(forProposedContentOffset: proposedContentOffset)
    }
    
    //返回一个目标indexPath给拖动的item
    override func targetIndexPath(forInteractivelyMovingItem previousIndexPath: IndexPath, withPosition position: CGPoint) -> IndexPath {
        let indexPath = collectionView!.indexPathForItem(at: position) ?? previousIndexPath
        return indexPath
    }
    
    override func prepare(forCollectionViewUpdates updateItems: [UICollectionViewUpdateItem]) {
        super.prepare(forCollectionViewUpdates: updateItems)
    }
    
    override func initialLayoutAttributesForAppearingItem(at itemIndexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        let attr = super.initialLayoutAttributesForAppearingItem(at: itemIndexPath)
        return attr
    }
    
    override func finalLayoutAttributesForDisappearingItem(at itemIndexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        let attr = super.finalLayoutAttributesForDisappearingItem(at: itemIndexPath)
        
        attr?.size = CGSize(width: 1, height: 1)
        attr?.alpha = 0
        
        return attr
    }
}
