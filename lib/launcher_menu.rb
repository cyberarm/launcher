class Launcher
  class LauncherMenu < CyberarmEngine::GuiState
    def setup
      if RUBY_PLATFORM.match?(/mingw|mswin|cygwin/)
        background Win32::Glass.glass.color
      else
        background 0xff222222
      end

      flow do
        label "Launcher", text_size: 56, color: 0xff888888
      end

      stack do
        background Gosu::Color::RED
        label ".", text_size: 150
      end
      flow do
        @action_button = button("Play") { launch_application }
        @action_button.hide
        button("Quit") { close_launcher }
      end

      @status = label "Ready!", text_size: 18, color: Gosu::Color::GRAY
    end

    def launch_application
      @status.value = "Launching app..."

      close_launcher
      system("ruby ../citysim/city_sim.rb")
    end

    def check_for_updates
      @status.value = "Checking for updates..."
    end

    def close_launcher
      @status.value = "Stopping..."
      window.close
    end
  end
end