require 'JSON'
require 'open-uri'
require 'sanitize'


  def model_runner(topic)
    wiki_entry = JSON_creater(topic)
    summary = JSON_sanitizer(wiki_entry)
    summary
  end

  def JSON_creater (topic)
    topic.gsub!(" ", "%20")
    wiki_entry = JSON.parse(URI.parse("http://en.wikipedia.org/w/api.php?action=query&prop=extracts&format=json&exlimit=1&exintro=&exsectionformat=plain&titles=#{topic}").read)
    wiki_entry
  end


def JSON_sanitizer (wiki_entry)
  begin
    summary = Sanitize.clean(wiki_entry["query"]["pages"][wiki_entry["query"]["pages"].keys[0]]["extract"])
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
