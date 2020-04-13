
Pod::Spec.new do |spec|


  spec.name         = "cmyProjectFramePodTest"
  spec.version      = "0.0.1"
  spec.summary      = "Test cocoaPod auto cmyProjectFramePodTest."

 
  spec.description  = <<-DESC
Test cocoaPod auto cmyProjectFramePodTest. From Helloword,if success, it will be delete
                   DESC

  spec.homepage     = "https://github.com/ChenMengYue/HelloWorld"


  spec.license      = { :type => "MIT", :file => "FILE_LICENSE" }


  spec.author             = { "cmy" => "lygchenmy@outlook.com" }


   spec.ios.deployment_target = "8.0"


  # spec.source       = { :git => "https://github.com/ChenMengYue/HelloWorld.git", :tag => "#{spec.version}" }

  spec.source       = { :git => "https://github.com/ChenMengYue/HelloWorld.git", :tag => spec.name.to_s+"v"+spec.version.to_s }


  spec.source_files  = "Classes", "Classes/**/*.{h,m}"
  spec.exclude_files = "Classes/Exclude"

  # spec.public_header_files = "Classes/**/*.h"


  # ――― Resources ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #

  # spec.resource  = "icon.png"
  # spec.resources = "Resources/*.png"
    spec.resources = "CommonProjectMethod/ImageResource.bundle"


   spec.framework  = "CoreGraphic"

   spec.requires_arc = true

   spec.xcconfig = { "HEADER_SEARCH_PATHS" => "$(SDKROOT)/usr/include/libxml2" }
   spec.dependency "AFNetworking"
   spec.dependency "MBProgressHUD", "~> 1.1.0"
   spec.dependency "Masonry", "~> 1.1.0"
   spec.dependency "MJRefresh"



end
