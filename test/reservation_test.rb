require_relative 'test_helper'

describe "reservation class" do
  before do
    @room_1 = Hotel::Room.new(0)
    @reservation = Hotel::Reservation.new(
      check_in_date: Date.today,
      check_out_date: Date.today + 1,
      room: @room_1
    )
  end

  it "can initialize" do
    expect(@reservation).must_be_instance_of Hotel::Reservation
  end

  it "raises a ReservationDateError if check_in_date is before current date" do
    assert_raises(Hotel::Reservation::ReservationDateError) { 
      Hotel::Reservation.new(
      check_in_date: Date.today - 3,
      check_out_date: Date.today - 1,
      room: @room_1
      ) 
    }
  end

  it "raises a ReservationDateError if check_out_date is before check_in_date" do
    yesterday = Date.today - 1
    assert_raises(Hotel::Reservation::ReservationDateError) { 
      Hotel::Reservation.new(
      check_in_date: Date.today,
      check_out_date: yesterday,
      room: @room_1
      ) 
    }
  end

  describe "total_cost method" do
    it "returns total cost of the reservation" do
      expect(@reservation.total_cost).must_equal 200
    end
  end

end
