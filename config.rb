require "extensions/views"

activate :views
activate :directory_indexes
activate :autoprefixer

# Specified custom layouts
# page "events/index.html", :layout => "application"
page "events/*", :layout => "events"  

# Automatic image dimensions on image_tag helper
activate :automatic_image_sizes

set :relative_links, true
set :css_dir, "assets/stylesheets"
set :js_dir, "assets/javascripts"
set :images_dir, "assets/images"
set :fonts_dir, "assets/fonts"
set :layout, "layouts/application"
set :markdown_engine, :redcarpet
set :markdown, fenced_code_blocks: true

configure :development do
 activate :livereload
end

configure :build do
  # Relative assets needed to deploy to Github Pages
  # activate :relative_assets

  # Minify CSS on build
  activate :minify_css

  # Minify Javascript on build
  activate :minify_javascript

  # Enable cache buster
  activate :asset_hash
end

activate :deploy do |deploy|
  deploy.build_before = true
  deploy.method = :git
  deploy.remote   = "origin" 
  deploy.branch   = "shinies"
  # deploy.strategy = :submodule      # commit strategy: can be :force_push or :submodule, default: :force_push
  # deploy.commit_message = 'custom-message'      # commit message (can be empty), default: Automated commit at `timestamp` by middleman-deploy `version`
end

activate :google_analytics do |ga|
  ga.tracking_id = 'UA-2721053-1'

  # Tracking across a domain and its subdomains (default = nil)
  ga.domain_name = 'example.com'

  # Tracking across multiple domains and subdomains (default = false)
  ga.allow_linker = false
end

helpers do
  def nav_link(link_text, page_url, options = {})
    options[:class] ||= ""
    if current_page.url.length > 1
      current_url = current_page.url.chop
    else
      current_url = current_page.url
    end
    if page_url != current_url
      content_tag :li do
        link_to(link_text, page_url, options)
      end
    else
      content_tag :li, link_text, :class => 'active'
    end
  end
end
