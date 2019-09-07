require_relative 'test_helper'

describe "room class" do
  before do
    @room_1 = Hotel::Room.new(0)
  end

  it "can initialize" do
    expect(@room_1).must_be_instance_of Hotel::Room
  end

  it "returns room with number 1 when constructor is given 0 " do
    expect(@room_1.number).must_equal 1
  end

  describe "status method" do
    before do
      @check_in = Date.today + 2
      @check_out = Date.today + 4
      @room_1.reservations << Hotel::Reservation.new(
        check_in_date: @check_in,
        check_out_date: @check_out,
        room: @room_1
        )
    end

    it "returns :UNAVAILABLE if desired date range is already reserved" do
      status = @room_1.status(desired_check_in: @check_in,
                              desired_check_out: @check_out
                              )
      expect(status).must_equal :UNAVAILABLE
    end
    
    it "returns :AVAILABLE if desired_check_in == reserved check_out_date" do
      status = @room_1.status(desired_check_in: @check_out,
                              desired_check_out: @check_out + 3
                              )
      expect(status).must_equal :AVAILABLE
    end

    it "returns :AVAILABLE if desired_check_in == reserved check_out_date 
      && desired_check_out == separate reserved check_in_date (between 2)" do
      # Second Reservation
      later_check_in = @check_out + 3
      later_check_out = @check_out + 5
      @room_1.reservations << Hotel::Reservation.new(
        check_in_date: later_check_in,
        check_out_date: later_check_out,
        room: @room_1
        )
      # Status for dates in between the 2 reservations
      status = @room_1.status(desired_check_in: @check_out,
                              desired_check_out: later_check_in
                              )
      expect(status).must_equal :AVAILABLE
    end

    describe "status method with Blocks" do
      before do
        @room_2 = Hotel::Room.new(1)
        @room_3 = Hotel::Room.new(2)

        @room_4 = Hotel::Room.new(3)
        @room_5 = Hotel::Room.new(4)
        @room_6 = Hotel::Room.new(5)

        @all_test_rooms = [@room_1, @room_2, @room_3, @room_4, @room_5, @room_6]
        @blocked_rooms = [@room_1, @room_2, @room_3]
        @unblocked_rooms = [@room_4, @room_5, @room_6]
        # block off a far off date range with 3 rooms at a 150 nightly rate
        @far_off_blocked_check_in = Date.today + 30
        @far_off_blocked_check_out = Date.today + 33

        block = Hotel::Block.new(
          blocks_length: 0,
          check_in_date: @far_off_blocked_check_in,
          check_out_date: @far_off_blocked_check_out,
          rooms: [@room_1, @room_2, @room_3],
          discount_rate: 150
          )

        block.rooms.each do |room|
          room.blocks << block
        end
      end

      it "returns :UNAVAILABLE for each room that was blocked" do
        @blocked_rooms.each do |blocked_room|
          status = blocked_room.status(desired_check_in: @far_off_blocked_check_in,
                                       desired_check_out: @far_off_blocked_check_out
                                      )
          expect(status).must_equal :UNAVAILABLE
        end
      end

      it "returns :AVAILABLE for non-blocked rooms" do
        @unblocked_rooms.each do |unblocked_room|
          status = unblocked_room.status(desired_check_in: @far_off_blocked_check_in,
                                         desired_check_out: @far_off_blocked_check_out
                                        )
          expect(status).must_equal :AVAILABLE
        end
      end

    end
  end
end
