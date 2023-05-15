#
# Be sure to run `pod lib lint SAAdvertisingSDKStandard.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "SAAdvertisingSDKStandard"
  s.version          = "0.5.1"
  s.summary          = "#{s.name} (iOS) #{s.version}"

  s.homepage         = "https://github.com/solutionarchitectstech/mobile_sdk_release_ios"
  s.author           = { "SolutionArchitects" => "sergey.muravev@gmail.com" }
  s.license          = { :type => 'Apache-2.0', :file => 'LICENSE' }

  s.source               = { :git => "#{s.homepage}.git", :tag => "#{s.version}" }
  s.vendored_frameworks  = "#{s.name}.xcframework"

  s.platform = :ios
  s.ios.deployment_target = '12.0'
  s.swift_version = '5.0'

  s.frameworks = 'WebKit'
end
