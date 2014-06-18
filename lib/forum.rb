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

  def forum_number
    @number ||= @link.to_s.gsub('/', '').split('-')[0]
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
    topics.each do |topic_link|
      parse_topic(topic_link)
    end
  end

  def topic_links
    page.links_with class: 'topictitle'
  end

  def parse_topic(topic_link)
    topic = Topic.new(topic_link, self)
    topics << topic
    begin
      topic.parse
    rescue Mechanize::ResponseCodeError => e
      puts "Error on topic loading: #{@link} #{e}"
    end
  end

end
