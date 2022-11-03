# ruby_inner_html_content
Gem create new html file, add custom content in *<body></body>*, cut html/js tag with `bypass_html: true`

## Example usage gem without serialize content
`InnerHTMLContent.add_content('<div>some code</deiv>', bypass_html: false, 'your_file_name.html')`