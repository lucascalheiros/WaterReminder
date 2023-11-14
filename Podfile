# Uncomment the next line to define a global platform for your project
platform :ios, '13.0'
use_frameworks!
workspace 'WaterReminder'


def rxSwift
  pod 'RxSwift', '6.6.0'
  pod 'RxCocoa', '6.6.0'
  pod 'RxSwiftExt', '6.2.1'
end

def realm
  pod 'RealmSwift', '~>10.40.1'
  pod 'RxRealm', :git => 'https://github.com/RxSwiftCommunity/RxRealm.git', :branch => 'main'
end

def swinject
  pod 'Swinject', '2.8.3'
  pod 'SwinjectAutoregistration', '2.8.3'
end

def rxFlow
  pod 'RxFlow', '2.13.0'
end

target 'WaterReminder' do
  rxSwift
  rxFlow
  realm
  swinject
  
  target 'WaterReminderTests' do
    inherit! :search_paths
  end

  target 'WaterReminderUITests' do
    inherit! :search_paths
  end
end

target 'Common' do
  project 'Common/Common'
  rxSwift
  target 'CommonTests' do
    inherit! :search_paths
  end
end

target 'Core' do
  project 'Core/Core'
  rxSwift
  rxFlow
  realm
  swinject
  target 'CoreTests' do
    inherit! :search_paths
  end
end

target 'Components' do
  project 'Components/Components'
  target 'ComponentsTests' do
    inherit! :search_paths
  end
end



target 'Settings' do
  project 'Settings/Settings'
  target 'SettingsTests' do
    inherit! :search_paths
  end
end
