class Record < ActiveRecord::Base
    #Form validation for Record
    validates :date, :title, :amount, presence: true
    
    #Search method with class level scope
    def self.search(search)
      where("title ILIKE?", "%#{search}%")
    end
    
    #Balance sum method with class level scope
    def self.balance
      where("amount > 0").sum(:amount)
    end
    
    #Debt method with class level scope
    def self.debt
      where("amount < 0").sum(:amount)
    end
end
