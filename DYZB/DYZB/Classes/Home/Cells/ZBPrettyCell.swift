//
//  ZBPrettyCell.swift
//  DYZB
//
//  Created by hywin on 2018/12/5.
//  Copyright © 2018年 hywin. All rights reserved.
//

import UIKit

class ZBPrettyCell: UICollectionViewCell {
    private let iconImageView       = UIImageView()
    private let onlineBtn       = UIButton()
    
    private let nickNameLabel       = UILabel()
    
    private let cityBtn       = UIButton()
    var anchor : AnchorModel? {
        didSet {
            // 0.校验模型是否有值
            guard let anchor = anchor else { return }
            
            // 1.取出在线人数显示的文字
            var onlineStr : String = ""
            if anchor.online >= 10000 {
                onlineStr = "\(Int(anchor.online / 10000))万在线"
            } else {
                onlineStr = "\(anchor.online)在线"
            }
            onlineBtn.setTitle(onlineStr, for: UIControlState())
            
            // 2.昵称的显示
            nickNameLabel.text = anchor.nickname
            
            // 3.设置封面图片
            guard let iconURL = URL(string: anchor.vertical_src) else { return }
            iconImageView.kf.setImage(with: iconURL)
            
            // 2.所在的城市
            cityBtn.setTitle(anchor.anchor_city, for: UIControlState())        }
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.contentView.addSubview(iconImageView)
        nickNameLabel.textColor = UIColor.gray
        nickNameLabel.font = UIFont.systemFont(ofSize: 13)
        self.contentView.addSubview(nickNameLabel)
        onlineBtn.setTitleColor(UIColor.white, for: .normal)
        onlineBtn.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        iconImageView.addSubview(onlineBtn)
        
        cityBtn.setTitleColor(UIColor.gray, for: .normal)
        cityBtn.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        
        self.contentView.addSubview(cityBtn)
        
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        iconImageView.snp.makeConstraints { (mk) in
            mk.top.equalTo(self.contentView.snp.top).offset(0)
            mk.left.equalTo(self.contentView.snp.left).offset(0)
            mk.right.equalTo(self.contentView.snp.right).offset(0)
            mk.bottom.equalTo(self.contentView.snp.bottom).offset(-40)
            
        }
        
        nickNameLabel.snp.makeConstraints { (mk) in
            mk.left.equalTo(self.contentView.snp.left).offset(10)
            mk.top.equalTo(iconImageView.snp.bottom).offset(3)
            
        }
        
        onlineBtn.snp.makeConstraints { (mk) in
            
            mk.right.equalTo(iconImageView.snp.right).offset(-10)
            mk.top.equalTo(iconImageView.snp.top).offset(10)
            
        }
        
        cityBtn.snp.makeConstraints { (mk) in
            mk.top.equalTo(nickNameLabel.snp.bottom).offset(2)
            mk.left.equalTo(iconImageView.snp.left).offset(10)
            
        }
        
    }
}
