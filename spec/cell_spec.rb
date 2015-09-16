require_relative '../life'

# Write your tests here.  We'd write some for you, but who knows what classes you'll use!

#Every method should be tested!
describe "The cell" do
  let(:cell) { Cell.new }


   describe 'lifecycle' do
    it 'starts dead' do
      expect(cell.alive?).to eq(false)
    end


    it 'becomes alive with three neighbours' do
      cell.living_adj = 3
      cell.tick
      expect(cell.alive?).to eq(true)
    end


    it 'dies with four neighbours' do
      cell.living_adj = 3
      cell.tick
      cell.living_adj = 4
      cell.tick
      expect(cell.alive?).to eq(false)
    end

    it 'correctly calculates the number of cells created' do
      expect(Cell.total_created).to eq(2)
    end

    it 'correctly calculates the number of cells destroyed' do
      expect(Cell.total_destroyed).to eq(2)
    end
  end
end