

Pod::Spec.new do |spec|

  # ―――  Spec Metadata  ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #


  spec.name         = "NetunoNavigation"
  spec.version      = "1.0.0"
  spec.summary      = "Navigate like a God"

  # ―――  Description  ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #

  spec.description  = <<-DESC
NetunoNavigation is a pod to iOS to take navigation to the next level on the platform.
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
  spec.source_files  = "NetunoNavigation/**/*.{h,m,swift}"
  spec.exclude_files = "NetunoNavigation/Exclude"

end
