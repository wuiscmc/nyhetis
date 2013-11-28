require_relative 'abstract_new'

class NewsStrategyFactory

	def self.build_new(content)
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

end