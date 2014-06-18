class Post
  def initialize(post, topic, forum)
    @post  = post
    @topic = topic
    @forum = forum
  end

  def save
    Storage.instance.save_post(post_hash)
  end

  private

  def post_hash
    {
      forum: @forum.forum_number,
      topic_name: @post.at_css('h2 a').text,
      post_id: @post.children[0].attributes["name"].value,
      created_at: @post.at_css('h2').children.last.text,
      username: (@post.at_css('.username a') || @post.at_css('.username')).text,
      context: @post.at_css('.entry-content').children[1].to_html
    }
  end


end


