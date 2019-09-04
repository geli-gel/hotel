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

end
