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

end
