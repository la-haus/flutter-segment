#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#
Pod::Spec.new do |s|
  s.name             = 'flutter_segment'
  s.version          = '0.0.1'
  s.summary          = 'A new flutter plugin project.'
  s.description      = <<-DESC
A new flutter plugin project.
                       DESC
  s.homepage         = 'http://example.com'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Your Company' => 'email@example.com' }
  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*'
  s.public_header_files = 'Classes/**/*.h'
  s.dependency 'Flutter'
  s.dependency 'Analytics', '4.1.6'
  s.dependency 'Segment-Amplitude', '3.3.2'
  s.dependency 'segment-appsflyer-ios', '6.5.2'
  s.ios.deployment_target = '11.0'

  # Added because Segment-Amplitude dependencies on iOS cause this error:
  # [!] The 'Pods-Runner' target has transitive dependencies that include statically linked binaries: (Segment-Amplitude)
  s.static_framework = true
end

