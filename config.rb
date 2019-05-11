###
# Page options, layouts, aliases and proxies
###

# Ignore
ignore "templates/*"

# Per-page layout changes:
#
# With no layout
# page "/path/to/file.html", :layout => false
#
# With alternative layout
# page "/path/to/file.html", :layout => :otherlayout

categories = data.categories.map(&:slug)
for category in categories
  page "/#{category}/*", layout: "article"
end

# Proxy pages (http://middlemanapp.com/dynamic-pages/)
# proxy "/this-page-has-no-template.html", "/template-file.html", :locals => {
#  :which_fake_page => "Rendering a fake page with a local variable" }

data.authors.each do |author|
  proxy "/#{author.slug}/index.html", "templates/author.html", locals: { person: author }
end

data.categories.each do |category|
  proxy "/#{category.slug}/index.html", "templates/category.html", locals: { item: category }
end

ready do
  data.authors.each do |author|
    resource = sitemap.find_resource_by_path "/#{author.slug}.html"
    resource.add_metadata page: { title: "#{author.name}, #{author.title}" }
  end

  data.categories.each do |category|
    resource = sitemap.find_resource_by_path "/#{category.slug}/index.html"
    resource.add_metadata page: { title: category.name }
  end
end


###
# Disqus
###
set :disqus_short_name, 'thesassway'


###
# Helpers
###

# Automatic image dimensions on image_tag helper
# activate :automatic_image_sizes

# Reload the browser automatically whenever files change
# activate :livereload

# Methods defined in the helpers block are available in templates
# helpers do
#   def some_helper
#     "Helping"
#   end
# end


###
# Plugins
###

activate :autoprefixer do |prefix|
  prefix.browsers = "last 2 versions"
end

# Directories
set :css_dir, 'stylesheets'
set :js_dir, 'javascripts'
set :images_dir, 'images'

# Directory indexes
activate :directory_indexes
set :trailing_slash, false


##
# Build-specific configuration
##

configure :build do
  # For example, change the Compass output style for deployment
  # activate :minify_css

  # Minify Javascript on build
  # activate :minify_javascript

  # Enable cache buster
  # activate :asset_hash

  # Use relative URLs
  # activate :relative_assets

  # Or use a different image path
  # set :http_prefix, "/Content/images/"
end
