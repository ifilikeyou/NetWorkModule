#
# Be sure to run `pod lib lint NetworkModule.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'NetworkModule'
  s.version          = '0.1.0'
  s.summary          = 'A short description of NetworkModule.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/ifilikeyou/NetworkModule'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'ifilikeyou' => '15801635316@163.com' }
  s.source           = { :git => 'https://github.com/ifilikeyou/NetworkModule.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

#  s.ios.deployment_target = '10.0'
#  s.source_files = 'NetworkModule/Classes/**/*'
  
  # s.resource_bundles = {
  #   'NetworkModule' => ['NetworkModule/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
  
  
  s.ios.deployment_target = '10.0'
  s.requires_arc = true
  s.swift_version   = ['5.0']
  s.public_header_files = 'Pod/Classes/**/*.h'
  
  
  s.source_files = ['NetWorkModule/Classes/**/*','NetWorkModule/Libs/include']

  
  s.ios.vendored_libraries = 'NetWorkModule/Libs/lib/*.{a}'
  s.ios.vendored_frameworks = 'NetWorkModule/Frameworks/*.{framework}'
  s.xcconfig = {'OTHER_LDFLAGS' => '-ObjC','USER_HEADER_SEARCH_PATHS' => 'NetWorkModule/Libs/include','HEADER_SEARCH_PATHS' => '"${PODS_ROOT}/../../NetWorkModule/Frameworks/Libs/include"'}

  
  s.dependency 'Moya', '~> 14.0'
  
  
  
end
