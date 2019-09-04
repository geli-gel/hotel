require_relative 'test_helper'

describe "management system class" do

  before do
    @management_system = Hotel::ManagementSystem.new
  end

  it "can initialize" do
    expect(@management_system).must_be_instance_of Hotel::ManagementSystem
  end

  it "stores 20 instances of rooms" do
    room_1 = @management_system.rooms[0]
    room_20 = @management_system.rooms[19]
    nonexistent_room = @management_system.rooms[20]
    expect(room_1).must_be_instance_of Hotel::Room
    expect(room_20).must_be_instance_of Hotel::Room
    expect(nonexistent_room).must_be_instance_of NilClass
    expect(@management_system.rooms.length).must_equal 20
  end

  describe "list_rooms method" do
    it "returns array of the same length of @rooms" do
      all_rooms_length = @management_system.rooms.length
      returned_list = @management_system.list_rooms
      expect(returned_list.length).must_equal all_rooms_length
    end
  end

  describe "create_reservation method" do
    it "adds a new reservation to @reservations" do
      initial_reservation_list_length = @management_system.reservations.length
      @management_system.create_reservation(
        check_in_date: Date.today,
        check_out_date: Date.today + 1,
        )
      new_reservation_list_length = initial_reservation_list_length + 1

      expect(@management_system.reservations.length).must_equal \
        new_reservation_list_length
    end
  end

  describe "reservations_by_date method" do
    before do
      @given_date = Date.today + 5
      # First Reservation w/ Checkout Date on given_date
      @management_system.create_reservation(
        check_in_date: @given_date - 1,
        check_out_date: @given_date,
        )
      # Second Reservation w/ check_in Date on given_date
      @management_system.create_reservation(
        check_in_date: @given_date,
        check_out_date: @given_date + 1,
        )
      # Third Reservation w/ given_date not in reservation
      @management_system.create_reservation(
        check_in_date: @given_date + 8,
        check_out_date: @given_date + 10,
        )
      # Fourth Reservation w/ given_date within check_in and check_out date
      @management_system.create_reservation(
        check_in_date: @given_date - 4,
        check_out_date: @given_date + 4,
        )
    end

    it "returns an array containing all reservations for a given date only" do
      given_date_reservations = 
        @management_system.reservations_by_date(@given_date)
      total_reservations_in_system = 
        @management_system.reservations.length
        
      expect(given_date_reservations.length).must_equal 3
      expect(total_reservations_in_system).must_equal 4 
      expect(given_date_reservations).must_be_instance_of Array
      expect(given_date_reservations[0]).must_be_instance_of Hotel::Reservation     
    end
  end

end
