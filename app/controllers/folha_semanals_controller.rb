class FolhaSemanalsController < ApplicationController
  before_action :set_folha_semanal, only: [:show, :edit, :update, :destroy]
  before_action :lista_usuario_turmas, only: [:index, :new]
  before_action :lista_usuario_turmas_todas, only: [:edit]

  # GET /folha_semanals
  # GET /folha_semanals.json
  def index
    @folha_semanals = FolhaSemanal.where("created_at >= datetime('2018-07-06 00:00:00 -03:00')")
  end

  # GET /folha_semanals/1
  # GET /folha_semanals/1.json
  def show
  end

  # GET /folha_semanals/new
  def new
    @folha_semanal = FolhaSemanal.new
  end

  # GET /folha_semanals/1/edit
  def edit
  end

  # POST /folha_semanals
  # POST /folha_semanals.json
  def create
    @folha_semanal = FolhaSemanal.new(folha_semanal_params)

    respond_to do |format|
      if @folha_semanal.save
        format.html {redirect_to @folha_semanal, notice: 'Folha semanal was successfully created.'}
        format.json {render :show, status: :created, location: @folha_semanal}
      else
        format.html {render :new}
        format.json {render json: @folha_semanal.errors, status: :unprocessable_entity}
      end
    end
  end

  # PATCH/PUT /folha_semanals/1
  # PATCH/PUT /folha_semanals/1.json
  def update
    respond_to do |format|
      if @folha_semanal.update(folha_semanal_params)
        format.html {redirect_to @folha_semanal, notice: 'Folha semanal was successfully updated.'}
        format.json {render :show, status: :ok, location: @folha_semanal}
      else
        format.html {render :edit}
        format.json {render json: @folha_semanal.errors, status: :unprocessable_entity}
      end
    end
  end

  # DELETE /folha_semanals/1
  # DELETE /folha_semanals/1.json
  def destroy
    @folha_semanal.destroy
    respond_to do |format|
      format.html {redirect_to folha_semanals_url, notice: 'Folha semanal was successfully destroyed.'}
      format.json {head :no_content}
    end
  end

  private

  def lista_usuario_turmas
    @usuarios_registrados_hoje = UsuarioTurma.select("*").joins("join folha_semanals on usuario_turmas.id = folha_semanals.usuario_turma_id").where("folha_semanals.created_at BETWEEN datetime('2018-07-06 00:00:00 -03:00') and datetime('2018-07-06 23:59:59 -03:00')");
    @lista_usuario_turmas = UsuarioTurma.select("usuarios.nome, usuario_turmas.id").joins("JOIN usuarios ON usuarios.id = usuario_turmas.usuario_id").where("usuario_turmas.id not in (#{@usuarios_registrados_hoje.ids.inspect.delete "]" "["})")
  end

  def lista_usuario_turmas_todas
    @lista_usuario_turmas = UsuarioTurma.select("usuarios.nome, usuario_turmas.id").joins("JOIN usuarios ON usuarios.id = usuario_turmas.usuario_id")
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_folha_semanal
    @folha_semanal = FolhaSemanal.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def folha_semanal_params
    params.require(:folha_semanal).permit(:usuario_turma_id, :presente, :trouxe_biblia, :trouxe_licao, :capitulos_lidos, :oferta)
  end
end
