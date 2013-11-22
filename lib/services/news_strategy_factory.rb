require_relative '../models/abstract_new'

class NewsStrategyFactory

	def self.find_strategy(content)
		attributes = { body: content.body, url: content.url }
		case content.url
		when New::DiarioJaen.url
			New::DiarioJaen.new(attributes)
		
		when New::VivaJaen.url
			New::VivaJaen.new(attributes)
		
		when New::IdealJaen.url
			New::IdealJaen.new(attributes)
		
		else
			New::NullNew.new(attributes)
		end
		
	end

	def self.find_all
		New::AbstractNew.find_all
	end


end