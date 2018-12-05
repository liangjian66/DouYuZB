//
//  BaseAnchorViewController.swift
//  DYZB
//
//  Created by hywin on 2018/12/5.
//  Copyright © 2018年 hywin. All rights reserved.
//

import UIKit
import HandyJSON
//  主播  父类VC


private let kItemMargin : CGFloat = 10
private let kHeaderViewH : CGFloat = 50

private let kNormalCellID = "kNormalCellID"
private let kHeaderViewID = "kHeaderViewID"

let kPrettyCellID = "kPrettyCellID"
let kNormalItemW = (kScreenW - 3 * kItemMargin) / 2
let kNormalItemH = kNormalItemW * 3 / 4
let kPrettyItemH = kNormalItemW * 4 / 3



class BaseAnchorViewController: UIViewController {

    var AnchorModels = [AnchorModel]()
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
        collectionView.delegate = self
        collectionView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        
        collectionView.register(ZBAnchorCollectionCCell.self, forCellWithReuseIdentifier: kNormalCellID)
        
        return collectionView
        }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        loadData()


    }

}

// 设置 主界面
extension  BaseAnchorViewController {
    // 2.添加collectionView
    func setupUI()  {
        view.addSubview(collectionView)
    }
    
}

// MARK:- 请求数据
extension BaseAnchorViewController {
    func loadData() {
        NetworkTools.requestData(.get, URLString: "http://capi.douyucdn.cn/api/v1/getbigDataRoom", parameters: ["time" : Date.getCurrentTime()]) { (result) in
            
            // 1.将result转成字典类型
            guard let resultDict = result as? [String : NSObject] else { return }
            
            // 2.根据data该key,获取数组
            guard let dataArray = resultDict["data"] as? [[String : NSObject]] else { return }
            self.AnchorModels += dataArray.compactMap({ AnchorModel.deserialize(from: $0 as? Dictionary) })
            
            print(self.AnchorModels)
            self.collectionView.reloadData()

            // 3.遍历字典,并且转成模型对象
            // 3.1.设置组的属性
//            self.bigDataGroup.tag_name = "热门"
//            self.bigDataGroup.icon_name = "home_header_hot"
//
//            // 3.2.获取主播数据
//            for dict in dataArray {
//                let anchor = AnchorModel(dict: dict)
//                self.bigDataGroup.anchors.append(anchor)
//            }
            
           
        }
    }
}

extension  BaseAnchorViewController : UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return AnchorModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kNormalCellID, for: indexPath) as! ZBAnchorCollectionCCell
        
        // 2.给cell设置数据
//        cell.anchor = baseVM.anchorGroups[indexPath.section].anchors[indexPath.item]
        cell.anchor = AnchorModels[indexPath.item]
        
        return cell
    }
    
}


// MARK:- 遵守UICollectionView的代理协议
extension BaseAnchorViewController : UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("点击了")
    }
    
    
}

