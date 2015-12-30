# Uncomment this line to define a global platform for your project
platform :ios, '8.0'
# Uncomment this line if you're using Swift
# use_frameworks!

target 'Bonjour' do

pod 'DTBonjour',                      '~> 1.1.1'
pod 'JSQMessagesViewController',      '~> 7.2.0'
pod 'BabyBluetooth'

end


target 'BonjourTests' do

end

target 'BonjourUITests' do

end


post_install do |installer|
    installer.pods_project.targets.each do |target|
         target.build_configurations.each do |config|
            if target.name == "Bonjour"
                config.build_settings["OTHER_LDFLAGS"] = '$(inherited) "-ObjC"'
            end
        end
    end
end
