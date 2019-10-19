def valid_chars? str
  chars = ('A'..'Z').to_a + (0..9).to_a
  str.chars.detect {|ch| !chars.include?(ch)}.nil?
end

File.open('./words.txt', 'r') do |in_file|
	File.open('./valid_words.txt', 'w') do |out_file|
		in_file.each_line do |line|
			if (line.chomp.length < 7) && valid_chars?(line.chomp.upcase)
				p line.upcase
				out_file.write(line.upcase)
			end
		end
	end
end