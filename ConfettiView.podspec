#
# Be sure to run `pod lib lint ConfettiView.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'ConfettiView'
  s.version          = '0.1.1'
  s.summary          = 'Add a magnificent Confetti to any view in your app'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = 'This pod allows you to add Confetti to any view youd like in a very clean and easy way. It was inspired by HouseParty app'

  s.homepage         = 'https://github.com/orron/ConfettiView'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Or Ron' => 'or.ron10@gmail.com' }
  s.source           = { :git => 'https://github.com/orron/ConfettiView.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/or_ron'

  s.ios.deployment_target = '10.0'

  s.source_files = 'ConfettiView/Classes/**/*'
  
  # s.resource_bundles = {
  #   'ConfettiView' => ['ConfettiView/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
