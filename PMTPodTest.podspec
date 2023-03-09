Pod::Spec.new do |spec|
  spec.name          = 'PMTPodTest'
  spec.version       = '1.0.4'
  spec.description  = <<-DESC
			This is pod test add encrypt
                   DESC
  spec.license      = { :type => "MIT", :file => "LICENSE" }
  spec.homepage      = 'https://github.com/ThanhPhuc11/PMTPodTest'
  spec.authors       = { 'phucmt' => 'mbat243@gmail.com' }
  spec.summary       = 'Pod test'
  spec.platform     = :ios, "5.0"
  spec.source        = { :git => 'https://github.com/ThanhPhuc11/PMTPodTest.git', :tag => "#{spec.version}" }
  #spec.source_files  = 'Classes/**/*.c'
  #spec.exclude_files = "Classes/Exclude"
  spec.vendored_frameworks = 'PMTPodTest.xcframework'

end