//
//  ZBAnchorCollectionCCell.swift
//  DYZB
//
//  Created by hywin on 2018/12/5.
//  Copyright © 2018年 hywin. All rights reserved.
//

import UIKit
import Kingfisher
import SnapKit
class ZBAnchorCollectionCCell: UICollectionViewCell {
    private let iconImageView       = UIImageView()
    private let onlineBtn       = UIButton()

    private let nickNameLabel       = UILabel()
    
    private let roomNameLabel       = UILabel()
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
            
            // 2.房间名称
            roomNameLabel.text = anchor.room_name
        }
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.contentView.addSubview(iconImageView)
        nickNameLabel.textColor = UIColor.white
        nickNameLabel.font = UIFont.systemFont(ofSize: 13)
        iconImageView.addSubview(nickNameLabel)
        onlineBtn.setTitleColor(UIColor.white, for: .normal)
        onlineBtn.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        iconImageView.addSubview(onlineBtn)
        roomNameLabel.textColor = UIColor.lightGray;
        roomNameLabel.font = UIFont.systemFont(ofSize: 13)
        self.contentView.addSubview(roomNameLabel)
        
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
            mk.bottom.equalTo(self.contentView.snp.bottom).offset(-20)
            
        }
        
        nickNameLabel.snp.makeConstraints { (mk) in
            mk.left.equalTo(iconImageView.snp.left).offset(10)
            mk.bottom.equalTo(iconImageView.snp.bottom).offset(-10)
            
        }
        
        onlineBtn.snp.makeConstraints { (mk) in
       
            mk.right.equalTo(iconImageView.snp.right).offset(-10)
            mk.bottom.equalTo(iconImageView.snp.bottom).offset(-10)
            
        }
        
        roomNameLabel.snp.makeConstraints { (mk) in
            mk.top.equalTo(iconImageView.snp.bottom).offset(0)
            mk.left.equalTo(self.contentView.snp.left).offset(10)
            mk.right.equalTo(self.contentView.snp.right).offset(0)
            mk.bottom.equalTo(self.contentView.snp.bottom).offset(0)
            
        }
        
        
    }
    
    
    
}
