class RelatorioDiarioController < ApplicationController
  def index
    self.relatorio_diario
  end

  def relatorio_diario
#    relatorio_diario_dados_brutos = UsuarioTurma.select("*").joins(:turma, :folha_semanal).where("folha_semanals.created_at BETWEEN datetime('2018-04-08 00:00:00') AND datetime('2018-04-09 23:59:59')")
    relatorio_diario_dados_brutos = UsuarioTurma.select("turmas.id, turmas.nome, folha_semanals.presente, folha_semanals.capitulos_lidos, folha_semanals.trouxe_licao, folha_semanals.trouxe_biblia, folha_semanals.oferta").joins("JOIN folha_semanals ON folha_semanals.usuario_turma_id = usuario_turmas.id JOIN turmas ON turmas.id = usuario_turmas.turma_id").where("folha_semanals.created_at BETWEEN datetime('2018-05-26 00:00:00') AND datetime('2018-06-17 23:59:59')").order("turmas.id")
    @relatorio_diario_dados_tratados = Array.new

    auxVar = 0

    vetorAux = {
        :auxNomeTurma => "",
        :auxCapLidos => 0,
        :auxPresente => 0,
        :auxAuxente => 0,
        :auxTrouxeBiblia => 0,
        :auxNaoTrouxeBiblia => 0,
        :auxTrouxeLicao => 0,
        :auxNaoTrouxeLicao => 0,
        :auxOferta => 0
    }

    relatorio_diario_dados_brutos.each do |infoTurma|
      if infoTurma.id != auxVar
        auxVar = infoTurma.id
        @relatorio_diario_dados_tratados.push(vetorAux[:auxCapLidos].to_s + "-" + vetorAux[:auxPresente].to_s + "-" + vetorAux[:auxAuxente].to_s)
        vetorAux.each {|key, value| vetorAux[key] = vetorAux[key].class == String ? "" : 0 }
      end
      if infoTurma.id == auxVar
        infoTurma.capitulos_lidos = infoTurma.capitulos_lidos.nil? ? 0 : infoTurma.capitulos_lidos
        vetorAux[:auxCapLidos] += infoTurma.capitulos_lidos
        infoTurma.presente == 't' ? vetorAux[:auxPresente] += 1 : vetorAux[:auxAuxente] += 1
      end
    end
    @relatorio_diario_dados_tratados.push(vetorAux[:auxCapLidos].to_s + "-" + vetorAux[:auxPresente].to_s + "-" + vetorAux[:auxAuxente].to_s)
    p @relatorio_diario_dados_tratados
  end
end