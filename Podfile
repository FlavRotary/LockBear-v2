# Uncomment the next line to define a global platform for your project
 platform :ios, '11.0'

target 'Lock Bear' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!

  # Pods for Lock Bear

pod 'IQKeyboardManager'
pod 'SQLite.swift'
pod 'KeychainSwift'
pod 'NVActivityIndicatorView'
pod 'GBFloatingTextField', '~> 1.0'

end

post_install do |installer|
 installer.pods_project.targets.each do |target|
     target.build_configurations.each do |config|
         config.build_settings['SWIFT_VERSION'] = '5.0'
     end
 end
end
