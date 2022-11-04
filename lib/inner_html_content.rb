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

    def create_html(file_name)
      template = File.read('view/template.erb')
      result = ERB.new(template).result(binding)

      File.write(file_name, result)
    end
  end
end
