Pod::Spec.new do |spec|
  spec.name = 'SPYCollectionController'
  spec.version = '0.0.2'
  spec.authors = {'Scott Petit' => 'petit.scott@gmail.com'}
  spec.homepage = 'https://github.com/ScottPetit/SPYCollectionController'
  spec.summary = 'A Collection View Data Source and Delegate for the simple things'
  spec.source = {:git => 'https://github.com/ScottPetit/SPYCollectionController.git', :tag => "v#{spec.version}"}
  spec.license = { :type => 'MIT', :file => 'LICENSE' }

  spec.platform = :ios
  spec.requires_arc = true
  spec.frameworks = 'UIKit', 'Foundation'
  spec.source_files = 'SPYCollectionController/'
end
