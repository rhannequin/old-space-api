class ParsePlanets < Parser
  def initialize(config)
    super(config)
  end

  def all
    puts 'I am going to launch every tasks from ParsePlanets.'
    puts "This is my proxy config: #{proxy}"
  end
end
