require_relative 'model.rb'

class Controller
  def initialize
    user_interface
  end

  def user_interface
    toggle = true
    while toggle
      topic = prompt
      if topic.empty?
        puts "end of program"
        return
      end
      summary = model_runner(topic)

      output(summary)
    end
  end

  def prompt
    puts "What wikipedia summary would you like to see?, return to exit"
    topic = gets.chomp
    topic
  end

  def output(output_string)
    puts output_string
  end
end

controller = Controller.new


