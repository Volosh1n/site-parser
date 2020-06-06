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
end
