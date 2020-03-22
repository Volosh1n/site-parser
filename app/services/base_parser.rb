class BaseParser
  def initialize(link)
    @link = link
  end

  def call
    raise NotImplementedError
  end

  private

  attr_reader :link

  def doc
    @doc ||= Nokogiri::HTML(open(link))
  end
end
