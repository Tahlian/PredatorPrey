class AdminController < ApplicationController
  def index                    #This is the controller that is supposed to interact with the user
    @user_id = session[:user_id] #once he is logged in

    if session[:save_id] === nil
      @store = Store.new
      @store.alpha = 0.15
      @store.beta = 0.001
      @store.gamma = 0.25
      @store.delta = 0.00015
      @store.time = 50
      @store.timeincrement = 0.5
    else
      
      @store = Store.find(session[:save_id])
    end
      respond_to do |format|
      format.html # new.html.erb
      format.html {render json: @store }
    end
  end

  def save
    @user_id = session[:user_id]

    if admin_params[:flag] === "update"
      respond_to do |format|
      if :flag === "update"  #@store.update(store_params)
        session[:save_id] = @store[:id]
        format.html { redirect_to url_for(:controller => :store, :action => :update)}
      elsif :flag === "save"
        format.html { redirect_to url_for(:controller => :store, :action => :create)}
      end
      end
    elsif admin_params[:flag] === "save"
      @store = Store.new(store_params)

      respond_to do |format|
      if @store.save
        session[:save_id] = @store[:id]
        format.html { redirect_to admin_url, notice: 'Store was successfully created.' }
        format.json { render :show, status: :created, location: @store }
      else
        format.html { render :new }
        format.json { render json: @store.errors, status: :unprocessable_entity }
      end
      end
    end
  end

  def open
   @user_id = session[:user_id]

   @stores = Store.where(user_id: @user_id) 
  end

  def edit
   @user_id = session[:user_id]
   session[:save_id] = params[:save_id]

   respond_to do |format|
     format.html {redirect_to admin_url }
   end
  end 

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_store
      @store = Store.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def admin_params
      params.require(:store).permit(:name, :predator, :prey, :alpha, :beta, :gamma, :delta, :time, :timeincrement, :user_id, :flag)
    end
    
    def store_params
      params.require(:store).permit(:name, :predator, :prey, :alpha, :beta, :gamma, :delta, :time, :timeincrement)
    end 
end
