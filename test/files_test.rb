require 'test_helper'
require 'ever_exp/files'

class FilesTest < Minitest::Test
  def test_files
    rel_path = '../test_notes/Elixir is a dynamic, functional language desi_files'
    files = EverExp::Files.new File.expand_path(rel_path, __FILE__)
    assert_equal 1, files.count
    assert files.find{|f| f.name == 'Image.png'}
  end
end
