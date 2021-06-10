class Participant
  attr_reader :name, :deck

  def initialize(args)
    @name = args[:name]
  end
end
