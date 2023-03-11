# Uncomment this line to define a global platform for your project
platform :ios, '12.0'

# Uncomment this line if you're using Swift
use_frameworks!

workspace 'SAAdvertisingSDKStandardExample'

target 'SAAdvertisingSDKStandardExample' do
  project 'SAAdvertisingSDKStandardExample/SAAdvertisingSDKStandardExample.xcodeproj'
  pod 'SAAdvertisingSDKStandard', :path => './'

  # https://github.com/devxoul/Toaster - used to show toast message.
  pod 'Toaster'
end

# fix that error https://github.com/CocoaPods/CocoaPods/issues/10185#issuecomment-722332929
post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['BUILD_LIBRARY_FOR_DISTRIBUTION'] = 'YES'
    end
  end
end
