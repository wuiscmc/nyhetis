require 'spec_helper'
require_relative '../support/request'

describe 'how the users authenticate in the system' do 

  include_context "request"

  context "when the user logs in" do 
    it "should assign him a session" do 
      response = post("/session", { user: test_user.user, password: test_user.pass, api_key: test_user.api_key })
      expect(response['session']).to be_kind_of String
    end

  end

  context "when the user logs out" do 
    before do 
      response = post("/session", { user: test_user.user, password: test_user.pass, api_key: test_user.api_key })
      @session_id = response['session']
    end
    
    it "should remove its session" do 
      expect(@session_id).not_to be_empty
      response = delete("/session", { user: test_user.user, session_id: @session_id })  
      expect(response['session']).to be_empty
    end

  end

end