require 'ffi'

module Win32
  module Glass
    GlassColor = Struct.new(:color, :opaque)
    extend FFI::Library

    class Color < FFI::Struct
      layout :color, :uint
    end
    class Opaque < FFI::Struct
      layout :opaque, :bool
    end

    ffi_lib 'dwmapi'
    attach_function(
                    :glass_color,
                    :DwmGetColorizationColor,
                    [:pointer, :pointer],
                    :int
                  )

    def self.glass
      color  = Color.new
      opaque = Opaque.new
      self.glass_color(color, opaque)

      struct = GlassColor.new(color[:color], opaque[:opaque])

      return struct
    end
  end
end