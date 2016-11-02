//
//  ViewController.swift
//  FlowLayout
//
//  Created by ddn on 16/9/2.
//  Copyright © 2016年 张永俊. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var textLabel: UILabel!

    var texts = ["123", "12345", "1234567", "12345", "1234567", "12345", "1234567", "12345", "1234567", "12345", "1234567", "12345", "1234567", "12345", "1234567", "12345", "1234567", "12345", "1234567", "12345", "1234567", "12345", "1234567", "12345", "1234567", "12345", "1234567", "12345", "1234567", "12345", "1234567", "12345", "1234567", "12345", "1234567", "12345", "1234567", "12345", "1234567", "12345", "1234567", "12345", "1234567", "12345", "1234567", "12345", "1234567", "12345", "1234567", "12345", "1234567", "12345", "1234567", "12345", "1234567", "12345", "1234567", "12345", "1234567", "12345", "1234567", "12345", "1234567", "12345", "1234567", "12345", "1234567", "12345", "1234567", "12345", "1234567", "12345", "1234567", "12345", "1234567", "12345", "1234567", "12345", "1234567", "12345", "1234567", "12345", "1234567", "12345", "1234567", "12345", "1234567"]
    
    var collectionView: UICollectionView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView = UICollectionView(frame: CGRect(x: 0, y: 30, width: 400, height: 500), collectionViewLayout: YJLayout())
        
        //注册cell
        collectionView?.register(UINib(nibName: "TestCell", bundle: nil), forCellWithReuseIdentifier: "cell")
        
        //注册header
        collectionView?.register(UINib(nibName: "TestHeader", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "header")
        //注册footer
        collectionView?.register(UINib(nibName: "TestHeader", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionFooter, withReuseIdentifier: "footer")
        
        collectionView?.delegate = self
        collectionView?.dataSource = self
        
        //ios10中的cell生命周期发生变化，创建提前，销毁延后，修改这个属性为false可以讲机制改为以前的
        collectionView?.isPrefetchingEnabled = true
        collectionView?.prefetchDataSource = self
        
        let bview = UIView()
        bview.backgroundColor = UIColor.purple
        //设置背景视图
        collectionView?.backgroundView = bview
        
        //允许cell选中
        collectionView?.allowsSelection = true
        //允许多个cell同时被选中
        collectionView?.allowsMultipleSelection = true
        
        view.addSubview(collectionView!)
        
        //如果是UICollectionViewController会自带该手势，不需要再添加
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(handleLongGesture(gesture:)))
        collectionView?.addGestureRecognizer(longPress)
        
    }
    
    func handleLongGesture(gesture: UILongPressGestureRecognizer) {
        switch(gesture.state) {
        case UIGestureRecognizerState.began:
            guard let selectedIndexPath = self.collectionView?.indexPathForItem(at: gesture.location(in: self.collectionView)) else {
                break
            }
            collectionView?.beginInteractiveMovementForItem(at: selectedIndexPath)
        case UIGestureRecognizerState.changed:
            collectionView?.updateInteractiveMovementTargetPosition(gesture.location(in: gesture.view!))
        case UIGestureRecognizerState.ended:
            collectionView?.endInteractiveMovement()
        default:
            collectionView?.cancelInteractiveMovement()
        }
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        //主动选中一个cell
//        collectionView?.selectItem(at: IndexPath(item: 0, section: 0), animated: true, scrollPosition: .left)
//    
//        //主动取消选中一个cell
//        collectionView?.deselectItem(at: IndexPath(item: 0, section: 0), animated: true)
        
        //滑动动某个cell
        collectionView?.scrollToItem(at: IndexPath(item: 10, section: 0), at: .left, animated: true)
        
        print("有几个分区" + "\(collectionView?.numberOfSections)" + "\n\n")
        print("第0个分区有几项" + "\(collectionView?.numberOfItems(inSection: 0))" + "\n\n")
        
        
        print("可见的cell：" + "\(collectionView?.visibleCells)" + "\n\n")
        print("可见的位置：" + "\(collectionView?.indexPathsForVisibleItems)" + "\n\n")
        
    
        print("指定坐标所在位置:" + "\(collectionView?.indexPathForItem(at: CGPoint.init(x: 120, y: 20)))")
        
        //同cell相似
        //let header = collectionView?.supplementaryView(forElementKind: UICollectionElementKindSectionHeader, at: IndexPath.init(item: 0, section: 0))
        //let supplementaryViews = collectionView?.visibleSupplementaryViews(ofKind: UICollectionElementKindSectionHeader)
        //let indexPaths = collectionView?.indexPathsForVisibleSupplementaryElements(ofKind: UICollectionElementKindSectionHeader)
        
    }
    
    var tLayout: UICollectionViewTransitionLayout?
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        //准备切换layout
        tLayout = self.collectionView?.startInteractiveTransition(to: TestLayout(), completion: { (a, b) in
            print("动画是否结束：" + "\(a)\n" + "\n\n")
            print("布局是否被切换：" + "\(b)\n" + "\n\n")
        })
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        //修改切换动画的进度
        tLayout?.transitionProgress += 0.01
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        //完成切换（触发回调）
        //        collectionView?.finishInteractiveTransition()
        
        //取消切换
        collectionView?.cancelInteractiveTransition()
    }
}

var sectionCount = 2
extension ViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return sectionCount
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return texts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //复用cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! TestCell
        cell.textLabel.text = texts[indexPath.item] + " + \(indexPath.item)"
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionElementKindSectionHeader {
            //复用header
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "header", for: indexPath)
            header.backgroundColor = UIColor.red
            return header
        }else {
            //复用footer
            let footer = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionFooter, withReuseIdentifier: "footer", for: indexPath)
            footer.backgroundColor = UIColor.blue
            return footer
        }
    }
    
    //指定indexPath是否可以移动
    func collectionView(_ collectionView: UICollectionView, canMoveItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    //移动cell的时候修改数据源
    func collectionView(_ collectionView: UICollectionView, moveItemAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        
        let temp = texts.remove(at: (sourceIndexPath as NSIndexPath).item)
        texts.insert(temp, at: (destinationIndexPath as NSIndexPath).item)
    }
}

// (when the touch begins)
// 1. -collectionView:shouldHighlightItemAtIndexPath:
// 2. -collectionView:didHighlightItemAtIndexPath:
//
// (when the touch lifts)
// 3. -collectionView:shouldSelectItemAtIndexPath: or -collectionView:shouldDeselectItemAtIndexPath:
// 4. -collectionView:didSelectItemAtIndexPath: or -collectionView:didDeselectItemAtIndexPath:
// 5. -collectionView:didUnhighlightItemAtIndexPath:
extension ViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
        print("didHighlightItemAt\(indexPath)")
    }
    
    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        
        //每个section只能选中一个
        let iPs = collectionView.indexPathsForSelectedItems
        
        iPs?.forEach({ (iP) in
            if (iP.section == indexPath.section) {
                collectionView.deselectItem(at: iP, animated: true)
            }
        })
        
        return true
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        print(collectionView.indexPathsForSelectedItems)
        
        //获取所有被选中的cell的indexPath
        if collectionView.indexPathsForSelectedItems!.count > 2 {
            //替换layout
            //            collectionView.setCollectionViewLayout(TestLayout(), animated: true)
            //带有回调的替换
            //            setCollectionViewLayout(layout: UICollectionViewLayout, animated: Bool, completion: ((Bool) -> Void)?)
        }
        
//        let attr = collectionView.layoutAttributesForItem(at: indexPath)
//        print("获取指定位置的布局属性（cell）:" + "\(attr)" + "\n\n")
//        
//        let attr2 = collectionView.layoutAttributesForSupplementaryElement(ofKind: UICollectionElementKindSectionHeader, at: IndexPath.init(item: 0, section: 0))
//        print("获取指定位置的布局属性（header／footer）:" + "\(attr2)" + "\n\n")
//        
//        let cell = collectionView.cellForItem(at: indexPath)
//        print("获取指定位置的cell:" + "\(cell)" + "\n\n")
//        
//        let indexP = collectionView.indexPath(for: cell!)
//        print("获取指定cell的位置：" + "\(indexP)" + "\n\n")
//        
//        //同时进行一下多个操作
//        collectionView.performBatchUpdates({
//            
//            let indexset = IndexSet(integer: 0)
//            sectionCount += 1
//            collectionView.insertSections(indexset)
//            
//            //collectionView.deleteSections(indexset)
//            //collectionView.moveSection(0, toSection: 1)
//            collectionView.reloadSections(indexset)
//            
//            //collectionView.deleteItems(at: <#T##[IndexPath]#>)
//            //collectionView.moveItem(at: <#T##IndexPath#>, to: <#T##IndexPath#>)
//            //collectionView.insertItems(at: <#T##[IndexPath]#>)
//            //collectionView.reloadItems(at: <#T##[IndexPath]#>)
//            
//        }) { (flag) in
//            print("performBatchUpdatesEnd")
//        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didUnhighlightItemAt indexPath: IndexPath) {
        print("didUnhighlightItemAt\(indexPath)")
    }
    
    func collectionView(_ collectionView: UICollectionView, shouldDeselectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        print("didDeselectItemAt\(indexPath)")
    }
    
    //将要显示
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        print("willDisplay cell\(cell)\n forItemAt\(indexPath)")
    }
    func collectionView(_ collectionView: UICollectionView, willDisplaySupplementaryView view: UICollectionReusableView, forElementKind elementKind: String, at indexPath: IndexPath) {
        print("willDisplaySupplementaryView\(view) forElementKind\(elementKind) at\(indexPath)")
    }
    
    //已经消失
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        print("didEndDisplaying cell\(cell)\n forItemAt\(indexPath)")
    }
    func collectionView(_ collectionView: UICollectionView, didEndDisplayingSupplementaryView view: UICollectionReusableView, forElementOfKind elementKind: String, at indexPath: IndexPath) {
        print("didEndDisplayingSupplementaryView\(view) forElementKind\(elementKind) at\(indexPath)")
    }
    
//    //编辑操作(长按)
//    //是否可以显示编辑菜单
//    func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
//        return true
//    }
//    //菜单中哪些编辑操作可以显示
//    func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
//        if action == #selector(copy(_:)) {
//            return true
//        }
//        return false
//    }
//    //显示的编辑操作怎么执行
//    func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
//        if action == #selector(copy(_:)) {
//            let cell = collectionView.cellForItem(at: indexPath) as! TestCell
//            //剪贴板存储
//            UIPasteboard.general.string = cell.textLabel.text
//        }
//    }
    
    // 自定义layout切换(不知道怎么用)
//    func collectionView(_ collectionView: UICollectionView, transitionLayoutForOldLayout fromLayout: UICollectionViewLayout, newLayout toLayout: UICollectionViewLayout) -> UICollectionViewTransitionLayout {
//        
//    }
    
    //没发现有啥用
    func collectionView(_ collectionView: UICollectionView, targetIndexPathForMoveFromItemAt originalIndexPath: IndexPath, toProposedIndexPath proposedIndexPath: IndexPath) -> IndexPath {
        /* 可以指定位置禁止交换 */
        if proposedIndexPath.item == 0 {
            return originalIndexPath
        }
        return proposedIndexPath
    }
    
    //customize the content offset to be applied during transition or update animations
    func collectionView(_ collectionView: UICollectionView, targetContentOffsetForProposedContentOffset proposedContentOffset: CGPoint) -> CGPoint {
        return CGPoint(x: 100, y: 100)
    }
}

//预加载，ios10，http://blog.csdn.net/qq_18425655/article/details/51859940
extension ViewController: UICollectionViewDataSourcePrefetching {
    //当要预加载一些cell的时候调用，可以在这里为对应的cell获取数据
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        
    }
    
    //当要取消一些cell的预加载时候调用
    func collectionView(_ collectionView: UICollectionView, cancelPrefetchingForItemsAt indexPaths: [IndexPath]) {
        
    }
}

//这个协议比较屌，这里的设置要优先于layout中的设置，但是layout的prepareLayout()在这之后执行，在那里设置也不起作用，不知道为啥
extension ViewController: UICollectionViewDelegateFlowLayout {
    
    //不能和estimatedItemSize一起使用
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: 100, height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 50
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSize(width: 100, height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: 100, height: 100)
    }
}

class TestHeader: UICollectionReusableView {
    
}
    

class TestCell: UICollectionViewCell {
    
    @IBOutlet weak var textLabel: UILabel!
    
    //只有在使用estimatedItemSize时起作用
//    override func preferredLayoutAttributesFittingAttributes(layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
//        let attr = super.preferredLayoutAttributesFittingAttributes(layoutAttributes)
//        
//        self.setNeedsLayout()
//        self.layoutIfNeeded()
//        
//        let size = self.contentView.systemLayoutSizeFittingSize(UILayoutFittingCompressedSize)
//        attr.frame.size = size
//        return attr
//    }
}

class YJLayout: UICollectionViewFlowLayout {
    
    override init() {
        super.init()
        //不指定会默认为50，50
        itemSize = CGSize(width: 50, height: 30)
        
        sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        
        headerReferenceSize = CGSize(width: 10, height: 10)
        footerReferenceSize = CGSize(width: 10, height: 10)
        
        //悬浮效果（ios9）
//        sectionFootersPinToVisibleBounds = true
        sectionHeadersPinToVisibleBounds = true
        
        scrollDirection = .horizontal
        
        //意义取决于scrollDirection
        minimumLineSpacing = 10
        minimumInteritemSpacing = 0
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func prepare() {
        super.prepare()
        
//        itemSize = CGSize(width: 50, height: 30)
//        
//        sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
//        
//        headerReferenceSize = CGSize(width: 10, height: 10)
//        footerReferenceSize = CGSize(width: 10, height: 10)
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        let attrs = super.layoutAttributesForElements(in: rect)
        return attrs
    }
    
    //为需要更新布局的item做准备
    override func prepare(forCollectionViewUpdates updateItems: [UICollectionViewUpdateItem]) {
        super.prepare(forCollectionViewUpdates: updateItems)
        print("preatreUpdate")
    }
    
    //例如插入一个新item
    override func initialLayoutAttributesForAppearingItem(at itemIndexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        let attr = super.initialLayoutAttributesForAppearingItem(at: itemIndexPath)
        
        return attr
    }
    
    //例如删除一个item
    override func finalLayoutAttributesForDisappearingItem(at itemIndexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        let attr = super.finalLayoutAttributesForDisappearingItem(at: itemIndexPath)
        return attr
    }
}


class TestLayout: UICollectionViewFlowLayout {
    override init() {
        super.init()
        //不指定会默认为50，50
        itemSize = CGSize(width: 150, height: 130)
        
        sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        
        headerReferenceSize = CGSize(width: 10, height: 10)
        footerReferenceSize = CGSize(width: 10, height: 10)
        
        //悬浮效果（ios9）
        //        sectionFootersPinToVisibleBounds = true
        sectionHeadersPinToVisibleBounds = true
        
        scrollDirection = .horizontal
        
        //意义取决于scrollDirection
        minimumLineSpacing = 10
        minimumInteritemSpacing = 0
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
















