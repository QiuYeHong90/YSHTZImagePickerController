#
# Be sure to run `pod lib lint YSHTZImagePickerController.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'YSHTZImagePickerController'
  s.version          = '0.1.0'
  s.summary          = 'A short description of YSHTZImagePickerController.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/793983383@qq.com/YSHTZImagePickerController'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { '793983383@qq.com' => '793983383@qq.com' }
  s.source           = { :git => 'git@github.com:QiuYeHong90/YSHTZImagePickerController.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'
#  s.resources    = 'YSHTZImagePickerController/Assets/*.{png,bundle}'
  s.source_files = 'YSHTZImagePickerController/Classes/**/*'
  
   s.resource_bundles = {
       'YSHTZImagePickerController' => ['YSHTZImagePickerController/Assets/*.{png,bundle}']
       
   }

  # s.public_header_files = 'Pod/Classes/**/*.h'
   s.frameworks   = "Photos"
  
   s.requires_arc = true

end
