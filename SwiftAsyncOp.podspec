Pod::Spec.new do |s|
  s.name             = 'SwiftAsyncOp'
  s.version          = '0.1.1'
  s.summary          = 'Swift basic class for asynchronous operation creation'
 
  s.homepage         = 'https://github.com/OrWest/SwiftAsyncOp/'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Alexander Motarykin' => 'orwester@gmail.com' }
  s.source           = { :git => 'https://github.com/OrWest/SwiftAsyncOp.git', :tag => s.version.to_s }
 
  s.ios.deployment_target = '10.0'
  s.source_files = 'Source/*.swift'
  s.swift_versions = '5.3'
 
end