class StoresController < ApplicationController
  before_action :set_store, only: [:show, :edit, :update, :destroy]
                    #This is the scaffold that saves the data into the database
  # GET /stores
  # GET /stores.json
  def index
    @stores = Store.all
  end

  # GET /stores/1
  # GET /stores/1.json
  def show
  end

  # GET /stores/new
  def new
    @user_id = session[:user_id]
    @store = Store.new

    @store.alpha = 0.15
    @store.beta = 0.001
    @store.gamma = 0.25
    @store.delta = 0.00015
    @store.time = 50
    @store.timeincrement = 0.5

    respond_to do |format|
      format.html # new.html.erb
      format.html {render json: @store }
    end
  end

  # GET /stores/1/edit
  def edit
  end

  # POST /stores
  # POST /stores.json
  def create
    @user_id = session[:user_id]
    @store = Store.new(store_params)
    @store[:user_id] = @user_id
    respond_to do |format|
      if @store.save
        format.html { redirect_to url_for(:controller => "admin", :action => "edit", :save_id => @store.id ), notice: 'Saved!' }
        format.json { render :show, status: :created, location: @store }
      else
        format.html { redirect_to admin_url }
        format.json { render json: @store.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /stores/1
  # PATCH/PUT /stores/1.json
  def update
    respond_to do |format|
      if @store.update(store_params)
        format.html { redirect_to admin_url, notice: 'Saved!' }
        format.json { render :show, status: :ok, location: @store }
      else
        format.html { render :edit }
        format.json { render json: @store.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /stores/1
  # DELETE /stores/1.json
  def destroy
    @store.destroy
    respond_to do |format|
      format.html { redirect_to url_for(:controller => :admin, :action => :open), notice: 'Deleted!' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_store
      @store = Store.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def store_params
      params.require(:store).permit(:name, :predator, :prey, :alpha, :beta, :gamma, :delta, :time, :timeincrement, :user_id)
    end

    def flag_param
      params.require(:store).permit(:flag)
    end
end
