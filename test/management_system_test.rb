require_relative 'test_helper'

describe "management system class" do

  before do
    @management_system = Hotel::ManagementSystem.new
    @total_number_of_rooms = 20
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
    expect(@management_system.rooms.length).must_equal @total_number_of_rooms
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
      expected_new_reservation_list_length = initial_reservation_list_length + 1

      expect(@management_system.reservations.length).must_equal \
        expected_new_reservation_list_length
    end
  end

  describe "create_block method" do
    it "adds a new block to @blocks" do
      initial_blocks_list_length = @management_system.blocks.length
      @management_system.create_block(
        check_in_date: Date.today,
        check_out_date: Date.today + 1, 
        room_numbers: [1,2,3], 
        discount_rate: 150
        )
      expected_new_blocks_list_length = initial_blocks_list_length + 1

      expect(@management_system.blocks.length).must_equal \
        expected_new_blocks_list_length
    end

    it "adds the new block to each room's blocks" do
    end

    it "raises SystemReservationError if a room in desired block is already reserved" do
      room_10 = @management_system.rooms[9]
      @management_system.create_reservation(
        check_in_date: Date.today,
        check_out_date: Date.today + 1,
        room: room_10
        )
      assert_raises(Hotel::ManagementSystem::SystemReservationError) {
        @management_system.create_block(
          check_in_date: Date.today,
          check_out_date: Date.today + 1, 
          room_numbers: [10,12,15], # room_10 is part of the above created reservation
          discount_rate: 150
          )
      }
    end

    it "raises SystemReservationError if a room in desired block is already in another block" do
      @management_system.create_block(
        check_in_date: Date.today,
        check_out_date: Date.today + 1, 
        room_numbers: [1,2,3], 
        discount_rate: 150
        )
      assert_raises(Hotel::ManagementSystem::SystemReservationError) {
        @management_system.create_block(
          check_in_date: Date.today,
          check_out_date: Date.today + 1, 
          room_numbers: [3,4,5], # room_3 is part of the above created block
          discount_rate: 150
          )
      }
    end

  end

  describe "reservations_by_date method" do
    before do
      @given_date = Date.today + 5
      # First Reservation w/ Checkout Date on given_date
      @management_system.create_reservation(
        check_in_date: @given_date - 1,
        check_out_date: @given_date
        )
      # Second Reservation w/ check_in Date on given_date
      @management_system.create_reservation(
        check_in_date: @given_date,
        check_out_date: @given_date + 1
        )
      # Third Reservation w/ given_date not in reservation
      @management_system.create_reservation(
        check_in_date: @given_date + 8,
        check_out_date: @given_date + 10
        )
      # Fourth Reservation w/ given_date within check_in and check_out date
      @management_system.create_reservation(
        check_in_date: @given_date - 4,
        check_out_date: @given_date + 4
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

    describe "available_rooms_for method" do
      before do
        @desired_check_in = @given_date
        @desired_check_out = @given_date + 1
        @available_rooms = @management_system.available_rooms_for(@desired_check_in, @desired_check_out)
      end

      it "returns array of rooms when rooms are available for a desired dates" do
        # first reservation's room will be available since checkout date is on
          # desired_check_in (first reservation checking out when new guest 
          # checking in)

        # ** second reservation's room will **NOT** be available since dates are equal
        
        # third reservation's room will be available since it's dates are way 
          # in the future

        # ** fourth reservation's room will **NOT** be available since it's dates 
          # envelop the desired dates.
        
        # 20 - 2 (18 rooms) should be available for the desired dates
        expect(@available_rooms.length).must_equal @total_number_of_rooms - 2
      end

      it "raises a SystemReservationError if there are no rooms available for desired dates" do
        (@available_rooms.length).times do 
          @management_system.create_reservation(
            check_in_date: @desired_check_in,
            check_out_date: @desired_check_out
            )
        end
        assert_raises(Hotel::ManagementSystem::SystemReservationError) {
          @management_system.available_rooms_for(@desired_check_in, @desired_check_out)
        }
      end
    end

  end

end
