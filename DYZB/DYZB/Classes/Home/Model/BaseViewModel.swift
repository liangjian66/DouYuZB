//
//  BaseViewModel.swift
//  DYZB
//
//  Created by hywin on 2018/12/6.
//  Copyright © 2018年 hywin. All rights reserved.
//

import Foundation
import HandyJSON

class BaseViewModel {
     var anchorGroups  = [anchorDataModel]()
}

struct anchorDataModel: HandyJSON {
    var room_list = [AnchorModel]()
    // 分类名称
    var tag_name : String = ""
    
    var icon_url : String = ""

    
}


struct responseModel: HandyJSON {
    
    var data:[anchorDataModel]?
    var error: Int!
}




extension BaseViewModel {
    func loadAnchorData(isGroupData : Bool, URLString : String, parameters : [String : Any]? = nil, finishedCallback : @escaping () -> ()) {
        NetworkTools.requestData(.get, URLString: URLString, parameters: parameters) { (result) in
            guard let resultDict = result as? [String : Any] else { return }
            guard let dataArray = resultDict["data"] as? [[String : NSObject]] else { return }
            
            
            if isGroupData {
                self.anchorGroups  += dataArray.compactMap({  anchorDataModel.deserialize(from: $0 as? Dictionary) })
//                self.anchorGroups.append(tempArr)
                
                
//                dataArray.compactMap({anchorDataModel.deserialize(from: $0 as? Dictionary)})
                print(self.anchorGroups)
//                if let responseModel = JSONDeserializer<responseModel>.deserializeFrom(json: result as? String) {
//
////                    /// model转json 为了方便在控制台查看
////                    print(responseModel.toJSONString(prettyPrint: true)!)
////
////                    /// 遍历responseModel.data
////                    responseModel.data?.forEach({ (model) in
////                        print(model.nickname!);
////                    })
//                    self.anchorGroups = responseModel.data!
//
//                }
           
                
            } else {
                
                
            }
            
            
            // 3.完成回调
            finishedCallback()
        
        
      }
    
    }

}
