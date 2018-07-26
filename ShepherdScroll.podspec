Pod::Spec.new do |s|

# 1
s.platform = :ios
s.ios.deployment_target = '8.0'
s.name = "ShepherdScroll"
s.summary = "ShepherdScroll implements a custom Scroll View which provides easy handling of animation over child view controllers during the scroll."
s.requires_arc = true

# 2
s.version = "0.0.1"

# 3
#s.license = { :type => "MIT", :file => "LICENSE" }

# 4 - Replace with your name and e-mail address
s.author = { "Victor Panitz Magalhães" => "victorpanitz@gmail.com" }

# 5
s.homepage = "https://bitbucket.org/victorpanitz/shepherdscroll/"

# 6
s.source = { :git => "https://victorpanitz@bitbucket.org/victorpanitz/shepherdscroll.git", :tag => "#{s.version}" }

# 7
s.framework = "UIKit"

# 8
s.source_files = "ShepherdScroll/**/*.{swift}"

end
