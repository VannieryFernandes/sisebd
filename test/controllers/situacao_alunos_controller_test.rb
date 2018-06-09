require 'test_helper'

class SituacaoAlunosControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get situacao_alunos_index_url
    assert_response :success
  end

end
