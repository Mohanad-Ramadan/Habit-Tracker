platform :ios, '15.0'

target 'HabitTracker' do
  use_frameworks!
  
  pod 'Firebase/Auth'
  pod 'Firebase/Firestore'
  pod 'AlertToast'

end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['OTHER_LDFLAGS'] = '$(inherited)'
    end
  end
end
