module CustomHelpers

  def is_post?
    true
  end

  def is_category?
    true
  end

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

  # The children of the current page ordered by date
  def children
    current_page.children.sort_by do |child|
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

end
