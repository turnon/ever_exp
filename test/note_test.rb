require 'test_helper'
require 'ever_exp/note'
require 'ever_exp/html'
require 'ever_exp/files'

class NoteTest < Minitest::Test
  def test_add
    note = EverExp::Note.new
    html_rel_path = '../test_notes/Elixir is a dynamic, functional language desi.html'
    html = EverExp::Html.new File.expand_path(html_rel_path, __FILE__)
    files_rel_path = '../test_notes/Elixir is a dynamic, functional language desi_files'
    files = EverExp::Files.new File.expand_path(files_rel_path, __FILE__)
    note << html
    note << files
    assert_equal html, note.html
    assert_equal files, note.files
  end
end
