class PinsController < ApplicationController
  before_action :set_pin, only: [:show, :edit, :update, :destroy]
  before_action :correct_user, only: [:edit, :update, :destroy]
  #before_action :authenticate_user!, only: [:new, :create, :edit, :update]
  before_action :authenticate_user!, except: [:index, :show]

  # GET /pins
  #Read All
  def index
    @pins = Pin.all.order("created_at desc").paginate(:page => params[:page], :per_page => 8)
  end

  # GET /pins/1
  #Read
  def show
  end

  # GET /pins/new
  #Prep For Create
  def new
    #@pin = Pin.new
    @pin = current_user.pins.build
  end
  
  # POST /pins
  # Create
  def create
    # @pin = Pin.new(pin_params)
    @pin = current_user.pins.build(pin_params)
    if @pin.save
      redirect_to @pin, notice: 'Pin was successfully created.'
    else
      render :new
    end
    
  end


  # GET /pins/1/edit
  #Prep for Update
  def edit
  end

  # PATCH/PUT /pins/1
  #Update
  def update
    if @pin.update(pin_params)
      redirect_to @pin, notice: 'Pin was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /pins/1
  #Destroy
  def destroy
    @pin.destroy
    redirect_to pins_url, notice: 'Pin was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_pin
      @pin = Pin.find(params[:id])
    end

    def correct_user
      @pin = current_user.pins.find_by(id: params[:id])  # look up pin for user to see if it belongs to current user
      redirect_to pins_path, notice: "Not Authorized to edit this pin" if @pin.nil?
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def pin_params
      params.require(:pin).permit(:description, :image)

    end
end
