module CustomHelpers

  # Grab the page title from the first H1 if not provided in frontmatter
  def title(page = current_page)
    page.data.title || begin
      content = page.render({:layout => false})
      match = content.match(/<h1.*?>(.*?)<\/h1>/m)
      escape_html(match[1]) if match
    end
  end

  # Shortcut for current page data
  def meta
    current_page.data
  end

  def summary(page)

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

  def articles_by_author(author)
    feed.reject { |a| a.data.author != author }
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

  def feed(limit = 8, drafts = false)
    categories = %w(beginner intermediate advanced articles news projects)
    pages = []
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

end
