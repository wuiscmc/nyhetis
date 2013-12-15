require 'spec_helper'

describe Session do 

    context "when the user provides valid credentials" do 
      let(:session) { Session.new(user: 'test', pass: 'test', api_key: 'test')}
      
      it 'should respond with a token' do 
        expect(session.authenticate).to be_kind_of(String)
      end

      context "when the user does another request" do 
        before do 
          session.authenticate
        end
        let(:session2) { Session.new(user: 'test', session_id: session.session_id, api_key: 'test')}
        it "should validate the given token" do 
          new_token = session2.authenticate
          expect(new_token).not_to be_empty
          expect(new_token).not_to eq(session.session_id)
        end
      end

      context "when the user logs out" do 
        it "should be reset" do 
          session.logout
          expect(session).to be_empty
        end
      end
    end

    context "when the user provides wrong credentials" do 
      let(:session) { Session.new(user: 'wrongywrong', pass: 'wrongy', api_key: 'test') }
      it 'should respond with a token' do 
        expect{session.authenticate}.to raise_error(AuthenticationFailedError)
      end
    end

end