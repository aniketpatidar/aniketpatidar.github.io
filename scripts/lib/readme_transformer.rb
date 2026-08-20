require 'kramdown'
require 'kramdown-parser-gfm'
require 'nokogiri'
require 'uri'

module ReadmeTransformer
  def self.transform(readme, base_url)
    html = Kramdown::Document.new(readme, input: 'GFM').to_html
    
    doc = Nokogiri::HTML::DocumentFragment.parse(html)
    
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
end
