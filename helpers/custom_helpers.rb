require 'rexml/document'

module CustomHelpers

  # Grab the page title from the first H1 if not provided in frontmatter
  def title(page = current_page)
    page.data.title || begin
      content = page.render(layout: false)
      match = content.match(/<h1.*?>(.*?)<\/h1>/m)
      escape_html(match[1]) if match
    end
  end

  # Shortcut for current page data
  def meta(page = current_page)
    page.data
  end

  def author(page = current_page)
    name = meta(page).author
    data.authors.find { |a| name === a.name }
  end

  def authors(inactive = false)
    people = data.authors
    people.reject! { |a| a.inactive } unless inactive
    people
  end

  # Published date for page
  def published_date(page = current_page)
    parse_date(page.data.date)
  end

  def published?(page = current_page)
    date = published_date(page)
    date <= Date.today if date
  end

  def draft?(page = current_page)
    not published? page
  end

  def categories
    data.categories
  end

  def category(slug)
    categories.find { |c| c.slug === slug }
  end

  # The children of the current page ordered by date
  def children(page = current_page, drafts = false)
    pages = sort_by_date(page.children)
    if drafts
      pages
    else
      pages.reject { |p| draft? p }
    end
  end

  def articles_by_author(author, drafts = false)
    articles(drafts).reject { |a| a.data.author != author.name }
  end

  def sort_by_date(pages)
    pages.sort_by do |child|
      parse_date(child.data.date) || DateTime.now
    end
  end

  def content_directories
    categories.select { |c| c.directory }.map(&:slug)
  end

  def articles(drafts = false)
    pages = []
    for category in content_directories
      page = sitemap.find_resource_by_path("#{category}/index.html")
      pages += children(page, drafts)
    end
    sort_by_date(pages).reverse
  end

  def articles_for(categories, drafts = false)
    categories = [*categories]
    pages = articles(drafts).select do |article|
      if string = meta(article).categories
        slugs = string.strip.split(/\s*,\s*/)
        slugs && slugs.any? { |s| categories.include? s }
      end
    end
    pages
  end

  def parse_date(date)
    case date
    when String
      DateTime.parse(date)
    when Time
      DateTime.parse(date.to_s)
    else
      date
    end
  end

  # November 18th, 2013
  def format_date(date)
    d = parse_date(date)
    d.strftime '%B %e, %Y'
  end

  def atom_id(page = current_page)
    page.data.atom_id || begin
      published = published_date(page).strftime('%Y-%m-%d')
      "tag:thesassway.com,#{published}:#{page.url}"
    end
  end

  def absolute_urls(text)
    text.gsub!(/(<a href=['"])\//, '\1' + 'http://thesassway.com')
    text
  end

  def render_markdown(string, block = false)
    html = Kramdown::Document.new(string, input: 'kramdown', remove_block_html_tags: false).to_html
    if block
      html
    else
      doc = REXML::Document.new(html)
      doc.root.children.join
    end
  end

  def select_if(path, exact = false)
    regexp = exact ? /^#{ Regexp.quote path }(\/$|$)/ : /^#{ Regexp.quote path }(\/.*?$|$)/
    ' is-selected' if regexp.match(current_page.url)
  end

end
