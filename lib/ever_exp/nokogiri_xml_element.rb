class Nokogiri::XML::Element

  def plain_code
    raise NoMethodError, "#{self} is not a code block" unless self['style'] =~ /^-en-codeblock/
    css('div').
      map{ |line| _plain_code line }.
      join("\n")
  end

  private

  def _plain_code line
    innerHtml = line.inner_html
    no_nbsp = innerHtml.gsub("\u00A0", ' ')
    no_escape = CGI.unescapeHTML no_nbsp
    br_as_blank_line = (no_escape == '<br>' ? '' : no_escape)
  end
end
