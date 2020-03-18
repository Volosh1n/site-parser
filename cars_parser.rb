class CarsParser
  def initialize(link)
    @link = link
  end

  def call
    doc.css('p.result-info').map do |node|
      {
        label: get_children_text(node, 'a.hdrlnk'),
        price: get_children_text(node, 'span.result-price'),
        link: get_children_link(node, 'a.hdrlnk')
      }
    end
  end

  private

  attr_reader :link

  def doc
    @doc ||= Nokogiri::HTML(open(link))
  end

  def initilize_document(link)
    Nokogiri::HTML(open(link))
  end

  def get_children_text(node, selector)
    node.elements.css(selector).first.text
  end

  def get_children_link(node, selector)
    node.elements.css(selector).first.attributes['href'].value
  end
end
