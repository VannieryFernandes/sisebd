class CreateUsuarioTurmas < ActiveRecord::Migration[5.1]
  def change
    create_table :usuario_turmas do |t|
      t.references :turma, foreign_key: true
      t.references :usuario, foreign_key: true

      t.timestamps
    end
  end
end
