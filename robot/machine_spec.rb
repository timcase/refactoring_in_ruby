require_relative 'machine'

describe Machine do
  before :each do
    @machine = Machine.new("Oven", "middle")
  end

  it 'should initially have no bin' do
    expect(@machine.bin).to be_nil
  end

  it 'should accept things into its bin' do
    @machine.put("chips")
    expect(@machine.bin).to eq('chips')
  end
end
