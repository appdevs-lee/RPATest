# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'RPATest' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for RPATest
  pod 'Alamofire'
  pod 'FSCalendar'
  pod 'Firebase/Analytics'
  pod 'Firebase/Messaging'
  pod 'RealmSwift', '~>10'
end

post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
        config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '15.0'
      end
    end
end
