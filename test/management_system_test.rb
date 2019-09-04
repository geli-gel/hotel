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

end
