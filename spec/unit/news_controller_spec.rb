require 'spec_helper'

describe NewsController do 

	let(:news_controller) { NewsController.new }
	
	describe "#analyze_content" do 
		
		context "when the new is relevant" do 
			let(:content) {{url: "wwww.diariojaen.es", content: "universidad de jaen"}}
			
			it "saves the analyzed new in the history" do 
				
			end

		end

	end


end
