require 'test_helper'
require 'ever_exp/html'

class HtmlTest < Minitest::Test

  attr_reader :html

  def setup
    rel_path = '../test_notes/Elixir is a dynamic, functional language desi.html'
    @html = EverExp::Html.new File.expand_path(rel_path, __FILE__)
  end

  def test_title
    assert_equal 'Elixir is a dynamic, functional language designed for building scalable and maintainable applications', html.title
  end

  def test_created
    expect_time = Time.new 2016, 11, 2, 21, 22
    assert_equal expect_time, html.created
  end

  def test_updated
    expect_time = Time.new 2016, 11, 2, 22, 21
    assert_equal expect_time, html.updated
  end

  def test_tags
    assert_equal 'elixir, functional', html.tags
  end

  def test_name
    assert_equal 'Elixir is a dynamic, functional language desi', html.name
  end

  def test_code_blocks
    code_blocks = html.code_blocks
    assert_equal 8, code_blocks.count
  end

  def test_imgs
    imgs = html.imgs
    assert_equal 1, imgs.count
    assert_equal 'Elixir is a dynamic, functional language desi_files/Image.png', imgs[0].attr('src')
  end

  def test_content
    assert_match /^<div>\n<span><div>Elixir is a dynamic/, html.content
    assert_match /for Erlang developers<\/a>\.<\/div>\n<div><br><\/div><\/span>\n<\/div>$/, html.content
  end

  def test_heading
    expected_heading = [
      {'Platform features' => ['Scalability', 'Fault-tolerance']},
      {'Language features' => ['Functional programming', 'Extensibility and DSLs']},
      {'Tooling features' => ['A growing ecosystem', 'Interactive development', 'Erlang compatible']}
    ]
    assert_equal expected_heading, html.heading
  end

end
