Pod::Spec.new do |s|
  s.name             = 'LightningKit.swift'
  s.module_name      = 'LightningKit'
  s.version          = '0.1'
  s.summary          = 'Kit provides functionality to interact with Bitcoin Lightning network.'

  s.homepage         = 'https://github.com/horizontalsystems/lightning-kit-ios'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Horizontal Systems' => 'hsdao@protonmail.ch' }
  s.source           = { git: 'https://github.com/horizontalsystems/lightning-kit-ios.git', tag: "#{s.version}" }
  s.social_media_url = 'http://horizontalsystems.io/'

  s.ios.deployment_target = '11.0'
  s.swift_version = '5'

  s.source_files = 'LightningKit/Classes/**/*'

  s.requires_arc = true
end
