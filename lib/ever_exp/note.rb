require 'ever_exp/without_files'

module EverExp
  class Note

    attr_reader :html

    def title
      html.title
    end

    def files
      @files || EverExp::WithoutFiles.instance
    end

    def <<(html_or_files)
      if html_or_files.isHtml?
        @html = html_or_files
      else
        @files = html_or_files
      end
      html_or_files.note = self
    end
  end
end
