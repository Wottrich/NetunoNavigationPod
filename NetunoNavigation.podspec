

Pod::Spec.new do |spec|

  # ―――  Spec Metadata  ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #


  spec.name         = "NetunoNavigation"
  spec.version      = "0.0.1"
  spec.summary      = "Navigate as a God"

  # ―――  Description  ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #

  spec.description  = <<-DESC
A POD to make easily how to navigate on iOS
                   DESC

  # ―――  HomePage  ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #

  spec.homepage     = "https://github.com/Wottrich/NetunoNavigationPod"


  # ―――  Spec License  ――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #

  spec.license      = { :type => "MIT", :file => "LICENSE" }


  # ――― Author Metadata  ――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #

  spec.author             = { "wottrich" => "wottrich78@gmail.com" }
  spec.social_media_url   = "https://twitter.com/wottrichlucas"


  # ――― Platform Specifics ――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  

  spec.ios.deployment_target = "12.2"
  spec.swift_version = "5.0"


  # ――― Source Location ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #

  spec.source       = { :git => "https://github.com/Wottrich/NetunoNavigationPod.git", :tag => "#{spec.version}" }
  

  # ――― Source Code ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #

#  spec.source           = { :path => '.' }
  spec.source_files  = "Navigator/**/*.{h,m, swift}"
  spec.exclude_files = "Navigator/Exclude"

end
