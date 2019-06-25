begin
  require_relative "../cyberarm_engine/lib/cyberarm_engine"
rescue LoadError
  require "cyberarm_engine"
end

require_relative "lib/window"
require_relative "lib/launcher_menu"

if RUBY_PLATFORM.match?(/mingw|mswin|cygwin/)
  require_relative "lib/win32/glass"
end

Launcher::Window.new.show