//
//  AmuseViewModel.swift
//  DYZB
//
//  Created by hywin on 2018/12/6.
//  Copyright © 2018年 hywin. All rights reserved.
//

import UIKit

class AmuseViewModel: BaseViewModel {

}


extension AmuseViewModel {
    func loadAmuseData(finishedCallback : @escaping () -> ()) {
        loadAnchorData(isGroupData: true, URLString: "http://capi.douyucdn.cn/api/v1/getHotRoom/2", finishedCallback: finishedCallback)
    }
    
    
}
