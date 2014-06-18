class Topic
  attr_accessor :page, :forum

  def initialize(link, forum)
    @forum = forum
    @link = link
  end

  def parse
    load_first_topic_page
    links = load_topic_page_links
    load_other_pages(links)
  end

  private

  def load_first_topic_page
    topic_page = TopicPage.new(@link, forum)
    @page = topic_page.page
    topic_page.parse
  end

  def load_other_pages(links)
    links.each do |topic_page_link|
      topic_page = TopicPage.new(topic_page_link, forum)
      topic_page.parse
    end
  end

  def load_topic_page_links
    links = @page.links_with(search: 'div.paged-head p.paging a', href: /-topic/)
    filtered_links = links.select do |link|
      link.text.to_i != 0
    end
    filtered_links
  end
end

