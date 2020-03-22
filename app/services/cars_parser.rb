class CarsParser < BaseParser
  def call
    doc.css('p.result-info').map do |node|
      {
        label: first_child_text(node, 'a.hdrlnk'),
        price: first_child_text(node, 'span.result-price'),
        link: first_child_link(node, 'a.hdrlnk')
      }
    end
  end

  private

  def first_child(node, selector)
    node.elements.css(selector).first
  end

  def first_child_text(node, selector)
    first_child(node, selector).text
  end

  def first_child_link(node, selector)
    first_child(node, selector).attributes['href'].value
  end
end
