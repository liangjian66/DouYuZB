//
//  HomeBaseViewController.swift
//  DYZB
//
//  Created by hywin on 2018/12/6.
//  Copyright © 2018年 hywin. All rights reserved.
//

import UIKit




private let kItemMargin : CGFloat = 10
private let kHeaderViewH : CGFloat = 50

private let kNormalCellID = "kNormalCellID"



private let kHeaderViewID = "kHeaderViewID"

//let kPrettyCellID = "kPrettyCellID"
//let kNormalItemW = (kScreenW - 3 * kItemMargin) / 2
//let kNormalItemH = kNormalItemW * 3 / 4
//let kPrettyItemH = kNormalItemW * 4 / 3


class HomeBaseViewController: UIViewController {
    // MARK: 定义属性
    var baseVM : BaseViewModel!
    
    // MARK: 懒加载属性
    fileprivate lazy var amuseVM : AmuseViewModel = AmuseViewModel()
    
    lazy var collectionView : UICollectionView = {[unowned self] in
        // 1.创建布局
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: kNormalItemW, height: kNormalItemH)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = kItemMargin
        layout.headerReferenceSize = CGSize(width: kScreenW, height: kHeaderViewH)
        layout.sectionInset = UIEdgeInsets(top: 0, left: kItemMargin, bottom: 0, right: kItemMargin)
        
        // 2.创建UICollectionView
        let collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.white
        collectionView.dataSource = self
        collectionView.delegate = self as! UICollectionViewDelegate
        collectionView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        
        collectionView.register(ZBAnchorCollectionCCell.self, forCellWithReuseIdentifier: kNormalCellID)
        
        collectionView.register(ZBPrettyCell.self, forCellWithReuseIdentifier: kPrettyCellID)
        
        return collectionView
        }()
    
    
    
    // MARK: 系统回调
    override func viewDidLoad() {
        super.viewDidLoad()
        baseVM = amuseVM
        setupUI()
        loadData()
    }



}


// MARK:- 设置UI界面
extension HomeBaseViewController {
     func setupUI() {
        // 1.给父类中内容View的引用进行赋值
//        contentView = collectionView
        // 2.添加collectionView
        view.addSubview(collectionView)
        
        
    }
}

// MARK:- 请求数据
extension HomeBaseViewController {
    func loadData() {
        
        amuseVM.loadAmuseData {
            // 2.1.刷新表格
            
            self.baseVM.anchorGroups = self.amuseVM.anchorGroups
            
            self.collectionView.reloadData()
            
            // 2.2.调整数据
//            var tempGroups = self.amuseVM.anchorGroups
//            tempGroups.removeFirst()
//            self.menuView.groups = tempGroups
            
            // 3.数据请求完成
//            self.loadDataFinished()
        }
    }
}

// MARK:- 遵守UICollectionView的数据源
extension HomeBaseViewController : UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return baseVM.anchorGroups.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return baseVM.anchorGroups[section].room_list.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // 1.取出Cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kNormalCellID, for: indexPath) as! ZBAnchorCollectionCCell
        
        
        let  tempAnchor = baseVM.anchorGroups[indexPath.section] as? anchorDataModel
        cell.anchor = tempAnchor?.room_list[indexPath.row]
        return cell
    }
    
//    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
//        // 1.取出HeaderView
//        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: kHeaderViewID, for: indexPath) as! CollectionHeaderView
//
//        // 2.给HeaderView设置数据
//        headerView.group = baseVM.anchorGroups[indexPath.section]
//
//        return headerView
//    }
}


// MARK:- 遵守UICollectionView的代理协议
extension HomeBaseViewController : UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("点击了")
    }
    
}


