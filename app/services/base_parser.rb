class BaseParser
  def self.call(*args)
    new(*args)
  end

  private

  attr_reader :link

  def initialize(link)
    @link = link
  end

  def doc
    @doc ||= Nokogiri::HTML(open(link))
  end
end
