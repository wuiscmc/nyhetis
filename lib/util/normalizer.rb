# encoding: utf-8
# require 'active_support'
# require 'active_support/multibyte'
# require 'active_support/multibyte/unicode'

class Normalizer

  def self.process(string)
    return string if string.empty?
    string
    .gsub('Á','A').gsub('É','E').gsub('Í','I').gsub('Ó','O').gsub('Ú','U')
    .gsub('á','a').gsub('é','e').gsub('í','i').gsub('ó','o').gsub('ú','u')
    .gsub('à','a').gsub('è','e').gsub('ì','i').gsub('ò','o').gsub('ù','u')
    .gsub('Ä','A').gsub('Ë','E').gsub('Ï','I').gsub('Ö','O').gsub('Ü','U')
    .gsub('ä','a').gsub('ë','e').gsub('ï','i').gsub('ö','o').gsub('ü','u')
    .gsub('À','A').gsub('È','E').gsub('Ì','I').gsub('Ò','O').gsub('Ù','U')
    .gsub('ñ','n').gsub('ç','[c]').gsub('Ñ','N').gsub('Ç','C')
    .gsub('å','a').gsub('Å','A').downcase
    .gsub(/[^\w\.,?]/,' ').strip.squeeze(' ')
  end

  def self.news_process(string)
    return string if string.empty?

    old_string = string

    begin

        string = string
                    .gsub("\n","")
                    .gsub("\t","")
                    .gsub("\"","").gsub("«","\"")
                    .gsub("‘","'").gsub("’","'")
                    .gsub("¢","c").gsub("$","Dolar")
                    .gsub("€","EUR")
                    .gsub("»","\"")
                    .squeeze(" ").strip
        
        ec = Encoding::Converter.new("utf-8", "iso-8859-1")

        string = ec.convert(string).dump
        .gsub('\xC3\x80',"A").gsub('\xC3\x81',"A").gsub('\xC3\x82',"A").gsub('\xC3\x83',"A").gsub('\xC3\x84',"A").gsub('\xC3\x85',"A")
        .gsub('\xC3\x88','E').gsub('\xC3\x89','E').gsub('\xC3\x8A','E').gsub('\xC3\x8B','E')
        .gsub('\xC3\x8C','I').gsub('\xC3\x8D','I').gsub('\xC3\x8E','I').gsub('\xC3\x8F','I')
        .gsub('\xC3\x92',"O").gsub('\xC3\x93',"O").gsub('\xC3\x94',"O").gsub('\xC3\x95',"O").gsub('\xC3\x96',"O")
        .gsub('\xC3\x99',"U").gsub('\xC3\x9A',"U").gsub('\xC3\x9B',"U").gsub('\xC3\x9C',"U")
        .gsub('\xC3\xA0',"a").gsub('\xC3\xA1',"a").gsub('\xC3\xA2',"a").gsub('\xC3\xA3',"a").gsub('\xC3\xA4',"a").gsub('\xC3\xA5',"a")
        .gsub('\xC3\xA8','e').gsub('\xC3\xA9','e').gsub('\xC3\xAA','e').gsub('\xC3\xAB','e')
        .gsub('\xC3\xAC','i').gsub('\xC3\xAD','i').gsub('\xC3\xAE','i').gsub('\xC3\xAF','i')
        .gsub('\xC3\xB2',"o").gsub('\xC3\xB3',"o").gsub('\xC3\xB4',"o").gsub('\xC3\xB5',"o").gsub('\xC3\xB6',"o")
        .gsub('\xC3\xB9',"u").gsub('\xC3\xBA',"u").gsub('\xC3\xBB',"u").gsub('\xC3\xBC',"u")
        .gsub('\xC3\x9D',"Y").gsub('\xC3\x9F',"Y")
        .gsub('\xC3\xBD',"y").gsub('\xC3\xBF',"y")
        .gsub('\xC3\x91','N').gsub('\xC3\xB1','n')
        .gsub('\x80\x94', '-')
        .gsub('\xE2\x80\x99','´').gsub('\xE2\x80\x98','`')
        .gsub('\xC3\xA7','c').gsub('\xC3\x87','C')
        .gsub('\xC2\xBA','º')
        
        string = string.gsub('\xC2\xA0','').gsub('\\xC2','')
        .gsub('\xC0',"A").gsub('\xC1',"A").gsub('\xC2',"A").gsub('\xC3',"A").gsub('\xC4',"A").gsub('\xC5',"A")
        .gsub('\xC8','E').gsub('\xC9','E').gsub('\xCA','E').gsub('\xCB','E')
        .gsub('\xD2',"O").gsub('\xD3',"O").gsub('\xD4',"O").gsub('\xD5',"O").gsub('\xD6',"O")
        .gsub('\xD9',"U").gsub('\xDA',"U").gsub('\xDB',"U").gsub('\xDC',"U")
        .gsub('\xE0',"a").gsub('\xE1',"a").gsub('\xE2',"a").gsub('\xE3',"a").gsub('\xE4',"a").gsub('\xE5',"a")
        .gsub('\xCC','I').gsub('\xCD','I').gsub('\xCE','I').gsub('\xCF','I')
        .gsub('\xE8','e').gsub('\xE9','e').gsub('\xEA','e').gsub('\xEB','e')
        .gsub('\xEC','i').gsub('\xED','i').gsub('\xEE','i').gsub('\xEF','i')
        .gsub('\xF2',"o").gsub('\xF3',"o").gsub('\xF4',"o").gsub('\xF5',"o").gsub('\xF6',"o")
        .gsub('\xF9',"u").gsub('\xFA',"u").gsub('\xFB',"u").gsub('\xFC',"u")
        .gsub('\xFD',"y").gsub('\xFF',"y")
        .gsub('\xD1','N').gsub('\xF1','n')
        .gsub('\xE7','c').gsub('\xC7','C')
        .gsub('\x80\x9d', "'").gsub('\x80\x9c',"'")
        .gsub('\xBF',"")
        
        string.downcase.to_ascii.gsub("\"","").gsub("\\","")

    rescue Encoding::UndefinedConversionError => e
        
        old_string

    end
  end


end