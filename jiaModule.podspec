#
#  Be sure to run `pod spec lint jiaCore.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#
#  验证是否正确（后面还有一个git的私有地址)
#  pod lib lint jiaModule.podspec --allow-warnings --use-libraries --sources=https://github.com/CocoaPods/Specs.git,https://github.com/wujunyang/WjySpecs.git
#  提交到库  (WjySpecs就是你们的私有库名 后面还有一个git的私有地址)
#  pod repo push WjySpecs jiaModule.podspec --allow-warnings --use-libraries --sources=https://github.com/CocoaPods/Specs.git,https://github.com/wujunyang/WjySpecs.git
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|

s.name         = "jiaModule"
s.version      = "0.0.9"
s.summary      = "iOS模块化功能的引用"

s.homepage     = "https://github.com/wujunyang/jiaModuleDemo"
s.license      = { :type => "MIT", :file => "FILE_LICENSE" }
s.author             = { "wujunyang" => "wujunyang@126.com" }

s.platform     = :ios, "7.0"

s.source       = { :git => "https://github.com/wujunyang/jiaModuleDemo.git", :tag => "#{s.version}" }

s.requires_arc = true

s.subspec 'JiaCore' do |jiaCore|
jiaCore.source_files = 'jiaModuleDemo/BaseModule/JiaCore/**/*.{h,m}'
jiaCore.dependency 'XAspect'
jiaCore.dependency 'YYCache'
jiaCore.dependency 'JSPatch'
jiaCore.dependency 'RealReachability'
jiaCore.dependency 'FLEX', '~> 2.0'
jiaCore.dependency 'CocoaLumberjack', '~> 2.0.0-rc'
jiaCore.dependency 'AFNetworking', '~> 3.0'
end

s.subspec 'JiaGT' do |jiaGT|
jiaGT.source_files = 'jiaModuleDemo/BaseModule/JiaGT/**/*'
jiaGT.dependency 'jiaModule/JiaCore'
jiaGT.dependency 'XAspect'
jiaGT.dependency 'GTSDK'
end

s.subspec 'JiaAnalytics' do |jiaAnalytics|
jiaAnalytics.source_files = 'jiaModuleDemo/BaseModule/JiaAnalytics/**/*'
jiaAnalytics.dependency 'jiaModule/JiaCore'
jiaAnalytics.dependency 'XAspect'
jiaAnalytics.dependency 'Aspects'
jiaAnalytics.dependency 'UMengAnalytics-NO-IDFA', '~> 4.1.1'
end


s.subspec 'JiaShare' do |jiaShare|
jiaShare.source_files = 'jiaModuleDemo/BaseModule/JiaShare/**/*'
jiaShare.dependency 'jiaModule/JiaCore'
jiaShare.dependency 'XAspect'
jiaShare.dependency 'UMengUShare/UI'
jiaShare.dependency 'UMengUShare/Social/Sina'
jiaShare.dependency 'UMengUShare/Social/WeChat'
jiaShare.dependency 'UMengUShare/Social/QQ'
jiaShare.dependency 'UMengUShare/Social/TencentWeibo'
end



s.frameworks = 'UIKit'

# s.xcconfig = { "HEADER_SEARCH_PATHS" => "$(SDKROOT)/usr/include/libxml2" }
# s.dependency "JSONKit", "~> 1.4"
end
