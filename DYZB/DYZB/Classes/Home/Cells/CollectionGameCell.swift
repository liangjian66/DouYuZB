//
//  CollectionGameCell.swift
//  DYZB
//
//  Created by hywin on 2018/12/7.
//  Copyright © 2018年 hywin. All rights reserved.
//

import UIKit

class CollectionGameCell: UICollectionViewCell {
    
    var iconImageView : UIImageView  =  UIImageView()
    
    var titleLabel : UILabel  =  UILabel()

    
    // MARK: 定义模型属性  
    var baseGame : anchorDataModel? {
        didSet {
            titleLabel.text = baseGame?.tag_name
            
            if let iconURL = URL(string: baseGame?.icon_url ?? "") {
                iconImageView.kf.setImage(with: iconURL)
            } else {
                
                iconImageView.image = UIImage(named: "home_more_btn")
            }
           
        }
    }
    
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.contentView.addSubview(iconImageView)
        titleLabel.textColor = UIColor.gray
        titleLabel.font = UIFont.systemFont(ofSize: 13)
        self.contentView.addSubview(titleLabel)

        
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        iconImageView.snp.makeConstraints { (mk) in
            mk.centerX.equalTo(self.contentView.snp.centerX).offset(0)
            mk.centerY.equalTo(self.contentView.snp.centerY).offset(-8)
            
            mk.width.equalTo(40)
            mk.height.equalTo(40)

        }
        iconImageView.contentMode = .scaleAspectFill
        //设置遮罩
        iconImageView.layer.masksToBounds = true
        //设置圆角半径(宽度的一半)，显示成圆形。
        iconImageView.layer.cornerRadius = iconImageView.frame.width/2
        
        titleLabel.snp.makeConstraints { (mk) in
            mk.centerX.equalTo(self.contentView.snp.centerX).offset(0)
            mk.top.equalTo(iconImageView.snp.bottom).offset(2)
            
            
        }
        
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
