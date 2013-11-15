require 'spec_helper'


describe NewsStrategyFactory do 

	let(:unknown_urls) { %w(vivjaen.es http:/vivajaen.es http://wwvivajaen.co.uk http://wwwvivajaen.es) }

	describe "#find_strategy" do 

		context "ideal formed urls" do 
			
			context "from idealjaen" do 
				let(:attributes) { FactoryGirl.build(:crawled_data, :relevant, url: 'idealjaen.es/index.php/noticias/1-blabla/si#dos') }
				it { expect(NewsStrategyFactory.find_strategy(attributes)).to be_a(New::IdealJaen) }
			end
			
			context "from diariojaen" do 
				let(:attributes) { FactoryGirl.build(:crawled_data, :relevant, url: 'www.diariojaen.es/index.php/noticias/1-blabla/si#dos') }
				it { expect(NewsStrategyFactory.find_strategy(attributes)).to be_a(New::DiarioJaen) }
			end

			context "from vivajaen" do 
				let(:attributes) { FactoryGirl.build(:crawled_data, :relevant, url: 'http://www.vivajaen.es/index.php/noticias/1-blabla/si#dos') }
				it { expect(NewsStrategyFactory.find_strategy(attributes)).to be_a(New::VivaJaen) }
			end

			context "from vivajaen" do 
				let(:attributes) { FactoryGirl.build(:crawled_data, :relevant, url: 'http://vivajaen.es/index.php/noticias/1-blabla/si#dos') }
				it { expect(NewsStrategyFactory.find_strategy(attributes)).to be_a(New::VivaJaen) }
			end
		end

		context "unknown urls" do 
			it "should return a New::NullNew" do 
				unknown_urls.each do |url|
					attributes = FactoryGirl.build(:crawled_data, :relevant, url: url)
					expect(NewsStrategyFactory.find_strategy(attributes)).to be_a(New::NullNew)
				end
			end
		end

	end

end