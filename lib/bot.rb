class Bot
  BASE_URL = "http://abutria.ru"
  SLEEP_TIME = 1

  attr_accessor :agent, :page

  def self.save_page(page, name="tmp/page-#{Time.now.to_i}.html")
    File.open(name, "w") { |f| f.write(page.body) }
  end

  def initialize(login, password)
    @agent = Mechanize.new
    @login, @password = login, password

    Storage.instance.init
    authenticate
  end

  def parse
    list = forums_list
    list.each do |link_to_forum|
      parse_forum(link_to_forum)
    end
  end

  private

  def parse_forum(link_to_forum)
    puts "Parsing forum #{link_to_forum}"
    forum = Forum.new(link_to_forum)
    forum.parse
  end

  def authenticate
    move_to_root
    log_in
  end

  def forums_list
    page.links_with class: "forumtitle"
  end

  def move_to_root
    @page = agent.get(BASE_URL)
  end

  def log_in
    @page = page.form_with name: "form_login" do |f|
      f.username = @login
      f.password = @password
    end.click_button
  end

  def save_page(name="tmp/page-#{Time.now.to_i}.html")
    self.class.save_page(page, name)
  end
end


