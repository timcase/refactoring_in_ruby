require_relative 'machine'
require_relative 'robot'

describe Robot, 'when new' do
  before :each do
    @robot = Robot.new
  end

  it 'has no location yet' do
    expect(@robot.location).to be_nil
  end

  it 'does not point at a bin yet' do
    expect(@robot.bin).to be_nil
  end
end

describe Robot, "in a world with machines" do
  before :each do
    @robot = Robot.new
    @sorter = Machine.new("Sorter", "left")
    @sorter.put("chips")
    @oven = Machine.new("Oven", "middle")
  end

  describe 'moving among machines' do
    it 'reports correct location' do
      @robot.move_to(@oven)
      expect(@robot.location).to eq(@oven)
    end
  end

  describe "moving and picking" do
    it 'should take the bin away from the machine' do
      expect(lambda {
        @robot.move_to(@sorter)
        @robot.pick
      }).to change { @sorter.bin }.from('chips').to(nil)
    end
  end

  describe "picking and releasing" do
    def move_and_pick_and_move_and_release
      @robot.move_to(@sorter)
      @robot.pick
      @robot.move_to(@oven)
      @robot.release
    end

    it 'should take the bin away from the sorter' do
      expect(lambda {
        move_and_pick_and_move_and_release
      }).to change { @sorter.bin }.from('chips').to(nil)
    end

    it 'should deposit the bin at the oven' do
      expect(lambda {
        move_and_pick_and_move_and_release
      }).to change { @oven.bin }.from(nil).to('chips')
    end
  end
end
