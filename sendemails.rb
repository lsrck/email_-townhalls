require "google_drive"
require "gmail"
require "json"
require "dotenv"
require_relative "spread.rb"
Dotenv.load

	#J'ai laissé s'afficher le scrapping des emails pour voir ou le programme en est
	
$gmail = Gmail.connect!(ENV["USERNAME"],ENV["PASSWORD"])
 	
 	#Ce nouveau hash va permettre de récupérer les données sur la spreadsheet google
$new_hash = Hash.new

def go_through_all_the_lines
		#On part de la 2e ligne
	i=2
		#De 1 au nombre de maires contenu dans le hash on récupére le nom ainsi  que l'email
	for num in 1..$mon_hash.size
	mairies = $ws[i,1]
	emails = $ws[i,2]
		#On enregistre les données dans le new_hash
	$new_hash [mairies] = emails
	i+=1
	end
end

go_through_all_the_lines
puts $new_hash

def send_email_to_line
	$new_hash.each{|mairie, email|
	$gmail.deliver do
	#Ceci est mon adresse gmail, remplacer par #{email} pour envoyer aux mairies
  	to "#{email}"
  	subject "Formation au code gratuite"
  	html_part do
  	content_type 'text/html; charset=UTF-8'
	body "<p>Bonjour,<br/>

Je m'appelle Jean-Michel, je suis élève à une formation de code gratuite, ouverte à tous, sans restriction géographique, ni restriction de niveau.<br/>
La formation s'appelle The Hacking Project (http://thehackingproject.org/). Nous apprenons l'informatique via la méthode du peer-learning : nous faisons des projets concrets qui nous sont assignés tous les jours, sur lesquel nous planchons en petites équipes autonomes. Le projet du jour est d'envoyer des emails à nos élus locaux pour qu'ils nous aident à faire de The Hacking Project un nouveau format d'éducation gratuite.
Nous vous contactons pour vous parler du projet, et vous dire que vous pouvez ouvrir une cellule à #{mairie}, où vous pouvez former gratuitement 6 personnes (ou plus), qu'elles soient débutantes, ou confirmées.<br/> 
Le modèle d'éducation de The Hacking Project n'a pas de limite en terme de nombre de moussaillons (c'est comme cela que l'on appelle les élèves), donc nous serions ravis de travailler avec #{mairie} !<br/>
Charles, co-fondateur de <em>The Hacking Project<em> pourra répondre à toutes vos questions : 06.95.46.60.80.</p>"
	puts email
	end
	end
	#Compteur pour ne pas se faire bloquer son compte
	 sleep(30)
	}
end
send_email_to_line
$gmail.logout