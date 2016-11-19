require 'nokogiri'
require 'ever_exp/heading'
require 'ever_exp/nokogiri_xml_element'

module EverExp
  class Html

    attr_reader :html, :location
    attr_writer :note

    def initialize path
      @html = File.open(path) { |f| Nokogiri::HTML(f) }
      @location = path
    end

    def name
      File.basename(location).gsub(/\.html$/, '')
    end

    def isHtml?
      true
    end

    def title
      @title ||= html.title
    end

    def tags
      parse_meta
      @tags
    end

    def created
      parse_meta
      @created
    end

    def updated
      parse_meta
      @updated
    end

    def code_blocks
      html.
        css('div').
        select { |div| div.attr('style') =~ /^-en-codeblock/ }
    end

    def imgs
      html.css('img')
    end

    def content
      _content.to_html
    end

    def heading?
      not heading.empty?
    end

    def heading
      return @heading if @heading
      h = Heading.new
      heading_elements.each do |b|
        level, title = level_title b
        h.add level, title
      end
      @heading = h.to_h
    end

    def heading_elements
      _content.css('div > b, div > span > b')
    end

    private

    def level_title bold_tag
      level = (bold_tag.parent.name == 'span' ? bold_tag.parent.attr('style').gsub(/[^\d]/, '') : '1')
      title = bold_tag.text
      [level, title]
    end

    def _content
      html.css('body > div').last
    end

    def parse_meta
      return if @parsed_meta
      metas = meta.css('tr')
      raise IOError, 'meta is broken' if metas.size < 2
      @created = parse_date meta_value metas[0]
      @updated = parse_date meta_value metas[1]
      @tags = meta_value metas[2]
      @parsed_meta = true
    end

    def meta
      @meta ||= html.at_css 'table'
    end

    def meta_value tr
      tr.css('td').last.at_css('i').text
    end

    def parse_date date
      date_arr = date.split(/\s+/)
      ymd, hmin = date_arr.first, date_arr.last
      y, m, d = ymd.split('/')
      h, min = hmin.split(':')
      Time.new y, m, d, h, min
    end
  end
end
