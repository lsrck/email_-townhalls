require 'rubygems'
require 'nokogiri'
require 'open-uri'


PAGE_URL = "http://www.annuaire-des-mairies.com/14/ablon.html"
#url du premier exo
PAGE_URL2 = "http://www.annuaire-des-mairies.com/calvados.html"
#url du second exo


$mon_hash = Hash.new

def get_the_email_of_a_townhall_from_its_webpage(mailcheck) #def de la methode
doc = Nokogiri::HTML(open(mailcheck))
doc.xpath('//p[@class="Style22"]').each do |email| #ciblé l'email dans la class et appliquer un each do
  if email.text.include? "@" #si l'email contient un @, ecrire email
   email = email.text[1..-1]
   town = doc.css("h1").text[11..-9]
   $mon_hash[town] = email
    end
  end
  puts $mon_hash
  return $mon_hash
end


def get_all_the_urls_of_val_doise_townhalls(linkcheck) #def de la fonction
page = Nokogiri::HTML(open(linkcheck))
page.css("a.lientxt").each do |link| #ciblé le lien url de la ville
link['href'] = link['href'][1..-1] #concatené l'url pour l'étape d'après en retirant le "."
mailcheck = "http://annuaire-des-mairies.com" + link['href'] #construction de l'url
city = link['href'][4..-6].capitalize
get_the_email_of_a_townhall_from_its_webpage(mailcheck) #appel de la fonction email pour scrapper les emails de chaque ville
end
end


get_all_the_urls_of_val_doise_townhalls(PAGE_URL2)

