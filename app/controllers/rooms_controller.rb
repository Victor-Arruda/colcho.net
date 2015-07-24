class RoomsController < ApplicationController
  before_action :set_room, only: [:show]
  before_action :set_users_room, only: [:edit, :update, :destroy]
  before_action :require_authentication, only: [:new, :edit, :create, :update, :destroy]

  def index
    @rooms = Room.most_recent.map do |room|
      RoomPresenter.new(room, self, false)
    end
  end

  def show
    if user_signed_in?
      @user_review = @room.reviews.
        find_or_initialize_by(user_id: current_user.id)
    end
  end

  # GET /rooms/new
  def new
    @room = current_user.rooms.build
  end

  # GET /rooms/1/edit
  def edit
  end

  # POST /rooms
  # POST /rooms.json
  def create
    @room = current_user.rooms.build(room_params)

      if @room.save
        redirect_to @room, notice: t('flash.notice.room_created')
      else
        render :new
      end
  end

  # PATCH/PUT /rooms/1
  # PATCH/PUT /rooms/1.json
  def update

      if @room.update(room_params)
        redirect_to @room, notice: t('flash.notice.room_updated')
      else
        render :edit
      end
  end

  # DELETE /rooms/1
  # DELETE /rooms/1.json
  def destroy
    @room.destroy
      redirect_to rooms_url
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_room
      room_model = Room.find(params[:id])
      @room = RoomPresenter.new(room_model, self)
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def room_params
      params.require(:room).permit(:title, :location, :description)
    end

    def set_users_room
      @room = current_user.rooms.find(params[:id])

    end
end
