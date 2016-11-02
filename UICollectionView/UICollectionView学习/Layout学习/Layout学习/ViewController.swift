//
//  ViewController.swift
//  Layout学习
//
//  Created by ddn on 16/9/22.
//  Copyright © 2016年 张永俊. All rights reserved.
//

import UIKit


fileprivate func - (left: CGPoint, right: CGPoint) ->CGPoint {
    return CGPoint(x: left.x - right.x, y: left.y - right.y)
}

fileprivate func + (left: CGPoint, right: CGPoint) ->CGPoint {
    return CGPoint(x: left.x + right.x, y: left.y + right.y)
}

class ViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    fileprivate var longPressGesture: UILongPressGestureRecognizer!
    fileprivate var numbers = [Int]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for _ in 0...5 {
            let height = Int(arc4random_uniform((UInt32(100)))) + 40
            numbers.append(height)
        }
        collectionView!.backgroundColor = UIColor.cyan
        
        longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(handleLongGesture(_:)))
        collectionView!.addGestureRecognizer(longPressGesture)
        
    }
    var cellDis: CGPoint = CGPoint.zero
    func handleLongGesture(_ gesture: UILongPressGestureRecognizer) {
        
        switch(gesture.state) {
            
        case .began:
            guard let selectedIndexPath = collectionView!.indexPathForItem(at: gesture.location(in: collectionView)) else {
                break
            }
            collectionView!.beginInteractiveMovementForItem(at: selectedIndexPath)
            let selectedCell = collectionView.cellForItem(at: selectedIndexPath)
            let cellP = gesture.location(in: selectedCell)
            
            cellDis = cellP - CGPoint(x: selectedCell!.bounds.size.width/2, y: selectedCell!.bounds.size.height/2)
        case .changed:
            let location = gesture.location(in: gesture.view!)
            let dis: CGPoint = location - cellDis
            collectionView!.updateInteractiveMovementTargetPosition(dis)
        case .ended:
            collectionView!.endInteractiveMovement()
            cellDis = CGPoint.zero
        default:
            collectionView!.cancelInteractiveMovement()
            cellDis = CGPoint.zero
        }
    }

}

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return numbers.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! TestCell
        cell.textLabel.text = "\(numbers[indexPath.item]): \(indexPath.item)"
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, moveItemAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let temp = numbers.remove(at: sourceIndexPath.item)
        numbers.insert(temp, at: destinationIndexPath.item)
    }
}

extension ViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        numbers.remove(at: indexPath.item)
        collectionView.performBatchUpdates({ 
            collectionView.deleteItems(at: [indexPath])
            }) { (flag) in
                print("end")
        }
    }
}
