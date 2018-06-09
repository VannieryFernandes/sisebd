require 'test_helper'

class FolhaSemanalsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @folha_semanal = folha_semanals(:one)
  end

  test "should get index" do
    get folha_semanals_url
    assert_response :success
  end

  test "should get new" do
    get new_folha_semanal_url
    assert_response :success
  end

  test "should create folha_semanal" do
    assert_difference('FolhaSemanal.count') do
      post folha_semanals_url, params: { folha_semanal: { capitulos_lidos: @folha_semanal.capitulos_lidos, presente: @folha_semanal.presente, trouxe_biblia: @folha_semanal.trouxe_biblia, trouxe_licao: @folha_semanal.trouxe_licao, usuario_turma_id: @folha_semanal.usuario_turma_id } }
    end

    assert_redirected_to folha_semanal_url(FolhaSemanal.last)
  end

  test "should show folha_semanal" do
    get folha_semanal_url(@folha_semanal)
    assert_response :success
  end

  test "should get edit" do
    get edit_folha_semanal_url(@folha_semanal)
    assert_response :success
  end

  test "should update folha_semanal" do
    patch folha_semanal_url(@folha_semanal), params: { folha_semanal: { capitulos_lidos: @folha_semanal.capitulos_lidos, presente: @folha_semanal.presente, trouxe_biblia: @folha_semanal.trouxe_biblia, trouxe_licao: @folha_semanal.trouxe_licao, usuario_turma_id: @folha_semanal.usuario_turma_id } }
    assert_redirected_to folha_semanal_url(@folha_semanal)
  end

  test "should destroy folha_semanal" do
    assert_difference('FolhaSemanal.count', -1) do
      delete folha_semanal_url(@folha_semanal)
    end

    assert_redirected_to folha_semanals_url
  end
end
