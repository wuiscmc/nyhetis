class User
  
  def self.valid?(username, password)
    !all.find{|user| user['email'] == username && user['password'] == password}.nil?
  end

  private

  def self.all
    Psych.load_file("config/users.yml")['users']
  end

end