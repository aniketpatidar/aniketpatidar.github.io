require 'front_matter_parser'
require 'yaml'

class ProjectFile
  attr_reader :filepath, :frontmatter, :body

  def initialize(filepath)
    @filepath = filepath
    parsed = FrontMatterParser::Parser.parse_file(filepath)
    @frontmatter = parsed.front_matter
    @body = parsed.content
  end

  def fetch_readme?
    @frontmatter['fetch_readme'] != false
  end

  def owner
    @frontmatter['owner']
  end

  def repo
    @frontmatter['repo']
  end

  def branch
    @frontmatter['branch'] || 'main'
  end

  def save(new_body)
    yaml_header = YAML.dump(@frontmatter)
    
    yaml_header = "---\n" + yaml_header unless yaml_header.start_with?("---")
    
    yaml_header += "---\n" unless yaml_header.end_with?("---\n")

    File.write(@filepath, yaml_header + "\n" + new_body)
  end
end
