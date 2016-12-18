class RecordsController < ApplicationController
    #Bootstraping point of application
    #Like a main method in c, c++
    def index
        if params[:search]
            @records = Record.search(params[:search]).order("created_at DESC").paginate(:page => params[:page], :per_page => 10)
            @record_count = @records.count()
            @balance_sum = @records.where("amount > 0").sum(:amount)
            @debt_amount = @records.where("amount < 0").sum(:amount)
        else
            @records = Record.order("created_at DESC").paginate(:page => params[:page], :per_page => 10)
            @record_count = Record.count()
            @balance_sum = Record.where("amount > 0").sum(:amount)
            @debt_amount = Record.where("amount < 0").sum(:amount)
        end
        @total_amount = @balance_sum + @debt_amount
        
        
    end
    
    def new
        #...
    end
    
    def create
        @record = Record.create(record_params)
        if @record.valid?
            # Add flash message prompting record has been successfully added
            flash[:success] = "Congratulation!!! Your new record has been added successfully."
            redirect_to root_path
        else
            # Add flash message prompting record unable to add
            flash[:alert] = "Sorry invalid record!!! Please try again with correct input."
            redirect_to new_record_url
        end
    end
    
    def edit 
        @record = Record.find(params[:id])
    end
    
    def update
        @record = Record.find(params[:id])
        if @record.update(record_params)
            flash[:success] = "Congratulation!!! Your record has been updated successfully."
            redirect_to root_path
        else
            flash[:alert] = "Sorry invalid data!!! Please try again with correct input."
            redirect_to edit_record_path(params[:id])
        end
    end
    
    def destroy
        @record = Record.find(params[:id])
        @record.destroy
        flash[:success] = "Congratulation!!! Your record has been deleted successfully."
        redirect_to root_path
    end
    
    private
    
    def record_params
        params.require(:record).permit(:date, :title, :amount)
    end
end
