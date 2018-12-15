//
//  AmuseMenuView.swift
//  DYZB
//
//  Created by hywin on 2018/12/7.
//  Copyright © 2018年 hywin. All rights reserved.
//

import UIKit
private let kMenuCellID = "kMenuCellID"

class AmuseMenuView: UIView {

    // MARK: 定义属性
    var groups : [anchorDataModel]? {
        didSet {
            collectionView.reloadData()
        }
    }
    
    fileprivate lazy var collectionView : UICollectionView = {[weak self] in
        // 1.创建layout
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = (self?.bounds.size)!
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0

        layout.scrollDirection = .horizontal
        
        // 2.创建UICollectionView
        let collectionView = UICollectionView(frame: (self?.bounds)!, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.white
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = true
        collectionView.bounces = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.scrollsToTop = false
        collectionView.register(AmuseMenuViewCell.self, forCellWithReuseIdentifier: kMenuCellID)
        
        return collectionView
        }()
    
    
    fileprivate lazy var pageControl : UIPageControl = {
        let  page = UIPageControl()
        page.currentPageIndicatorTintColor = UIColor.orange
        page.pageIndicatorTintColor = UIColor.gray

        return page
    }()
    
    
    override init(frame: CGRect) {
        super .init(frame: frame)
        setupUI()
        self.addSubview(pageControl)
        pageControl.snp.makeConstraints { (mk) in
            mk.centerX.equalTo(self.snp.centerX).offset(0)
            mk.bottom.equalTo(self.snp.bottom).offset(-5)
//            mk.width.equalTo(45)
//            mk.height.equalTo(30)
            
        }
        
        
        self.addSubview(collectionView)
        collectionView.snp.makeConstraints { (mk) in
            mk.top.equalTo(self.snp.top).offset(0)
            mk.left.equalTo(self.snp.left).offset(0)
            mk.right.equalTo(self.snp.right).offset(0)
            mk.bottom.equalTo(pageControl.snp.top).offset(0)
            
        }
        
        
        
        
        
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension  AmuseMenuView{
    func setupUI() {
        self.addSubview(collectionView)
    }
    
}
extension AmuseMenuView : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if groups == nil { return 0 }
        let pageNum = (groups!.count - 1) / 8 + 1
        pageControl.numberOfPages = pageNum
        
        return pageNum
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // 1.取出cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kMenuCellID, for: indexPath) as! AmuseMenuViewCell
        
        // 2.给cell设置数据
        setupCellDataWithCell(cell: cell, indexPath: indexPath)
        
        return cell
    }
    
    private func setupCellDataWithCell(cell : AmuseMenuViewCell, indexPath : IndexPath) {
        // 0页: 0 ~ 7
        // 1页: 8 ~ 15
        // 2也: 16 ~ 23
        // 1.取出起始位置&终点位置
        let startIndex = indexPath.item * 8
        var endIndex = (indexPath.item + 1) * 8 - 1
        
        // 2.判断越界问题
        if endIndex > groups!.count - 1 {
            endIndex = groups!.count - 1
        }
        
        // 3.取出数据,并且赋值给cell
        cell.groups = Array(groups![startIndex...endIndex])
    }
    
    
    
}
// MARK ：
extension AmuseMenuView : UICollectionViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        pageControl.currentPage = Int(scrollView.contentOffset.x / scrollView.bounds.width)
    }
}
