Pod::Spec.new do |spec|
  spec.name = 'SPYCollectionController'
  spec.version = '0.0.1'
  spec.authors = {'Scott Petit' => 'petit.scott@gmail.com'}
  spec.homepage = 'https://bitbucket.org/ScottPetit/spycollectioncontroller'
  spec.summary = 'A way of locating iOS Protocols'
  spec.source = {:git => 'https://ScottPetit@bitbucket.org/ScottPetit/spycollectioncontroller.git', :tag => "v#{spec.version}"}
  spec.license = { :type => 'MIT', :file => 'LICENSE' }

  spec.platform = :ios
  spec.requires_arc = true
  spec.frameworks = 'UIKit', 'Foundation'
  spec.source_files = 'SPYCollectionController/'
end
