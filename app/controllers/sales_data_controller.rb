class SalesDataController < ApplicationController

  def index
  end

  def create
    ActiveRecord::Base.transaction do
      sales_data = SalesDataParser.new(params[:sales_data]).parse
      @batch_total = sales_data.map { |e| 
        Sale.create_from_sales_data_row!(e)
      }.sum
      @all_time_total = Sale.sum(:total)
    end

    flash.now[:success] = "Processed successfully!"

    render "result"
  end

end
