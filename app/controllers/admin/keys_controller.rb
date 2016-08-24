class Admin::KeysController < ApplicationController
  before_action :set_key, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_admin!

  def index
	@keys=Sshkey.all
  end

  # GET /keys/1
  # GET /keys/1.json
  def show
  end

  # GET /keys/new
  def new
    @key = Sshkey.new
  end

  # GET /keys/1/edit
  def edit
  end

  # POST /keys
  # POST /keys.json
  def create
    respond_to do |format|
      if @key.save
        format.html { redirect_to @key, notice: 'Sshkey was successfully created.' }
        format.json { render :show, status: :created, location: @key }
      else
        format.html { render :new }
        format.json { render json: @key.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /keys/1
  # PATCH/PUT /keys/1.json
  def update
    respond_to do |format|
      if @key.update(key_params)
        format.html { redirect_to @key, notice: 'Sshkey was successfully updated.' }
        format.json { render :show, status: :ok, location: @key }
      else
        format.html { render :edit }
        format.json { render json: @key.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /keys/1
  # DELETE /keys/1.json
  def destroy
    @key.destroy
    respond_to do |format|
      format.html { redirect_to keys_url, notice: 'Sshkey was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_key
      @key = Sshkey.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def key_params
      params.require(:key).permit(:user_id, :key)
    end
end
