
  platform:ios,'9.0'

  target "PassNurseExam" do
    
  inhibit_all_warnings!
  
  pod 'AFNetworking', '~> 3.2.1'
      
  pod 'AlipaySDK-iOS', '~> 15.5.9'
  
  pod 'WechatOpenSDK', '~> 1.8.6'

  pod 'TYPagerController', '~> 2.1.2'
  
  pod 'YYModel', '~> 1.0.4'
  
  pod 'IQKeyboardManager', '~> 5.0.7'
  
  pod 'FDFullscreenPopGesture', '1.1'
  
  pod 'DZNEmptyDataSet', '~> 1.8.1'
  
  pod 'NullSafe', '~> 1.2.2'
  
  pod 'MJRefresh', '~> 3.1.16'
  
  pod 'AESCrypt', '~> 0.0.1'
  
  pod 'AliyunPlayer_iOS/AliyunPlayerSDK'
  
  pod 'Masonry', '~>1.1.0'
  
  pod 'JPush', '~> 3.2.6'
  
  pod 'JCore', '2.1.4'
  
  pod 'SGQRCode', '~> 3.0.1'
  
  pod 'Luban_iOS', '~> 1.0.6'
  
  pod 'pop' , '~>1.0.10'
  
  pod 'ReactiveCocoa', '~>2.5'

  pod 'ZFPlayer/ControlView', '~> 3.2.13'
  
  pod 'ZFPlayer/AVPlayer', '~> 3.2.13'

  pod 'Popover.OC', :git => 'https://github.com/lifution/Popover.git'
  
  pod 'LMJVerticalScrollText', '~> 3.0.1'
    
  pod 'UMCAnalytics','~>6.0.5'
  
  pod 'FSCalendar', '~> 2.8.0'
  
  pod 'MBProgressHUD', '~> 1.1.0'
  
  pod 'SDWebImage', '~> 5.2.3'
  
  end


#修复 Xcode9 icon 不显示的问题
post_install do |installer|
  copy_pods_resources_path = "Pods/Target Support Files/Pods-PassNurseExam/Pods-PassNurseExam-resources.sh"
  string_to_replace = '--compile "${BUILT_PRODUCTS_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}"'
  assets_compile_with_app_icon_arguments = '--compile "${BUILT_PRODUCTS_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}" --app-icon "${ASSETCATALOG_COMPILER_APPICON_NAME}" --output-partial-info-plist "${BUILD_DIR}/assetcatalog_generated_info.plist"'
  text = File.read(copy_pods_resources_path)
  new_contents = text.gsub(string_to_replace, assets_compile_with_app_icon_arguments)
  File.open(copy_pods_resources_path, "w") {|file| file.puts new_contents }

  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      if config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'].to_f < 8.0
        config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '8.0'
      end
    end
  end
end
