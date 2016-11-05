require 'test_helper'
require 'ever_exp/notes'

class NotesTest < Minitest::Test
  def test_new
    notes = EverExp::Notes.new File.expand_path('../test_notes', __FILE__)
    assert_equal 3, notes.count
    grape_files = notes.find{ |n| n.title == 'What is Grape?' }.files
    assert_equal 0, grape_files.count
  end
end
