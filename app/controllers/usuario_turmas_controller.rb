class UsuarioTurmasController < ApplicationController
  before_action :set_usuario_turma, only: [:show, :edit, :update, :destroy]

  # GET /usuario_turmas
  # GET /usuario_turmas.json
  def index
    @usuario_turmas = UsuarioTurma.all
  end

  # GET /usuario_turmas/1
  # GET /usuario_turmas/1.json
  def show
  end

  # GET /usuario_turmas/new
  def new
    @usuario_turma = UsuarioTurma.new
    lista_turmas_e_usuarios
  end

  # GET /usuario_turmas/1/edit
  def edit
    lista_turmas_e_usuarios
  end

  # POST /usuario_turmas
  # POST /usuario_turmas.json
  def create
    @usuario_turma = UsuarioTurma.new(usuario_turma_params)

    respond_to do |format|
      if @usuario_turma.save
        format.html { redirect_to @usuario_turma, notice: 'Usuario turma was successfully created.' }
        format.json { render :show, status: :created, location: @usuario_turma }
      else
        format.html { render :new }
        format.json { render json: @usuario_turma.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /usuario_turmas/1
  # PATCH/PUT /usuario_turmas/1.json
  def update
    respond_to do |format|
      if @usuario_turma.update(usuario_turma_params)
        format.html { redirect_to @usuario_turma, notice: 'Usuario turma was successfully updated.' }
        format.json { render :show, status: :ok, location: @usuario_turma }
      else
        format.html { render :edit }
        format.json { render json: @usuario_turma.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /usuario_turmas/1
  # DELETE /usuario_turmas/1.json
  def destroy
    @usuario_turma.destroy
    respond_to do |format|
      format.html { redirect_to usuario_turmas_url, notice: 'Usuario turma was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_usuario_turma
      @usuario_turma = UsuarioTurma.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def usuario_turma_params
      params.require(:usuario_turma).permit(:turma_id, :usuario_id)
    end

    def lista_turmas_e_usuarios
      @lista_turmas = Turma.all
      @lista_usuarios = Usuario.all
    end
end
