#The GemSpec to build the gem
Gem::Specification.new do |s|
  s.name = 'jambase4r'
  s.version = '1.0.0'
  s.date = "2009-04-14"
  s.summary = "Ruby JamBase API library."
  s.description = %{A Ruby library use to access the JamBase API.}
  s.has_rdoc = false
  s.author = "Matt Payne"
  s.email = "matt@mattpayne.ca"
  s.homepage = "http://mattpayne.ca"
  s.files = [
    'README', 'Rakefile', 'jambase4r.gemspec', 'jambase4r.rb', 'lib/extensions.rb', 'lib/errors.rb',
    'lib/http_gateway.rb', 'lib/jambase4r_view_helper.rb', 'lib/models/model.rb', 'lib/models/artist.rb',
    'lib/models/venue.rb', 'lib/models/event.rb'
  ]
  s.test_files = [
    'spec/spec_helper.rb', 'spec/lib/api_spec.rb', 'spec/lib/http_gateway_spec.rb',
    'spec/lib/jambase4r_view_helper_spec.rb', 'spec/lib/jambase4r_spec.rb', 'spec/lib/models/artist_spec.rb',
    'spec/lib/models/event_spec.rb', 'spec/lib/models/venue_spec.rb', "spec/lib/models/model_spec.rb"
  ]
end