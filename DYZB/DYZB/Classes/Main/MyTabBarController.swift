//
//  MyTabBarController.swift
//  Today
//
//  Created by hywin on 2018/8/21.
//  Copyright © 2018年 hywin. All rights reserved.
//

import UIKit
import SwiftTheme



class MyTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let tabbar = UITabBar.appearance()
//        tabbar.theme_tintColor = "colors.tabbarTintColor"
        tabbar.tintColor = UIColor.orange
//        tabbar.theme_barTintColor = "colors.cellBackgroundColor"
        addChildViewControllers()

    }
    /// 添加子控制器
    private func addChildViewControllers() {
        setChildViewController(HomeViewController(), title: "首页", imageName: "btn_home")
        setChildViewController(HomeViewController(), title: "直播", imageName: "btn_column")
        //        setChildViewController(RedPackageViewController(), title: "", imageName: "redpackage")
        
        setChildViewController(HomeViewController(), title: "关注", imageName: "btn_live")
        setChildViewController(HomeViewController(), title: "我的", imageName: "btn_user")
        // tabBar 是 readonly 属性，不能直接修改，利用 KVC 把 readonly 属性的权限改过来
        //        setValue(MyTabBar(), forKey: "tabBar")
    }
    // 初始化子控制器
    private func setChildViewController (_ childController:UIViewController,title:String , imageName:String){
        
        childController.tabBarItem.title = title
        
        setDayChildController(controller: childController, imageName: imageName)
        
        addChildViewController(MyNavigationController(rootViewController: childController))
        
    }
    
    /// 设置日间控制器  HomeViewController btn_home_selected btn_home_normal
    private func setDayChildController(controller: UIViewController, imageName: String) {
        controller.tabBarItem.image = UIImage(named: imageName + "_normal")
        controller.tabBarItem.selectedImage = UIImage(named: imageName + "_selected")
    }
    

}
