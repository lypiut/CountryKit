Pod::Spec.new do |s|
  s.name         = "CountryKit"
  s.version      = "1.0.0"
  s.summary      = "An easy way to get countries informations with their flags"
  s.homepage     = "https://github.com/lypiut/CountryKit"
  s.license      = "MIT"
  s.author    = {"Romain Rivollier" => "romain.rivollier@gmail.com"}
  s.social_media_url   = "http://twitter.com/Lypiut"
  s.source       = { :git => "https://github.com/lypiut/CountryKit.git", :tag => s.version }
  
  s.source_files  = "Source/*.swift"

  s.ios.deployment_target = '8.0'

  s.requires_arc = true
end
