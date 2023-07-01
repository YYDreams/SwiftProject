# Uncomment the next line to define a global platform for your project
 platform :ios, '10.0'


target 'SwiftProject' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!
  inhibit_all_warnings!


  # Pods for SwiftProject

  # 任务（并/串行）处理库
  pod 'PromiseKit', :git => 'https://gitee.com/xiaoeappteam/PromiseKit.git', :tag => '6.18.0'
  pod 'MBProgressHUD'
    # 网络库
pod 'Alamofire', :git => 'https://gitee.com/chuansong16/Alamofire.git', :tag => '4.8.2'

    # 约束库
  pod 'SnapKit' 
    # 动画
  pod 'lottie-ios', '3.2.3'
    # 网络图片库
  pod 'Kingfisher', '6.3.1'
  
  pod 'MJRefresh','3.7.2'
  
  # UI 调试库（pauley）
  #  pod 'Reveal-SDK', :configurations => ['Debug']
  pod 'LookinServer', :git => 'https://gitee.com/chuansong16/LookinServer.git', :configurations => ['Debug']

  
  
  pod 'SwiftyJSON', :git => 'https://gitee.com/chuansong16/SwiftyJSON.git', :commit => 'bad5f2f'
  # Json转模型
  pod 'HandyJSON', :git => 'https://gitee.com/chuansong16/HandyJSON.git', :branch => 'develop'
  
  pod 'JXCategoryView', '1.5.9'
  
  pod 'JXSegmentedView','1.2.7'
  
pod 'Moya', '13.0.1'

  pod 'PGPickerView', '1.3.8'
  
 # pod 'RxSwift'
#  pod 'RxCocoa'
  
  pod 'SDCycleScrollView'
  
  pod 'GKCycleScrollView', '1.0.6'
  
  pod 'GGWkCookie','0.1.2'
  
  pod 'TTGTagCollectionView'
  
#  pod 'SwifterSwift', '5.2.0'
  pod 'JTAppleCalendar'
#  #此处根据自己Flutter项目实际路径填写
#  flutter_application_path = '../flutter_application_1'
#  #此句不可缺少
#  load File.join(flutter_application_path, '.ios', 'Flutter', 'podhelper.rb')
#
#  target 'SwiftProject' do
#    install_all_flutter_pods(flutter_application_path)
#  end
  
  #pod 'ZTLogManager'
  

#============================== 基础组件 ==================================#
#pod 'SPBaseUI', :git => 'https://github.com/YYDreams/SPBaseUI.git'

# pod 'SPBaseUI', :path => '../SPBaseUI'
#
#    
##  pod 'XMUtil', :git => 'https://github.com/YYDreams/XMUtil.git', :branch => 'feature/swiftProject'
#  pod 'XMUtil', :path => 'Lib/XMUtil'
#  
#  # 网络请求库
#  pod 'SPNetwork', :git => 'git@github.com:YYDreams/SPNetwork.git'
#  
##  pod 'SPNetwork', :path => 'Lib/SPNetwork'
#  # 核心库
#  pod 'SPAppCore', :git => 'git@github.com:YYDreams/SPAppCore.git'
#  #pod 'SPAppCore', :path => 'Lib/SPAppCore'
#  
#  pod 'SPDataCache', :git => 'git@github.com:YYDreams/SPDataCache.git'
#  #  pod 'SPDataCache', :path => 'Lib/SPDataCache'
#
#  pod 'SPWidget', :git => 'git@github.com:YYDreams/SPWidget.git'
##  pod 'SPWidget', :path => 'Lib/SPWidget'
#
#
##============================== 公共模块 ==================================#
#pod 'SPMediator', :git => 'git@github.com:YYDreams/SPMediator.git'
#
##pod 'SPUserCenterUI', :git => 'git@github.com:YYDreams/SPUserCenterUI.git'
## 个人中心
#pod 'SPUserCenterUI', :path => '../SPUserCenterUI'
#
##pod 'SPUserCenterUIExtension', :git => 'git@github.com:YYDreams/SPUserCenterUIExtension.git'
#
#pod 'SPUserCenterUIExtension', :path => '../SPUserCenterUIExtension'
#
#
## 总结复盘(每月总结一次)
#pod 'SPSummaryReviewUI', :path => '../SPSummaryReviewUI'
#
#pod 'SPSummaryReviewUIExtension', :path => '../SPSummaryReviewUIExtension'
#
#
#
#
#
#
#
##============================== 商城App ==================================#
#
#
## 首页
#pod 'SPHomeUI', :git => 'git@github.com:YYDreams/SPHomeUI.git'
#
##  pod 'SPHomeUI', :path => '../SPHomeUI'
# 
# pod 'SPHomeUIExtension', :git => 'git@github.com:YYDreams/SPHomeUIExtension.git'
# 
#  pod 'SPHomeUIExtension', :path => '../SPHomeUIExtension'
  

  target 'SwiftProjectTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'SwiftProjectUITests' do
    # Pods for testing
  end

end



#解决：[!] The 'Pods-SwiftProject' target has transitive dependencies that include statically linked binaries: (SPSummaryReviewUI) 报错
#pre_install do |installer|
#  # workaround for https://github.com/CocoaPods/CocoaPods/issues/3289
#  Pod::Installer::Xcode::TargetValidator.send(:define_method, :verify_no_static_framework_transitive_dependencies) {}
#
#  end


## 处理不同模块引用问题
#post_install do |installer|
#  installer.pods_project.build_configuration_list.build_configurations.each do |configuration|
#    configuration.build_settings['CLANG_ALLOW_NON_MODULAR_INCLUDES_IN_FRAMEWORK_MODULES'] = 'YES'
#  end
#  installer.pods_project.targets.each do |target|
#     target.build_configurations.each do |config|
#       config.build_settings['APPLICATION_EXTENSION_API_ONLY'] = 'NO'
#     end
#   end
#end

