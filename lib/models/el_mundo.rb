module New

	class ElMundo < AbstractNew
		
		def self.url
			/^(((http:\/\/)?))((www\.)?)(diariojaen\.es(.?))$/
		end
		
		def relevant?
			false
		end

		def valid?
			false
		end

	end

end