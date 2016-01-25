require 'ostruct'

class Webxtractor

  def self.parse(body, tag_name='title')
    result = OpenStruct.new
    result.title = get_tag(:title, body)
    result.h1 = get_tag(:h1, body)
    result
  end

  private

  def self.get_tag(tag_name=:title, body)
    result = normalize(body)
    result = result.match(/<\s?#{tag_name}.*>(.*)<\/\s?#{tag_name}.*>/).to_a
    result = result.reject { |x| x[0] == "<" }.join(" ")
    result
  end

  def self.normalize(content='')
    return if content.nil?
    content.gsub(/(\r\n|\n|\r)/," ")
    content.gsub(/\s+/, " ").strip
  end
end
