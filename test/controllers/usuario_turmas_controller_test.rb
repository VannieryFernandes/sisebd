require 'test_helper'

class UsuarioTurmasControllerTest < ActionDispatch::IntegrationTest
  setup do
    @usuario_turma = usuario_turmas(:one)
  end

  test "should get index" do
    get usuario_turmas_url
    assert_response :success
  end

  test "should get new" do
    get new_usuario_turma_url
    assert_response :success
  end

  test "should create usuario_turma" do
    assert_difference('UsuarioTurma.count') do
      post usuario_turmas_url, params: { usuario_turma: { turma_id: @usuario_turma.turma_id, usuario_id: @usuario_turma.usuario_id } }
    end

    assert_redirected_to usuario_turma_url(UsuarioTurma.last)
  end

  test "should show usuario_turma" do
    get usuario_turma_url(@usuario_turma)
    assert_response :success
  end

  test "should get edit" do
    get edit_usuario_turma_url(@usuario_turma)
    assert_response :success
  end

  test "should update usuario_turma" do
    patch usuario_turma_url(@usuario_turma), params: { usuario_turma: { turma_id: @usuario_turma.turma_id, usuario_id: @usuario_turma.usuario_id } }
    assert_redirected_to usuario_turma_url(@usuario_turma)
  end

  test "should destroy usuario_turma" do
    assert_difference('UsuarioTurma.count', -1) do
      delete usuario_turma_url(@usuario_turma)
    end

    assert_redirected_to usuario_turmas_url
  end
end
