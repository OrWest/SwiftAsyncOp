Pod::Spec.new do |s|
  s.name             = 'AsyncOperation'
  s.version          = '0.1.0'
  s.summary          = 'Swift basic class for asynchronous operation creation'
 
  s.homepage         = 'https://github.com/OrWest/AsyncOperation/'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Alexander Motarykin' => 'orwester@gmail.com' }
  s.source           = { :git => 'https://github.com/OrWest/AsyncOperation.git', :tag => s.version.to_s }
 
  s.ios.deployment_target = '10.0'
  s.source_files = 'Source/*.swift'
  s.swift_versions = '5.3'
 
end