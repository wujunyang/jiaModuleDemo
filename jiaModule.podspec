#
#  Be sure to run `pod spec lint jiaCore.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|

s.name         = "jiaModule"
s.version      = "0.0.3"
s.summary      = "一些常见功能的封装"

s.homepage     = "https://github.com/wujunyang/jiaModuleDemo"
s.author             = { "wujunyang" => "wujunyang@126.com" }

s.platform     = :ios, "7.0"

s.source       = { :git => "https://github.com/wujunyang/jiaModuleDemo.git", :tag => "0.0.3" }

s.requires_arc = true

s.subspec 'JiaCore' do |jiaCore|
jiaCore.source_files = 'jiaModuleDemo/jiaModuleDemo/BaseModule/JiaCore/**/*.{h,m}'
jiaCore.dependency 'XAspect'
jiaCore.dependency 'YYCache'
jiaCore.dependency 'JSPatch'
jiaCore.dependency 'RealReachability'
jiaCore.dependency 'FLEX', '~> 2.0'
jiaCore.dependency 'CocoaLumberjack', '~> 2.0.0-rc'
jiaCore.dependency 'AFNetworking', '~>2.6.0'
end

#s.subspec 'JiaGT' do |jiaGT|
#jiaGT.source_files = 'jiaModuleDemo/jiaModuleDemo/BaseModule/JiaGT/**/*'
#jiaGT.dependency 'jiaModule/JiaCore'
#jiaGT.dependency 'XAspect'
#jiaGT.dependency 'GTSDK', '~> 1.5.0'
#end

#s.subspec 'JiaAnalytics' do |jiaAnalytics|
#jiaAnalytics.source_files = 'jiaModuleDemo/jiaModuleDemo/BaseModule/JiaAnalytics/**/*'
#jiaAnalytics.dependency 'jiaModule/JiaCore'
#jiaAnalytics.dependency 'XAspect'
#jiaAnalytics.dependency 'UMengAnalytics-NO-IDFA', '~> 4.1.1'
#end



s.frameworks = 'UIKit'

# s.xcconfig = { "HEADER_SEARCH_PATHS" => "$(SDKROOT)/usr/include/libxml2" }
# s.dependency "JSONKit", "~> 1.4"
end
