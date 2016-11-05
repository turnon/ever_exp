require 'ever_exp/html'
require 'ever_exp/files'
require 'ever_exp/note'
require 'delegate'

module EverExp
  class Notes < DelegateClass(Array)
    def initialize dir
      group_into_notes files_in dir
      super notes_hash.values
      remove_instance_variable :@notes_hash
    end

    private

    def files_in dir
      wildcast = File.join dir, '*'
      Dir[wildcast]
    end

    def group_into_notes files
      files.each do |file|
        html_or_files = classify file
        note = notes_hash[html_or_files.name]
        note << html_or_files
      end
    end

    def classify file
      klass = File.extname(file) == '.html' ? EverExp::Html : EverExp::Files
      klass.new file
    end

    def notes_hash
      @notes_hash ||= Hash.new { |hash, name| hash[name] = EverExp::Note.new }
    end

  end
end
