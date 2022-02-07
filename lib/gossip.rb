require 'csv'

class Gossip
#initialisation des paramètres de la classe Gossip
  attr_accessor :author, :content
  def initialize(author, content)
    @author = author
    @content = content
  end

#mise en place de la méthode pour save le contenu du formulaire
  def save
    CSV.open("./db/gossip.csv", "ab") do |csv|
      csv << [@author, @content]
    end
  end

#méthode pour afficher la totalité des potins
  def self.all
    all_gossips = []
    CSV.read("./db/gossip.csv").each do |csv_line|

    all_gossips << Gossip.new(csv_line[0], csv_line[1])
    end
  return all_gossips
  end

#méthode permettant d'afficher un gossip grâce à son id
  def self.find(id)
    return self.all[id]
  end

#méthode pour editer un potin
  def self.update(id,update)
    position = id.to_i
    gossips = self.all
    CSV.open("./db/gossip.csv", "w") do |csv|
      gossips.each.with_index do |i| 
        if position == gossips.index(i)
          csv << [i.author, update]
        else
          csv << [i.author, i.content]
        end
      end
    end

  end
end
