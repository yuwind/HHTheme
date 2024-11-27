
Pod::Spec.new do |s|
  s.name         = 'HHTheme' 
  s.version      = '1.1.0'
  s.summary      = 'HHTheme'
  s.description  = 'Automatically manage theme'
  s.homepage     = 'https://github.com/yuwind/HHTheme/wiki'
  s.license      = 'MIT'
  s.author       = { 'yufeng' => '991810133@qq.com' }
  s.platform     = :ios, '12.0'
  s.source       = { :git => "https://github.com/yuwind/HHTheme.git", :tag => s.version}
  s.source_files = 'HHTheme/*.{h,m}'
  s.requires_arc = true

end
