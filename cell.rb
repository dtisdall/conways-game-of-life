class Cell

	@@total_created = 0
	@@total_destroyed = 0
	@@order_created = 0

	def self.total_created
		@@total_created
	end

	def self.total_destroyed
		@@total_destroyed
	end

	def self.total_living
		@@total_created - @@total_destroyed
	end

	def initialize
		@living = false
		@adj = 0
		@seq = @@order_created
		@@order_created += 1
	end

	def living_adj=(cells)
		@adj = cells
	end

	def alive?
		@living
	end

	def display
		alive? ? '█▊' : '  '
		# "%-5s" % @seq.to_s ░
	end	

	def tick
		life_or_death
	end	

	def live!
		life
	end

	private

	def life_or_death
		case @adj
		when 0..1
			death if @living
		when 2
			#
		when 3
			life unless @living
		when 4..8
			death if @living
		end
	end

	def life
		@living = true
		@@total_created += 1
	end

	def death
		@living = false
		@@total_destroyed += 1
	end

end
