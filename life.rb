require_relative 'cell'

class GameOfLife

	def initialize(size)
		@generation = 0
		@total_size = size * size
		@size = size
		@boundary = size -1
		@cells = Array.new(size*size) {Cell.new}
	end

	def seed_life
		a = (0...@total_size).to_a.shuffle.take(@total_size /3)
		a.each do |index|
			@cells[index].live!
		end
	end

	def tick!
		count_adj_alive
		@cells.each {|cell| cell.tick}
		@generation += 1
	end

	def display
		clear_screen!
		print to_s
	end

	def to_s
		string = "Totals Gens: #{@generation} Alive: #{Cell.total_living} Created: #{Cell.total_created} Died: #{Cell.total_destroyed}\n"
		string << "┌" + ("─" * @size*2) + "┐\n"
		@cells.each_slice(25) do |row|
			string << '│'
			row.each{|cell| string << cell.display}
			string << "│\n"
		end
		string << "└" + ("─" * @size*2) + "┘\n"
		string
	end

	private 

	def clear_screen!
 	 print "\e[2J"
	end

	def count_adj_alive
		@cells.each_with_index do |item, i|

			y_axis, x_axis = i.divmod(@size)
			living = 0

			unless y_axis == 0
				living +=1 if get_rows[y_axis -1][x_axis].alive?  #above
				living +=1 if get_rows[y_axis -1][x_axis -1].alive? unless x_axis == 0 #above to left
				living +=1 if get_rows[y_axis -1][x_axis +1].alive? unless x_axis == @boundary #above to right
			end

			living +=1 if get_rows[y_axis][x_axis -1].alive? unless x_axis == 0 #left
			living +=1 if get_rows[y_axis][x_axis +1].alive? unless x_axis == @boundary  #right

			unless y_axis == @boundary
				living +=1 if get_rows[y_axis +1][x_axis].alive?  #below
				living +=1 if get_rows[y_axis +1][x_axis +1].alive? unless x_axis == @boundary #below to right
				living +=1 if get_rows[y_axis +1][x_axis -1].alive? unless x_axis == 0 #below to left
			end

			item.living_adj = living
		end
	end

	def get_rows
		@rows ||= @cells.each_slice(@size).to_a
	end

	# def get_cols
	# 	@cells.each_slice(12).to_a.transpose
	# end

end

game = GameOfLife.new(25)
game.seed_life

1000.times do

game.tick!
game.display
sleep(0.5)


end
# p game.get_rows