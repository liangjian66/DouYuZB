//
//  AmuseMenuViewCell.swift
//  DYZB
//
//  Created by hywin on 2018/12/7.
//  Copyright © 2018年 hywin. All rights reserved.
//

import UIKit

private let kGameCellID = "kGameCellID"


class AmuseMenuViewCell: UICollectionViewCell {
    // MARK: 数组模型
    var groups : [anchorDataModel]? {
        didSet {
            collectionView.reloadData()
        }
    }
    
    
    fileprivate lazy var collectionView : UICollectionView = {[weak self] in
        // 1.创建layout
        let layout = UICollectionViewFlowLayout()
        
        let itemW = (self?.bounds.width)! / 4
        let itemH = (self?.bounds.height)! / 2
        layout.itemSize = CGSize(width: itemW, height: itemH)
       
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        //        layout.scrollDirection = .horizontal
        
        // 2.创建UICollectionView
        let collectionView = UICollectionView(frame: (self?.bounds)!, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.white

        collectionView.showsHorizontalScrollIndicator = false
//        collectionView.isPagingEnabled = true
        collectionView.bounces = false
                collectionView.dataSource = self
//                collectionView.delegate = self
        collectionView.scrollsToTop = false
                collectionView.register(CollectionGameCell.self, forCellWithReuseIdentifier: kGameCellID)
        
        return collectionView
        }()
    
    override init(frame: CGRect) {
       super.init(frame: frame)
        self.contentView.addSubview(collectionView)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}

extension AmuseMenuViewCell : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return groups?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // 1.求出Cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kGameCellID, for: indexPath) as! CollectionGameCell
        
        // 2.给Cell设置数据
        cell.baseGame = groups![indexPath.item]
        cell.clipsToBounds = true
        
        return cell
    }
}
