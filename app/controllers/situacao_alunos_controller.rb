require 'date'

class SituacaoAlunosController < ApplicationController
  def index
    self.alunos_desmatriculados
    self.alunos_matriculados
  end

  def alunos_desmatriculados
    # query = "JOIN usuario_turmas ON usuario_turmas.usuario_id = usuarios.id
    #          JOIN folha_semanals ON folha_semanals.usuario_turma_id = usuario_turmas.id
    #         WHERE (folha_semanals.created_at >= DATE('2018-04-01') AND
    #          folha_semanals.created_at <= DATE('2018-04-23')) and
    #          folha_semanals.presente = 'f' AND visitante = 'f' order by usuarios.nome;"

   query = "JOIN usuario_turmas ON usuario_turmas.usuario_id = usuarios.id
            JOIN folha_semanals ON folha_semanals.usuario_turma_id = usuario_turmas.id
           WHERE (folha_semanals.created_at >= DATE(#{(Time.now - 4.weeks).strftime("%Y-%m-%d")}) AND
            folha_semanals.created_at <= DATE(#{(Time.now + 1.days).strftime("%Y-%m-%d")})) and
            folha_semanals.presente = 'f' AND visitante = 'f' order by usuarios.nome;"

    alunos_desmatriculados_dados_brutos = Usuario.joins(query)
    @alunos_desmatriculados_dados_tratados = Array.new

    auxUser = ""
    contador = 0

    alunos_desmatriculados_dados_brutos.each do |usuario|
      if usuario.nome != auxUser
        auxUser = usuario.nome
        contador = 1
      elsif usuario.nome == auxUser
        contador += 1
      end
      if contador == 4
        @alunos_desmatriculados_dados_tratados.push (usuario.id).to_s+"-"+(usuario.nome).to_s
        Usuario.where(id: usuario.id).update_all("visitante = 't'")
      end
    end
  end

  def alunos_matriculados
    # query = "JOIN usuario_turmas ON usuario_turmas.usuario_id = usuarios.id
    #         JOIN folha_semanals ON folha_semanals.usuario_turma_id = usuario_turmas.id
    #       WHERE (folha_semanals.created_at >= DATE('2018-04-08') AND
    #         folha_semanals.created_at <= DATE('2018-04-23')) and
    #         folha_semanals.presente = 't' AND visitante = 't' order by usuarios.nome;"

   query = "JOIN usuario_turmas ON usuario_turmas.usuario_id = usuarios.id
           JOIN folha_semanals ON folha_semanals.usuario_turma_id = usuario_turmas.id
         WHERE (folha_semanals.created_at >= DATE(#{(Time.now - 3.weeks).strftime("%Y-%m-%d")}) AND
           folha_semanals.created_at <= DATE(#{(Time.now + 1.days).strftime("%Y-%m-%d")})) and
           folha_semanals.presente = 't' AND visitante = 't' order by usuarios.nome;"

    alunos_matriculados_dados_brutos = Usuario.joins(query)
    @alunos_matriculados_dados_tratados = Array.new

    auxUser = ""
    contador = 0

    alunos_matriculados_dados_brutos.each do |usuario|
      if usuario.nome != auxUser
        auxUser = usuario.nome
        contador = 1
      elsif usuario.nome == auxUser
        contador += 1
      end
      if contador == 3
        @alunos_matriculados_dados_tratados.push (usuario.id).to_s+"-"+(usuario.nome).to_s
        Usuario.where(id: usuario.id).update_all("visitante = 'f'")
      end
    end
  end
end