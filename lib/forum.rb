class Forum
  attr_accessor :page, :topics

  def initialize(link)
    @link = link
    @topics = []
  end

  def parse
    load_page
    # TODO:
    # implement it
    #parse_subforums
    parse_topics
  end

  private

  def load_page
    @page = @link.click
    puts "Forum '#{@page.title}' loaded"
  end

  def parse_subforums
    raise "Not implemented yet"
  end

  def parse_topics
    topics = topic_links
    #puts "Forum #{@page.title} has following topics: #{topics}"
    topics.each do |topic_link|
      parse_topic(topic_link)
    end
  end

  def topic_links
    page.links_with class: 'topictitle'
  end

  def parse_topic(topic_link)
    topic = Topic.new(topic_link)
    topics << topic
    begin
      topic.parse
    rescue Mechanize::ResponseCodeError => e
      puts "Error on topic loading: #{@link} #{e}"
    end
  end

end
