class RelatorioDiarioController < ApplicationController
  def index
    self.relatorio_diario
    self.aniversariantes_da_semana
  end

  def relatorio_diario
#    relatorio_diario_dados_brutos = UsuarioTurma.select("*").joins(:turma, :folha_semanal).where("folha_semanals.created_at BETWEEN datetime('2018-04-08 00:00:00') AND datetime('2018-04-09 23:59:59')")
    relatorio_diario_dados_brutos = UsuarioTurma.select("turmas.id, turmas.nome, folha_semanals.presente, folha_semanals.capitulos_lidos, folha_semanals.trouxe_licao, folha_semanals.trouxe_biblia, folha_semanals.oferta, usuarios.visitante").joins("JOIN folha_semanals ON folha_semanals.usuario_turma_id = usuario_turmas.id JOIN turmas ON turmas.id = usuario_turmas.turma_id JOIN usuarios ON usuarios.id = usuario_turmas.usuario_id").where("folha_semanals.created_at BETWEEN datetime('2018-05-26 00:00:00') AND datetime('2018-06-17 23:59:59')").order("turmas.id")
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
        :auxVisitante => 0,
        :auxOferta => 0
    }

    vetorAuxTotal = {
        :auxNomeTurma => "Total",
        :auxCapLidos => 0,
        :auxPresente => 0,
        :auxAuxente => 0,
        :auxTrouxeBiblia => 0,
        :auxNaoTrouxeBiblia => 0,
        :auxTrouxeLicao => 0,
        :auxNaoTrouxeLicao => 0,
        :auxVisitante => 0,
        :auxOferta => 0
    }

    relatorio_diario_dados_brutos.each do |infoTurma|
      if infoTurma.id != auxVar and auxVar != 0
        auxVar = infoTurma.id
        @relatorio_diario_dados_tratados.push(vetorAux[:auxNomeTurma] + "-" + vetorAux[:auxCapLidos].to_s + "-" + vetorAux[:auxPresente].to_s + "-" + vetorAux[:auxAuxente].to_s + "-" + vetorAux[:auxTrouxeBiblia].to_s + "-" + vetorAux[:auxNaoTrouxeBiblia].to_s + "-" + vetorAux[:auxTrouxeLicao].to_s + "-" + vetorAux[:auxNaoTrouxeLicao].to_s + "-" + vetorAux[:auxOferta].to_s + "-" + vetorAux[:auxVisitante].to_s)
        vetorAux.each {|key, value| vetorAux[key] = vetorAux[key].class == String ? "" : 0}
      end
      auxVar = infoTurma.id
      if infoTurma.id == auxVar
        #Nome da turma
        infoTurma.nome == vetorAux[:auxNomeTurma] ? infoTurma.nome : vetorAux[:auxNomeTurma] = infoTurma.nome

        #Capítulos lidos
        infoTurma.capitulos_lidos = infoTurma.capitulos_lidos.nil? ? 0 : infoTurma.capitulos_lidos
        vetorAux[:auxCapLidos] += infoTurma.capitulos_lidos
        vetorAuxTotal[:auxCapLidos] += infoTurma.capitulos_lidos

        #Oferta
        infoTurma.oferta = infoTurma.oferta.nil? ? 0 : infoTurma.oferta
        vetorAux[:auxOferta] += infoTurma.oferta.to_f
        vetorAuxTotal[:auxOferta] += infoTurma.oferta.to_f

        #Presentes e auxentes
        if infoTurma.presente == 't'
          vetorAux[:auxPresente] += 1
          vetorAuxTotal[:auxPresente] += 1
        else
          vetorAux[:auxAuxente] += 1
          vetorAuxTotal[:auxAuxente] += 1
        end

        #Trouxe e não trouxe bíblia
        if infoTurma.trouxe_biblia == 't'
          vetorAux[:auxTrouxeBiblia] += 1
          vetorAuxTotal[:auxTrouxeBiblia] += 1
        else
          vetorAux[:auxNaoTrouxeBiblia] += 1
          vetorAuxTotal[:auxNaoTrouxeBiblia] += 1
        end

        #Trouxe e não trouxe lição
        if infoTurma.trouxe_licao == 't'
          vetorAux[:auxTrouxeLicao] += 1
          vetorAuxTotal[:auxTrouxeLicao] += 1
        else
          vetorAux[:auxNaoTrouxeLicao] += 1
          vetorAuxTotal[:auxNaoTrouxeLicao] += 1
        end

        #Visitante
        if infoTurma.visitante == 't'
          vetorAux[:auxVisitante] += 1
          vetorAuxTotal[:auxVisitante] += 1
        end
      end
    end
    @relatorio_diario_dados_tratados.push(vetorAux[:auxNomeTurma] + "-" + vetorAux[:auxCapLidos].to_s + "-" + vetorAux[:auxPresente].to_s + "-" + vetorAux[:auxAuxente].to_s + "-" + vetorAux[:auxTrouxeBiblia].to_s + "-" + vetorAux[:auxNaoTrouxeBiblia].to_s + "-" + vetorAux[:auxTrouxeLicao].to_s + "-" + vetorAux[:auxNaoTrouxeLicao].to_s + "-" + vetorAux[:auxOferta].to_s + "-" + vetorAux[:auxVisitante].to_s)
    @relatorio_diario_dados_tratados.push(vetorAuxTotal[:auxNomeTurma] + "-" + vetorAuxTotal[:auxCapLidos].to_s + "-" + vetorAuxTotal[:auxPresente].to_s + "-" + vetorAuxTotal[:auxAuxente].to_s + "-" + vetorAuxTotal[:auxTrouxeBiblia].to_s + "-" + vetorAuxTotal[:auxNaoTrouxeBiblia].to_s + "-" + vetorAuxTotal[:auxTrouxeLicao].to_s + "-" + vetorAuxTotal[:auxNaoTrouxeLicao].to_s + "-" + vetorAuxTotal[:auxOferta].to_s + "-" + vetorAuxTotal[:auxVisitante].to_s)
  end

  def aniversariantes_da_semana
    @aniversariantes_da_semana = Usuario.where("strftime('%m-%d', data_nascimento) BETWEEN '02-06' and '06-30'")
  end
end