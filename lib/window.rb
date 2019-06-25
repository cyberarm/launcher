class Launcher
  class Window < CyberarmEngine::Engine
    def initalize
      super(width: 800, height: 600, fullscreen: false)
    end

    def setup
      self.caption = "Launcher"

      push_state(LauncherMenu)
    end

    def needs_cursor?
      true
    end
  end
end