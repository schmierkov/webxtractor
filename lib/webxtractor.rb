require 'ostruct'
require 'nokogiri'

class Webxtractor
  def self.get(url=nil)
    return unless url
    uri = URI.parse(url)
    parse(uri.read)
  end

  def self.parse(body)
    page = Nokogiri::HTML(body)
    result = OpenStruct.new
    result.title = get_tag('title', page)
    result.h1 = get_tag('h1', page)
    result
  end

  def self.get_tag(selector, page)
    element = page.css(selector)
    if element.size > 1
      element.map {|x| normalize(x.text) }
    else
      normalize(element.text)
    end
  end

  def self.normalize(content='')
    return if content.nil?
    content.gsub(/(\r\n|\n|\r)/," ")
    content.gsub(/\s+/, " ").strip
  end
end
