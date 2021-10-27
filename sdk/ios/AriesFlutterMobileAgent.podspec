#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint AriesFlutterMobileAgent.podspec' to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'AriesFlutterMobileAgent'
  s.version          = '0.0.1'
  s.summary          = 'A new flutter plugin project.'
  s.description      = <<-DESC
A new flutter plugin project.
                       DESC
  s.homepage         = 'http://example.com'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Your Company' => 'email@example.com' }
  s.source           = { :path => '.', :path => 'https://github.com/hyperledger/indy-sdk.git' }
  s.source_files = 'Classes/**/*'
  s.dependency 'Flutter'
  # s.dependency 'libindy'
  # s.dependency 'libindy-objc', '~> 1.8.2'

  s.platform = :ios, '13.0'

  # Flutter.framework does not contain a i386 slice.
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386' }
  s.swift_version = '5.0'
end
