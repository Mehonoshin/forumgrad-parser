class TopicPage
  attr_accessor :page, :forum

  def initialize(link, forum)
    @link  = link
    @forum = forum
    load_page
  end

  def parse
    posts_on_page.each do |post_node|
      parse_and_save_post(post_node)
    end
  end

  private

  def load_page
    sleep(Bot::SLEEP_TIME)
    puts "Loading topic #{@link}"
    begin
      @page = @link.click
    rescue
      raise "#{@link.inspect}"
    end
  end

  def posts_on_page
    @page.search('.post')
  end

  def parse_and_save_post(post_node)
    post = Post.new(post_node, self, forum)
    post.save
  end

end
