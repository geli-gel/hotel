require_relative 'test_helper'

describe "reservation class" do
  before do
    @room_1 = Hotel::Room.new(0)
    @reservation = Hotel::Reservation.new(
      check_in_date: 'test_start_date',
      check_out_date: 'test_end_date',
      room: @room_1
    )
  end

  it "can initialize" do
    expect(@reservation).must_be_instance_of Hotel::Reservation
  end

end
