require 'kramdown'
require 'kramdown-parser-gfm'
require 'nokogiri'
require 'uri'

module ReadmeTransformer
  def self.transform(readme, base_url)
    html = Kramdown::Document.new(readme, input: 'GFM').to_html
    
    doc = Nokogiri::HTML::DocumentFragment.parse(html)

    remove_leading_title(doc)
    convert_alerts(doc)
    
    doc.css('img').each do |img|
      src = img['src']
      if src && !src.start_with?('http', 'data:')
        begin
          uri = URI.parse(src)
          if uri.relative?
            img['src'] = base_url + src.sub(/^\.\//, '')
          end
        rescue URI::InvalidURIError
        end
      end
    end
    
    doc.css('a').each do |a|
      href = a['href']
      if href && !href.start_with?('http', '#', 'mailto:')
        begin
          uri = URI.parse(href)
          if uri.relative?
            a['href'] = base_url + href.sub(/^\.\//, '')
          end
        rescue URI::InvalidURIError
        end
      end
    end
    
    doc.to_html
  end

  # The project page already shows the title, so drop the README's own.
  def self.remove_leading_title(doc)
    first = doc.children.find { |node| node.element? }
    first.remove if first&.name == 'h1'
  end

  ALERT_TITLES = {
    'NOTE' => 'Note', 'TIP' => 'Tip', 'IMPORTANT' => 'Important',
    'WARNING' => 'Warning', 'CAUTION' => 'Caution'
  }.freeze

  # Kramdown renders GitHub's "> [!NOTE]" alerts as plain quotes with the
  # marker as text. Turn them into labelled callouts.
  def self.convert_alerts(doc)
    doc.css('blockquote').each do |quote|
      paragraph = quote.at_css('p')
      marker = paragraph&.children&.first
      next unless marker&.text? && (match = marker.content.match(/\A\s*\[!(#{ALERT_TITLES.keys.join('|')})\]\s*/))

      type = match[1]
      marker.content = marker.content.sub(match[0], '')
      line_break = paragraph.children.first
      line_break = line_break.next_sibling if line_break&.text? && line_break.content.strip.empty?
      line_break.remove if line_break&.name == 'br'

      quote['class'] = "readme-alert readme-alert-#{type.downcase}"
      title = Nokogiri::XML::Node.new('p', doc.document)
      title['class'] = 'readme-alert-title'
      title.content = ALERT_TITLES[type]
      quote.prepend_child(title)
    end
  end
end
