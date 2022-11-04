# frozen_string_literal: true

require 'erb'

template = %{
  <html>
    <head><title>Ruby Toys -- <%= @name %></title></head>
    <body>

      <h1><%= @name %> (<%= @code %>)</h1>
      <p><%= @desc %></p>

      <ul>
        <% @features.each do |f| %>
          <li><b><%= f %></b></li>
        <% end %>
      </ul>

      <p>
        <% if @cost < 10 %>
          <b>Only <%= @cost %>!!!</b>
        <% else %>
           Call for a price, today!
        <% end %>
      </p>

    </body>
  </html>
}.gsub(/^  /, '')

# Gem append content in html body
module InnerHTMLContent
  class << self
    def add_content(content, bypass_html: true, file_name: 'index.html')
      serialize_content = content.gsub(%r{<\w+>|</\w+>}, '')
      content = bypass_html && serialize_content ? content.gsub(%r{<\w+>|</\w+>}, '') : content

      template_html(file_name, content)
    end

    private

    def template_html(file_name, content)
      template = '<!DOCTYPE html>
      <html lang="en">
        <head>
          <meta charset="UTF-8">
          <meta http-equiv="X-UA-Compatible" content="IE=edge">
          <meta name="viewport" content="width=device-width, initial-scale=1.0">
          <title>{title_page}</title>
        </head>
        <body>
        {inner_content}
        </body>
      </html>'.gsub(/^      /, '')
      template = template.gsub('{title_page}', content)
      template = template.gsub('{inner_content}', content)

      File.open(file_name, 'w') do |file|
        file.write(template)
      end
    end
  end
end
