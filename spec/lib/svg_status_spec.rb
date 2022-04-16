require 'spec_helper'

describe SVGStatus do
  let(:svg) { SVGStatus.new('127.0.0.1') }
  context '#to_svg' do
    subject { svg.to_svg }
    it "returns rendered SVG" do
      expect(subject).to eq(<<~SVG)
        <svg height="20" width="86" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink">
          <linearGradient id="a" x2="0" y2="100%">
            <stop offset="0" stop-color="#bbb" stop-opacity=".1"/>
            <stop offset="1" stop-opacity=".1"/>
          </linearGradient>
          <clipPath id="b">
            <rect height="20" rx="3" width="86"/>
          </clipPath>
          <g clip-path="url(#b)">
            <path d="m0 0h64v20h-64z" fill="#555"/>
            <path d="m64 0h22v20h-22z" fill="#007ec6"/>
            <path d="m0 0h86v20h-86z" fill="url(#a)"/>
          </g>
          <g fill="#fff" font-family="Verdana,Geneva,DejaVu Sans,sans-serif" font-size="110" text-anchor="middle" text-rendering="geometricPrecision" transform="scale(.1)">
            <text fill="#010101" fill-opacity=".3" textLength="540" x="320" y="150">127.0.0.1</text>
            <text fill="#fff" textLength="540" x="320" y="140">127.0.0.1</text>
            <text fill="#010101" fill-opacity=".3" textLength="120" x="750" y="150">IP</text>
            <text fill="#fff" textLength="120" x="750" y="140">IP</text>
          </g>
        </svg>
      SVG
    end
  end
end
