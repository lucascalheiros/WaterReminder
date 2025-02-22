# Uncomment the next line to define a global platform for your project
platform :ios, '13.0'
use_frameworks!
workspace 'WaterReminder'


def rxSwift
  pod 'RxSwift', '6.8.0'
  pod 'RxCocoa', '6.8.0'
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
  swinject
  pod 'GRDB.swift'

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
  rxSwift
  rxFlow
  swinject
  target 'SettingsTests' do
    inherit! :search_paths
  end
end

target 'WaterReminderNotificationDomain' do
  project 'WaterReminderNotificationDomain/WaterReminderNotificationDomain'
  swinject
  rxSwift
  pod 'GRDB.swift'
  target 'WaterReminderNotificationDomainTests' do
    inherit! :search_paths
  end
end

target 'WaterManagementDomain' do
  project 'WaterManagementDomain/WaterManagementDomain'
  swinject
  rxSwift
  pod 'GRDB.swift'
  target 'WaterManagementDomainTests' do
    inherit! :search_paths
  end
end

target 'UserInformationDomain' do
  project 'UserInformationDomain/UserInformationDomain'
  swinject
  rxSwift
  pod 'GRDB.swift'
  target 'UserInformationDomainTests' do
    inherit! :search_paths
  end
end

target 'Home' do
  project 'Home/Home'
  swinject
  rxSwift
  target 'HomeTests' do
    inherit! :search_paths
  end
end

target 'FirstAccess' do
  project 'FirstAccess/FirstAccess'
  swinject
  rxSwift
  target 'FirstAccessTests' do
    inherit! :search_paths
  end
end

target 'History' do
  project 'History/History'
  swinject
  rxSwift
  target 'HistoryTests' do
    inherit! :search_paths
  end
end
