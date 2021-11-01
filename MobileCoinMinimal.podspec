Pod::Spec.new do |s|

  # ―――  Spec Metadata  ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #

  s.name         = "MobileCoinMinimal"
  s.version      = "1.2.0-pre2"
  s.summary      = "A library for communicating with MobileCoin network"

  s.author       = "MobileCoin"
  s.homepage     = "https://www.mobilecoin.com/"

  s.license      = { :type => "GPLv3" }

  s.source       = { 
    :git => "https://github.com/mobilecoinofficial/MobileCoin-Swift.git",
    :tag => "v#{s.version}",
    :submodules => true
  }


  # ――― Platform Specifics ――――――――――――――――――――――――――――――――――――――――――――――――――――――― #

  s.platform     = :ios, "10.0"


  # ――― Subspecs ――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #

	s.source_files = [
		"Sources/**/*.{h,m,swift}",
		"LibMobileCoin/**/*.{h,m,swift}",
		"Glue/**/*.{h,m,swift}",
	]

	s.dependency "Logging", "~> 1.4"
	s.dependency "SwiftProtobuf"
	s.dependency "CocoaLumberjack"

	# s.test_spec do |test_spec|
	s.test_spec 'Tests' do |test_spec|
		test_spec.source_files = [
			'Tests/**/*.{h,m,swift}',
			'TestGlue/**/*.{h,m,swift}',
		]
		# test_spec.resources = 'Tests/**/*.{json,encrypted,webp}'
		test_spec.resources = 'Tests/**/*.*'
	end
  	
  # ――― Project Settings ――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #

  s.swift_version = "5.2"

  # The LibMobileCoin podspec specifies these xcconfig values in
  # `user_target_xcconfig`, however that only applies to app targets, not to the
  # intermediary frameworks. These must be speicifed here for CocoaPods to set them
  # on the framework target and any testspec targets for this pod.
  pod_target_xcconfig = {
    "GCC_OPTIMIZATION_LEVEL" => "z",
    "LLVM_LTO" => "YES",
    "ENABLE_BITCODE" => "YES",
    "SUPPORTS_MACCATALYST" => "YES",
    # The LibMobileCoin vendored binary doesn't include support for 32-bit
    # architectures or for arm64 iphonesimulator.
    "VALID_ARCHS[sdk=iphoneos*]" => "arm64",
    "VALID_ARCHS[sdk=iphonesimulator*]" => "x86_64 arm64",
  }

  unless ENV["MC_ENABLE_WARN_LONG_COMPILE_TIMES"].nil?
    pod_target_xcconfig['OTHER_SWIFT_FLAGS'] = '-Xfrontend -warn-long-function-bodies=500'
    pod_target_xcconfig['OTHER_SWIFT_FLAGS'] += ' -Xfrontend -warn-long-expression-type-checking=500'
  end

  s.pod_target_xcconfig = pod_target_xcconfig
end

