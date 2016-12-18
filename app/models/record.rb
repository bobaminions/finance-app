class Record < ActiveRecord::Base
    #Form validation for Record
    validates :date, :title, :amount, presence: true
    
    #Search method with class level scope
    def self.search(search)
      where("title ILIKE?", "%#{search}%")
    end
end
