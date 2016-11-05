module EverExp
  class Files

    include Enumerable

    def initialize path
      @path = path
    end

    def name
      File.basename(@path).gsub(/_files$/, '')
    end

    def each &block
      _files.each &block
    end

    def isHtml?
      false
    end

    private

    def _files
      @files ||= Dir.new(@path).
        reject { |name| name == '.' or name == '..' }.
        map { |basename| FileInFiles.new File.join(@path, basename) }
    end

    class FileInFiles

      attr_reader :location

      def initialize path
        @location = path
      end

      def name
        File.basename location
      end
    end

  end
end
