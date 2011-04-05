class RecipesController < ApplicationController
  before_filter :authenticate_user!, :only => [:new, :create]
  
  def index
    @page_title = "Recipe"
    @recipes = Recipe.paginate({:per_page => 9, :page => params[:page] || 1, :order => 'created_at desc'})
  end
  
  def show    
    @recipe = Recipe.find_by_slug_or_id(params[:id])        
    @page_title = @recipe.title
  end
  
  def new
    @recipe = Recipe.new
    @page_title = 'Create a New Recipe'
  end
  
  def create
    @recipe = Recipe.new(params[:recipe])
    @recipe.user = current_user
    if @recipe.save 
      redirect_to :action => 'index'
    else 
      render :action => 'new'
    end
  end
end
