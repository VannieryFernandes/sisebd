class UsuarioTurma < ApplicationRecord
  belongs_to :turma
  belongs_to :usuario
end
