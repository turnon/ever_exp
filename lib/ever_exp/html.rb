require 'nokogiri'

module EverExp
  class Html

    attr_reader :html, :location

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
      html.css('body > div').last.to_html
    end

    private

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
