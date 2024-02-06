# frozen_string_literal: true

module ColorValidatable
  extend ActiveSupport::Concern

  included do
    validates :color, presence: true
    validate :valid_color

    def valid_color
      return if color.blank?

      unless valid_color_name? || valid_hex_color?
        errors.add(:color, "must be a valid color name or a valid hex RGB color code")
      end
    end

    def valid_color_name?
      valid_color_names.include?(color.downcase)
    end

    def valid_hex_color?
      /^#?(?:[A-F0-9]{3}){1,2}$/i.match?(color)
    end

    def valid_color_names
      %w(
        aliceblue antiquewhite aqua aquamarine azure beige bisque black blanchedalmond blue blueviolet
        brown burlywood cadetblue chartreuse chocolate coral cornflowerblue cornsilk crimson cyan
        darkblue darkcyan darkgoldenrod darkgray darkgreen darkgrey darkkhaki darkmagenta darkolivegreen
        darkorange darkorchid darkred darksalmon darkseagreen darkslateblue darkslategray darkslategrey
        darkturquoise darkviolet deeppink deepskyblue dimgray dimgrey dodgerblue firebrick floralwhite
        forestgreen fuchsia gainsboro ghostwhite gold goldenrod gray green greenyellow grey honeydew
        hotpink indianred indigo ivory khaki lavender lavenderblush lawngreen lemonchiffon lightblue
        lightcoral lightcyan lightgoldenrodyellow lightgray lightgreen lightgrey lightpink lightsalmon
        lightseagreen lightskyblue lightslategray lightslategrey lightsteelblue lightyellow lime limegreen
        linen magenta maroon mediumaquamarine mediumblue mediumorchid mediumpurple mediumseagreen
        mediumslateblue mediumspringgreen mediumturquoise mediumvioletred midnightblue mintcream
        mistyrose moccasin navajowhite navy oldlace olive olivedrab orange orangered orchid
        palegoldenrod palegreen paleturquoise palevioletred papayawhip peachpuff peru pink plum
        powderblue purple red rosybrown royalblue saddlebrown salmon sandybrown seagreen seashell
        sienna silver skyblue slateblue slategray slategrey snow springgreen steelblue tan teal thistle
        tomato turquoise violet wheat white whitesmoke yellow yellowgreen
      )
    end
  end
end
