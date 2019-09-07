module Hotel
  class Block
    attr_reader :id, :check_in_date, :check_out_date, :rooms
    def initialize(blocks_length:, check_in_date:, check_out_date:, rooms:, discount_rate:)
      @id = blocks_length + 1
      @check_in_date = check_in_date
      @check_out_date = check_out_date
      @rooms = rooms
      @discount_rate = discount_rate
    end

  end

end
