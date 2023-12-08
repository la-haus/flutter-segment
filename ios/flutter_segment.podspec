#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#
Pod::Spec.new do |s|
  s.name             = 'flutter_segment'
  s.version          = '3.13.1'
  s.summary          = 'Segment.io plugin for Flutter'
  s.description      = <<-DESC
Library to let Flutter apps use Segment.io
                       DESC
  s.homepage         = 'https://github.com/la-haus/flutter-segment'
  s.license          = { :type => 'MIT', :file => '../LICENSE' }
  s.author           = 'La Haus'
  s.source           = { :git => "https://github.com/la-haus/flutter-segment.git", :tag => s.version.to_s }

  s.source_files = 'Classes/**/*'
  s.public_header_files = 'Classes/**/*.h'

  s.dependency 'Flutter'
  s.dependency 'Analytics', '4.1.6'
  s.dependency 'Segment-Amplitude', '3.3.2'
  s.dependency 'segment-appsflyer-ios', '6.12.2'
  s.ios.deployment_target = '11.0'

  # Added because Segment-Amplitude dependencies on iOS cause this error:
  # [!] The 'Pods-Runner' target has transitive dependencies that include statically linked binaries: (Segment-Amplitude)
  s.static_framework = true
end

