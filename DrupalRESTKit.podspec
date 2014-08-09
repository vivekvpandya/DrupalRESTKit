Pod::Spec.new do |s|

	s.name		= 'DrupalRESTKit'
	s.version	= '0.0.1'
	s.summary 	= 'A iOS library to simplify RESTFul operation from iOS devices to Drupal.'
	s.homepage	= 'https://github.com/vivekvpandya/DrupalRESTKit'
	s.license 	= {
		:type => 'MIT',
		:file => 'LICENSE'
	
	}
	s.author	= {
		'vivek pandya' => 'vivekvpandya@gmail.com'
	}
	s.source	= {
		:git => 'https://github.com/vivekvpandya/DrupalRESTKit.git',
		:tag => s.version.to_s
	}
	s.source_files	= 'DrupalRESTKit/SDK/*.{m,h}’
	s.requires_arc	= true
	s.dependency  'AFNetworking'
end