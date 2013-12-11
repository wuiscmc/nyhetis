require_relative '../newspaper_mock/newspaper_mock'

shared_context "newspaper_mock" do 
  
  let(:newspaper_mock) { NewspaperMock.new }

  before do 
    newspaper_mock.start!
  end

  after do 
    newspaper_mock.stop!
  end

end