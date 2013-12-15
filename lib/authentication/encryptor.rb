require 'openssl'
require 'base64'

class Encryptor

  APPLICATION_KEY = '1Q<x%.7D7>" [xL^]Tv:#2#w1,}C&:2n/~$~yf|."b(#%W${P7r*X;{P7r*X;$=EF3]8r{178}/*#^R17^R17?!123ASD__X 8}/*#^R _%A"3$2~}(q}p$=&7,)!1/[(U)   SSSDFS"213__qwer^912:_asd'

  def self.encrypt(string)
    cipher = encryptor
    cipher.encrypt
    cipher.key = APPLICATION_KEY
    encrypted = cipher.update(string) + cipher.final
    Base64.encode64(encrypted).to_json
  end

  def self.decrypt(string)
    decipher = encryptor
    decipher.decrypt
    decipher.key = APPLICATION_KEY
    decrypted = Base64.decode64(string)
    decipher.update(decrypted) + decipher.final
  end

  def self.encryptor
    OpenSSL::Cipher::AES.new(256, :CBC)
  end

end


