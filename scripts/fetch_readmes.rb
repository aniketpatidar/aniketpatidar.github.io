#!/usr/bin/env ruby
require 'net/http'
require 'uri'
require_relative 'lib/project_file'
require_relative 'lib/readme_transformer'

Dir.glob('_projects/*.md').each do |filepath|
  begin
    project = ProjectFile.new(filepath)
  rescue => e
    puts "Skipping #{filepath}: Error parsing front matter - #{e.message}"
    next
  end

  unless project.fetch_readme?
    puts "Skipping #{filepath} (fetch_readme: false)"
    next
  end

  owner = project.owner
  repo = project.repo
  branch = project.branch

  if owner && repo
    url = URI("https://raw.githubusercontent.com/#{owner}/#{repo}/#{branch}/README.md")
    puts "Fetching README for #{filepath} from #{url}..."

    response = Net::HTTP.get_response(url)

    if response.is_a?(Net::HTTPSuccess)
      base_url = "https://raw.githubusercontent.com/#{owner}/#{repo}/#{branch}/"
      transformed_readme = ReadmeTransformer.transform(response.body, base_url)

      marker = "<!-- README_START -->"
      body = project.body

      if body.include?(marker)
        new_body = body.split(marker).first + marker + "\n\n" + transformed_readme
      else
        new_body = body.strip + "\n\n" + marker + "\n\n" + transformed_readme
      end

      project.save(new_body)
      puts "Updated #{filepath}"
    else
      puts "Failed to fetch README for #{filepath}: #{response.code}"
    end
  end
end
