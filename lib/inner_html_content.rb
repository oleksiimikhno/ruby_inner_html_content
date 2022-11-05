# frozen_string_literal: true

require 'erb'
# Gem append content in html body
module InnerHTMLContent
  class << self
    def add_content(title, content, bypass_html: true, file_name: 'index.html')
      @title = title
      @content = content

      serialize_content = @content.gsub(%r{<\w+>|</\w+>}, '')
      @content = bypass_html && serialize_content ? @content.gsub(%r{<\w+>|</\w+>}, '') : @content

      create_html(file_name)
    end

    private

    def template
      '<!DOCTYPE html>
      <html lang="en">
      <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title><%= @title %></title>
        <link rel="stylesheet" href="view/style/default.css" />
      </head>
      <body>
      <%= @content %>
      </body>
      </html>'.gsub(/^      /, '')
    end

    def create_html(file_name)
      result = ERB.new(template).result(binding)

      File.write(file_name, result)
      result
    end
  end
end
