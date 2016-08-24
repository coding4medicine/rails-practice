class SshkeysController < ApplicationController

  before_action :set_sshkey, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!

  # GET /sshkeys
  # GET /sshkeys.json
  def index
    @sshkeys = current_user.sshkeys.all
  end

  # GET /sshkeys/1
  # GET /sshkeys/1.json
  def show
    if current_user.id != Sshkey.find(params[:id]).user_id
    	redirect_to sshkeys_path
    end
  end

  # GET /sshkeys/new
  def new
    @sshkey = Sshkey.new
  end

  # GET /sshkeys/1/edit
  def edit
    if current_user.id != Sshkey.find(params[:id]).user_id
    	redirect_to sshkeys_path
    end
  end

  # POST /sshkeys
  # POST /sshkeys.json
  def create
    @sshkey = Sshkey.new(sshkey_params)
    @sshkey.user_id=current_user.id

    respond_to do |format|
      if @sshkey.save
        format.html { redirect_to @sshkey, notice: 'Sshkey was successfully created.' }
        format.json { render :show, status: :created, location: @sshkey }
      else
        format.html { render :new }
        format.json { render json: @sshkey.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /sshkeys/1
  # PATCH/PUT /sshkeys/1.json
  def update
    respond_to do |format|
      if @sshkey.update(sshkey_params)
        format.html { redirect_to @sshkey, notice: 'Sshkey was successfully updated.' }
        format.json { render :show, status: :ok, location: @sshkey }
      else
        format.html { render :edit }
        format.json { render json: @sshkey.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /sshkeys/1
  # DELETE /sshkeys/1.json
  def destroy
    @sshkey.destroy
    respond_to do |format|
      format.html { redirect_to sshkeys_url, notice: 'Sshkey was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_sshkey
      @sshkey = Sshkey.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def sshkey_params
      params.require(:sshkey).permit(:user_id, :key)
    end
end
