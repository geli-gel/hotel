module Hotel
  class Block
    attr_reader :id, :check_in_date, :check_out_date, :rooms, :available_rooms
    def initialize(blocks_length:, check_in_date:, check_out_date:, rooms:, discount_rate:)
      @id = blocks_length + 1
      @check_in_date = check_in_date
      @check_out_date = check_out_date
      @rooms = rooms
      @discount_rate = discount_rate
      @available_rooms = rooms
    end

    def choose_room
      @available_rooms.shuffle!
      return @available_rooms.pop
    end

  end

end
