# -*- encoding: utf-8 -*-
require 'cora'
require 'siri_objects'
require 'open-uri'
require 'nokogiri'
require 'timeout'

#######
#
# This is simple plugin which read a random Chuck Norris quote in german.
#
#       Remember to put this plugins into the "./siriproxy/config.yml" file 
#######
#
# Ein einfaches Plugin, welches einen zufälligen Chuck Norris Witz erzählt.
# hier einen API key holen -> http://chuck-norris-witze.de/chuck-norris-auf-deiner-webseite
# und in der config.yml datei eingeben
# 
#      ladet das Plugin in der "./siriproxy/config.yml" datei !
#######
## ##  WIE ES FUNKTIONIERT 
#
# sagt einen Satz mit "Chuck" und/oder "Norris" -> zufälliges Spruch
#
# bei Fragen Twitter: @muhkuh0815
# oder github.com/muhkuh0815/siriproxy-chuck
# noch kein Video
#
#### ToDo
#
# aussprache von englischen begriffen (roundhousekick) verbessern.
#
#######

class SiriProxy::Plugin::Chuck< SiriProxy::Plugin
    
    def initialize(config)
    @key = config ["chuck_key"] 
    end
    def doc
    end
    def read()
      shaf = ""
      begin
	doc = Nokogiri::HTML(open("http://chuck-norris-witze.de/api.php?key=" + @key.to_s + "&o=1"))
	print @key
      rescue Timeout::Error
	print "Timeout-Error beim Lesen der Seite"
	shaf ="timeout"
      rescue
	print "Lesefehler !"
	shaf ="timeout"
      end
    if shaf =="timeout" 
    say "Es gab ein Problem beim einlesen der Daten!"
    else
    end
    doc = doc.text
    print doc
    print "##"
    return doc
    
    end

# random Zitat
listen_for /(Chuck norris|chuck|norris)/i do
  zitat = read() 
  if zitat == nil
    say "Fehler!" , spoken: ""
  else
    zit = zitat.to_s
    zitat1 = zitat.gsub("Chuck","tschak")
      say zitat.to_s, spoken: zitat1.to_s 
  end
  request_completed
end


end

