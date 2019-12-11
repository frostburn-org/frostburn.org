require 'rubygems'
require 'middleman/rack'
require 'rack/contrib/try_static'

# Enable proper HEAD responses
use ::Rack::Head

# Serve files from the build directory
use ::Rack::TryStatic,
  root: 'build',
  urls: %w[/],
  try: ['.html', 'index.html', '/index.html']

#run lambda{ |env|
#  four_oh_four_page = File.expand_path("../build/404/index.html", __FILE__)
#  [ 404, { 'Content-Type'  => 'text/html'}, [ File.read(four_oh_four_page) ]]
#}

###
# Compass
###

# Change Compass configuration
# compass_config do |config|
#   config.output_style = :compact
# end

###
# Page options, layouts, aliases and proxies
###

# Per-page layout changes:
#
# With no layout
# page "/path/to/file.html", :layout => false
#
# With alternative layout
# page "/path/to/file.html", :layout => :otherlayout
#
# A path which all have the same layout
# with_layout :admin do
#   page "/admin/*"
# end

# Proxy pages (https://middlemanapp.com/advanced/dynamic_pages/)
# proxy "/this-page-has-no-template.html", "/template-file.html", :locals => {
#  :which_fake_page => "Rendering a fake page with a local variable" }

###
# Helpers
###

# Automatic image dimensions on image_tag helper
# activate :automatic_image_sizes

# Reload the browser automatically whenever files change
configure :development do
   activate :livereload
end

# Methods defined in the helpers block are available in templates
helpers do
#   def some_helper
#     "Helping"
#   end
  def volunteer_link(this)
      if  eval("#{"data.event.links.#{this}.open"}") == true
      link_to eval("#{"data.event.links.#{this}.text"}"),
        eval("#{"data.event.links.#{this}.link"}")
    else
        "<b>" +
        eval("#{"data.event.links.#{this}.closed"}") +
        "</b>"

    end
  end
  def registration_link(this)
    if  eval("#{"data.event.links.#{this}.open"}") == true
      link_to eval("#{"data.event.links.#{this}.text"}"),
        eval("#{"data.event.links.#{this}.link"}")
    elsif eval("#{"data.event.links.#{this}.open"}") == "soon"
        "<b>" +
        eval("#{"data.event.links.#{this}.soon"}") +
        "</b>"
    else
        "<b>" +
        eval("#{"data.event.links.#{this}.closed"}") +
        "</b>"
    end
  end
 end

set :css_dir, 'stylesheets'

set :js_dir, 'javascripts'

set :images_dir, 'images'

# Build-specific configuration
configure :build do
  # For example, change the Compass output style for deployment
  activate :minify_css

  # Minify Javascript on build
  activate :minify_javascript

  activate :directory_indexes

  # Enable cache buster
  # activate :asset_hash

  # Use relative URLs
  # activate :relative_assets

  # Or use a different image path
  # set :http_prefix, "/Content/images/"
end
