require "v2_map"
class MappingsController < ApplicationController
  def index
    @maps = Mapping.new
    @maps.parse_data
  end

  def new
    @map = Mapping.new
    @map.add_map(params[:name],params[:filters])
    
    flash[:notice] = "New Map was Successfully created..."
    
    respond_to do |format|
      format.html
    end
  end
  
  def edit
    
    @maps = Mapping.new
    @maps.parse_data
    
    respond_to do |format|
      format.js
    end
    
  end
end
