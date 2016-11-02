//
//  ViewController.swift
//  AutoFlowLayout
//
//  Created by ddn on 16/9/18.
//  Copyright © 2016年 张永俊. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var headerBtn: UIButton!

    var texts = ["123", "12345", "1234567", "12345", "1234567", "12345", "1234567", "12345", "1234567", "12345", "1234567", "12345", "1234567", "12345", "1234567", "12345", "1234567", "12345", "1234567", "12345", "1234567", "12345", "1234567", "12345", "1234567", "12345", "1234567", "12345", "1234567", "12345", "1234567", "12345", "1234567", "12345", "1234567", "12345", "1234567", "12345", "1234567", "12345", "1234567", "12345", "1234567", "12345", "1234567", "12345", "1234567", "12345", "1234567", "12345", "1234567", "12345", "1234567", "12345", "1234567", "12345", "1234567", "12345", "1234567", "12345", "1234567", "12345", "1234567", "12345", "1234567", "12345", "1234567", "12345", "1234567", "12345", "1234567", "12345", "1234567", "12345", "1234567", "12345", "1234567", "12345", "1234567", "12345", "12345671234567123456712345671234567123456712345671234567123456712345671234567123456712345671234567123456712345671234567123456712345671234567", "12345", "1234567", "12345", "1234567", "12345", "1234567"]
    
    var collectionView: UICollectionView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: AutoFlowLayout())
        view.addSubview(collectionView!)
        collectionView?.backgroundColor = UIColor.green
        
        collectionView?.register(UINib(nibName: "AutoTestCell", bundle: nil), forCellWithReuseIdentifier: "item")
        
        collectionView?.dataSource = self
        collectionView?.delegate = self
        
        
        //添加一个刷新控件
        let refreshControl = UIRefreshControl()
        
        refreshControl.tintColor = UIColor.red
        refreshControl.attributedTitle = NSAttributedString(string: "123")
        
        refreshControl.addTarget(self, action: #selector(refreshControlDidFire(_:)),
                                 
                                 for: .valueChanged)
        
        collectionView?.refreshControl = refreshControl
        
    }
    
    func refreshControlDidFire(_ sender: UIRefreshControl) {
        sender.endRefreshing()
    }
    
}

extension ViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return texts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "item", for: indexPath) as! AutoTestCell
        cell.textLabel.text = texts[(indexPath as NSIndexPath).item] + " + \((indexPath as NSIndexPath).item)"
        return cell
    }
}

class AutoFlowLayout: UICollectionViewFlowLayout {
    override init() {
        super.init()
        
//        estimatedItemSize = CGSize(width: 100, height: 100)
        //ios10
        estimatedItemSize = UICollectionViewFlowLayoutAutomaticSize
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
