require_relative 'date_range'

module Hotel
  class Block < Hotel::DateRange
    attr_reader :id, :check_in_date, :check_out_date, :rooms, :available_rooms
    def initialize(blocks_length:, check_in_date:, check_out_date:, rooms:, discount_rate:)
      super(check_in_date, check_out_date)
      @id = blocks_length + 1
      @rooms = rooms
      @discount_rate = discount_rate
      @available_rooms = rooms
    end

    def choose_room
      @available_rooms.shuffle!
      return @available_rooms.pop
    end

    def date_range_conflict?(desired_check_in, desired_check_out)
      super(desired_check_in, desired_check_out)
    end

  end
end
