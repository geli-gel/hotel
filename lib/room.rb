module Hotel
  class Room
    attr_reader :reservations, :nightly_rate, :number
    
    def initialize(rooms_length)
      @reservations = []
      @nightly_rate = 200
      @number = rooms_length + 1
    end
  end
end
