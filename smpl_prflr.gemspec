require 'English'
Gem::Specification.new do |s|
  s.specification_version = 2 if s.respond_to? :specification_version=
  if s.respond_to? :required_rubygems_version=
    s.required_rubygems_version = Gem::Requirement.new('>= 0')
  end
  s.rubygems_version = '2.7'
  s.required_ruby_version = '>=2.2'
  s.name = 'smpl_prflr'
  s.version = '0.0.4'
  s.executables << 'smpl_prflr'
  s.license = 'MIT'
  s.summary = 'Profiler'
  s.description = 'SmplPrflr for profiler own code.'
  s.authors = ['Ilya Kondratev']
  s.email = 'ilyafulleveline@gmail.com'
  s.homepage = 'https://github.com/ikondratev/smpl_prflr'
  s.files = `git ls-files`.split($RS)
  s.add_dependency 'rubocop', '~> 1.26'
  s.add_dependency 'rubocop-rake'
  s.add_dependency 'ruby-prof', '~> 1.4', '>= 1.4.3'
  s.add_dependency 'redis', '~> 4.6'
  s.add_dependency 'rack', '~> 2.2'
end