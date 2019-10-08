#
# RICARDO MONTESINOS FERNANDEZ
# Uncomment the next line to define a global platform for your project
platform :ios, '13.0'
use_frameworks!
inhibit_all_warnings!

def dependency_pods
    # SWIFTLINT
    # pod 'SwiftLint'

    # ALAMOFIRE
    pod 'Alamofire', '~> 4.5'
    # pod 'AlamofireImage'
    pod 'ObjectMapper'
    pod 'AlamofireObjectMapper', '~> 5.2'
    
    # REALM
    # pod 'RealmSwift'
    # pod 'ObjectMapper+Realm'

    # RxSwift
    # pod 'RxSwift', '~> 4.0'
    # pod 'RxCocoa', '~> 4.0'
    # pod 'RxGesture'

    # YOUTUBE
    pod 'youtube-ios-player-helper', '~> 0.1.4'
    
    # Animations'
    pod 'lottie-ios'
    end

target 'TheMovieApp' do
  dependency_pods
end

target 'TheMovieAppTests' do
    inherit! :search_paths
    # Pods for testing
    dependency_pods
end
