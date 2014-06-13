require_relative 'model.rb'

class Controller
  def initialize
    user_interface
  end

  def user_interface
    user_query = Topic.new(get_topic)
    user_query.get_summary
    until user_query.topic.empty?
      topic = user_query.summary
      output(topic)
      user_query = Topic.new(get_topic)
      user_query.get_summary
    end
  end

  def get_topic
    puts "What wikipedia summary would you like to see?, return to exit"
    topic = gets.chomp
  end

  def output(output_string)
    puts output_string
  end
end

controller = Controller.new

# Controller.run
