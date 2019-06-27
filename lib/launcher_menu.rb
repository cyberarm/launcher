class Launcher
  class LauncherMenu < CyberarmEngine::GuiState
    def setup
      @_height = 384

      if RUBY_PLATFORM.match?(/mingw|mswin|cygwin/)
        background Win32::Glass.glass.color
      else
        background 0xff222222
      end

      flow(width: 1.0) do
        label "Launcher", text_size: 56, color: 0xff888888
        button("Settings", align: :right)
      end

      stack(width: 1.0, height: 0.76, padding: 10) do
        flow(width: 1.0) do
          @launch_button = button("Launch", width: 0.45, height: @_height, margin_right: 5) do
            launch_application
          end

          @update_button = button("Check for Updates", width: 0.45, height: @_height) do
            check_for_updates
          end
        end

        @progress = progress fraction: 0.0, margin_top: 15, width: 1.0
      end

      flow(margin: 5) do
        button("Close") { close_launcher }
        label "Status: "
        @status = label "Ready!", color: Gosu::Color::GRAY
      end
    end

    def update
      super

      _progress = @progress.value
      @progress.value = @progress.value + 0.0001
      @status.value = "Downloading #{(@progress.value * 100).round}%" if @progress.value != _progress
    end

    def launch_application
      @status.value = "Launching app..."

      close_launcher
      system("ruby ../citysim/city_sim.rb")
    end

    def check_for_updates
      @progress.value = 0
      @status.value = "Checking for updates..."
    end

    def close_launcher
      @status.value = "Stopping..."
      window.close
    end
  end
end