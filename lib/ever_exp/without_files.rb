module EverExp
  class WithoutFiles

    include Enumerable

    class << self
      private :new

      def instance
        @single ||= new
      end
    end

    def name
      'without_files'
    end

    def each &block
      [].each &block
    end

    def isHtml?
      false
    end

  end
end
