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
  def meta
    current_page.data
  end

  def author
    name = meta.author
    data.authors.find { |a| name === a.name }
  end

  # Published date for page
  def published_date(page = current_page)
    date = page.data.date
    case date
    when String
      DateTime.parse(date)
    when Time
      DateTime.parse(date.to_s)
    else
      date
    end
  end

  def published?(page = current_page)
    published_date(page) < Date.today
  end

  def draft?(page = current_page)
    not published? page
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
      date = child.data.date
      case date
      when String
        DateTime.parse(date)
      when Time
        DateTime.parse(date.to_s)
      else
        date
      end
    end
  end

  def categories

  end

  def content_directories
    %w(beginner intermediate advanced articles news projects guides)
  end

  def articles(drafts = false)
    pages = []
    categories = content_directories
    for category in categories
      page = sitemap.find_resource_by_path("#{category}/index.html")
      pages += children(page, drafts)
    end
    sort_by_date(pages).reverse
  end

  # November 18th, 2013
  def format_date(date)
    date.strftime '%B %e, %Y'
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

end
