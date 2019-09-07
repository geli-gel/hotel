require_relative 'test_helper'

describe "block class" do
  before do
    @room_1 = Hotel::Room.new(0)
    @room_2 = Hotel::Room.new(1)

    @block_1 = Hotel::Block.new(
      blocks_length: 0,
      check_in_date: Date.today,
      check_out_date: Date.today + 1,
      rooms: [@room_1, @room_2],
      discount_rate: 150
    )
  end

  it "can initialize" do
    expect(@block_1).must_be_instance_of Hotel::Block
  end
end
