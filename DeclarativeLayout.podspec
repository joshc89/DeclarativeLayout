Pod::Spec.new do |s|
  s.name             = "DeclarativeLayout"
  s.version          = "1.0"
  s.summary          = "Reusable, composable, declarative constraint based layout in Swift."
  s.description      = <<-DESC

A `Layout` combines one or more views, layout guides and constraints into a single object, including logic, that can be reused and composed of other `Layout`s. 

Encapsultaing this behaviour in a single object rather than in a view controller makes it easier to reuse and update. It also makes it easier to focus on just the code regarding layout, rather than that code being lost in delegate callbacks on parent view controllers.

More example `Layout`s are given within the framework. Download the repo to check them out.

                        DESC
  s.homepage         = "https://github.com/joshc89/DeclarativeLayout"
  s.license          = 'MIT'
  s.author           = { "Josh Campion" => "joshcampion89@gmail.com" }
  s.source           = { :git => "https://github.com/joshc89/DeclarativeLayout.git", :tag => s.version.to_s }

  s.requires_arc          = true

  s.ios.deployment_target = '9.0'

  s.source_files          = 'DeclarativeLayout/**/*.swift'
end
