module Hotel
  class ManagementSystem
    class SystemReservationError < StandardError; end
    attr_reader :rooms, :reservations, :blocks

    def initialize
      @NUMBER_OF_ROOMS = 20
      @rooms = initialize_rooms
      @reservations = []
      @blocks = []
    end

    def initialize_rooms
      initial_rooms = []
      @NUMBER_OF_ROOMS.times do
        initial_rooms << Hotel::Room.new(initial_rooms.length)
      end
      return initial_rooms
    end

    def list_rooms
      return @rooms
    end

    def reservations_by_date(date)
      return @reservations.select do |reservation|
        date.between?(reservation.check_in_date,reservation.check_out_date)
      end
    end

    def create_block(check_in_date:, check_out_date:, room_numbers:, discount_rate:)
      if room_numbers.length < 1 || room_numbers.length > 5
        raise SystemReservationError.new("Cannot create block for less than 1 or more than 5 rooms")
      end
      rooms_from_numbers = room_numbers.map do |room_number|
        @rooms.find do |room|
          room.number == room_number
        end
      end

      room_statuses = rooms_from_numbers.map do |room|
        room.status(desired_check_in: check_in_date, desired_check_out: check_out_date)
      end

      if room_statuses.any?(:UNAVAILABLE)
        raise SystemReservationError.new("Cannot create block for rooms that are already reserved or blocked")
      end

      new_block = Hotel::Block.new(
        blocks_length: @blocks.length,
        check_in_date: check_in_date,
        check_out_date: check_out_date,
        rooms: rooms_from_numbers,
        discount_rate: discount_rate
      )
      @blocks << new_block
      rooms_from_numbers.each do |room|
        room.blocks << new_block
      end
      return new_block
    end

    def reserve_blocked_room(block_id)
      block = find_block_by_id(block_id)
      chosen_room = block.choose_room
      if chosen_room == nil
        raise SystemReservationError.new("There are no available rooms for the chosen block")
      end      
      create_reservation(
        check_in_date: block.check_in_date, 
        check_out_date: block.check_out_date, 
        room: chosen_room
      )
    end

    def find_block_by_id(block_id)
      @blocks.find { |block| block.id == block_id }
    end

    def create_reservation(check_in_date:, check_out_date:, room: choose_room(check_in_date, check_out_date))
      new_reservation = Hotel::Reservation.new(
        check_in_date: check_in_date, 
        check_out_date: check_out_date,
        room: room #choose_room(check_in_date, check_out_date)
      )
      @reservations << new_reservation
      new_reservation.room.reservations << new_reservation
    end

    def choose_room(desired_check_in, desired_check_out)
      available_rooms = available_rooms_for(desired_check_in, desired_check_out)
      return available_rooms.sample
    end  
        
    def available_rooms_for(desired_check_in, desired_check_out)
      available_rooms = @rooms.select do |room|
        room.status(desired_check_in: desired_check_in, desired_check_out: desired_check_out) == :AVAILABLE        
      end
      if available_rooms.length > 0
        return available_rooms
      else
        raise SystemReservationError.new("There are no available rooms for the desired_check_in and desired_check_out dates")
      end
    end

    def available_rooms_by_block(block_id)
      block = find_block_by_id(block_id)
      return block.available_rooms
    end

  end
end
