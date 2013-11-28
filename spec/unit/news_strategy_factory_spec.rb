require 'spec_helper'


describe NewsStrategyFactory do 

	let(:unknown_urls) { %w(vivjaen.es http:/vivajaen.es http://wwvivajaen.co.uk http://wwwvivajaen.es) }

	describe "#build_new" do 

		context "when the web URL is known" do 
			
			context "and comes from idealjaen" do 
				let(:attributes) { FactoryGirl.build(:crawled_data, :relevant, url: 'ideal.es/jaen/index.php/noticias/1-blabla/si#dos') }
				it { expect(NewsStrategyFactory.build_new(attributes)).to be_a(New::IdealJaen) }
			end
			
			context "and comes from diariojaen" do 
				let(:attributes) { FactoryGirl.build(:crawled_data, :relevant, url: 'www.diariojaen.es/index.php/noticias/1-blabla/si#dos') }
				it { expect(NewsStrategyFactory.build_new(attributes)).to be_a(New::DiarioJaen) }
			end

			context "and comes from vivajaen" do 
				let(:attributes) { FactoryGirl.build(:crawled_data, :relevant, url: 'http://andaluciainformacion.es/jaen/index.php/noticias/1-blabla/si#dos') }
				it { expect(NewsStrategyFactory.build_new(attributes)).to be_a(New::VivaJaen) }
			end
		end

		context "when the web URL is not known" do 			
			it "should return a New::NullNew" do 
				unknown_urls.each do |url|
					attributes = FactoryGirl.build(:crawled_data, :relevant, url: url)
					expect(NewsStrategyFactory.build_new(attributes)).to be_a(New::NullNew)
				end
			end
		end

	end

end