module EverExp
  class Html
    class Heading
      def initialize
        @h = Title.new '999', 'heading'
      end

      def add level, title
        subtitle = Title.new level, title
        last_st = h.last_subtitle
        title = h
        while true do
          if last_st.nil? or last_st.level == subtitle.level
            title.add_sub subtitle
            return
          end
          title = last_st
          last_st = last_st.last_subtitle
        end
      end

      def to_h
        h.subtitles.map(&:to_h)
      end

      class Title

        attr_reader :level, :title, :subtitles
        attr_accessor :parent_title

        def initialize lvl, ti
          @level = lvl
          @title = ti
          @subtitles = []
        end

        def last_subtitle
          subtitles.last
        end

        def add_sub node
          node.parent_title = self
          subtitles << node
        end

        def add_sib node
          parent_title.add_sub node
        end

        def to_h
          return title if subtitles.empty?
          {title => subtitles.map(&:to_h)}
        end

      end

      private

      def h
        @h
      end

    end
  end
end
