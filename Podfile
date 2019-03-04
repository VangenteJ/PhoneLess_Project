# Uncomment the next line to define a global platform for your project
 platform :ios, '9.0'

target 'PhoneLess_Project' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!

  # Pods for PhoneLess_Project
	pod 'Firebase/Core'
	pod 'Firebase/Auth'
	pod 'Firebase/Database'
	pod 'IQKeyboardManagerSwift'
	pod 'Firebase/Storage'
	pod 'TextFieldEffects'
	pod 'GameCenterManager'
	pod 'SVProgressHUD'
	pod 'Charts'

  # Workaround for Cocoapods issue #7606
	post_install do |installer|
    	installer.pods_project.build_configurations.each do |config|
        config.build_settings.delete('CODE_SIGNING_ALLOWED')
        config.build_settings.delete('CODE_SIGNING_REQUIRED')
   end
   end

  target 'PhoneLess_ProjectTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'PhoneLess_ProjectUITests' do
    inherit! :search_paths
    # Pods for testing
  end

end
