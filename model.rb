require 'JSON'
require 'open-uri'
require 'sanitize'

class Topic
  attr_accessor :topic, :summary
  def initialize(topic)
    @topic = topic
    @summary = nil
  end

  def get_summary
    wiki_entry = json_creater
    json_sanitizer(wiki_entry)
  end

  def json_creater
    @topic.gsub!(" ", "%20")
    wiki_entry = JSON.parse(URI.parse("http://en.wikipedia.org/w/api.php?action=query&prop=extracts&format=json&exlimit=1&exintro=&exsectionformat=plain&titles=#{topic}").read)
  end


def json_sanitizer (wiki_entry)
  begin
    @summary = Sanitize.clean(wiki_entry["query"]["pages"][wiki_entry["query"]["pages"].keys[0]]["extract"])
    if summary.nil? || summary.include?("This is a redirect") || summary.empty?
      puts "Error: Wikipedia entry not found. Please check your spelling."
    elsif summary.include?("refers to:") || summary.include?("refer to:")
      puts "Error: Disambiguation page retreived."
    else
      puts summary
    end
  rescue
    puts "Error: Cannot retreive Wikipedia entry. Please check your spelling."
  end
end

end

# class Topic
# init w/ term
# create summary (calling method?) -json sanitizer

# - summary

# - way to access the JSON
# - way to sanitize the JSON

