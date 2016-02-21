require 'ostruct'
require 'nokogiri'
require 'open-uri'

class Webxtractor
  def self.get(url=nil)
    return unless url
    uri = URI.parse(url)
    parse(uri.read)
  end

  def self.parse(body)
    page = Nokogiri::HTML(body)
    result = OpenStruct.new
    result.title = get_tag(page, 'title')
    result.meta_description = get_tag(page,
                                      'meta[name=description]',
                                      attribute: "content")
    result.meta_keywords = get_tag(page,
                                   'meta[name=keywords]',
                                   attribute: "content")
    result.h1 = get_tag(page, 'h1')
    result
  end

  def self.get_tag(page, selector, attribute: nil)
    elements = page.css(selector)
    if elements.size > 1
      elements.map {|element| get_content(element, attribute) }
    else
      get_content(elements.first, attribute)
    end
  end

  def self.normalize(text=nil)
    return if text.nil?
    text.gsub(/(\r\n|\n|\r)/," ")
    text.gsub(/\s+/, " ").strip
  end

  def self.get_content(element, attribute)
    return if element.nil?
    text = if element.attributes[attribute].respond_to?(:value)
      element.attributes[attribute].value
    else
      element.text
    end
    normalize(text)
  end
end
