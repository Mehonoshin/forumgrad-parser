class Topic
  attr_accessor :page

  def initialize(link)
    @link = link
  end

  def parse
    load_topic
    # go to next page of topic if exists
    posts_in_topic.each do |post_node|
      parse_and_save_post(post_node)
    end
  end

  private

  def parse_and_save_post(post_node)
    post = Post.new(post_node)
    post.save
  end

  def load_topic
    sleep(Bot::SLEEP_TIME)
    puts "Loading topic #{@link}"
    @page = @link.click
  end

  def posts_in_topic
    @page.search('.post')
  end
end

