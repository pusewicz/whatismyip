class SVGStatus
  WIDTH_PER_CHAR = 6
  PADDING = 5

  def initialize(text)
    @text = text
    @ip_width = text_width('IP') + 2 * PADDING
    @address_width = text_width(text) + 2 * PADDING
    @width = (@ip_width + @address_width).round
  end

  def to_svg
    <<~SVG
      <svg height="20" width="#{@width}" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink">
        <linearGradient id="a" x2="0" y2="100%">
          <stop offset="0" stop-color="#bbb" stop-opacity=".1"/>
          <stop offset="1" stop-opacity=".1"/>
        </linearGradient>
        <clipPath id="b">
          <rect height="20" rx="3" width="#{@width}"/>
        </clipPath>
        <g clip-path="url(#b)">
          <path d="m0 0h#{@address_width}v20h-#{@address_width}z" fill="#555"/>
          <path d="m#{@address_width} 0h#{@ip_width}v20h-#{@ip_width}z" fill="#007ec6"/>
          <path d="m0 0h#{@width}v20h-#{@width}z" fill="url(#a)"/>
        </g>
        <g fill="#fff" font-family="Verdana,Geneva,DejaVu Sans,sans-serif" font-size="110" text-anchor="middle" text-rendering="geometricPrecision" transform="scale(.1)">
          <text fill="#010101" fill-opacity=".3" textLength="#{(@address_width - 2 * PADDING) * 10}" x="#{@address_width / 2 * 10}" y="150">#{@text}</text>
          <text fill="#fff" textLength="#{(@address_width - 2 * PADDING) * 10}" x="#{@address_width / 2 * 10}" y="140">#{@text}</text>
          <text fill="#010101" fill-opacity=".3" textLength="#{(@ip_width - 2 * PADDING) * 10}" x="#{(@width - (@ip_width / 2)) * 10}" y="150">IP</text>
          <text fill="#fff" textLength="#{(@ip_width - 2 * PADDING) * 10}" x="#{(@width - (@ip_width / 2)) * 10}" y="140">IP</text>
        </g>
      </svg>
    SVG
  end

  def text_width(text)
    text.chars.size * WIDTH_PER_CHAR
  end
end
