class CreateUsuarios < ActiveRecord::Migration[5.1]
  def change
    create_table :usuarios do |t|
      t.string :nome
      t.boolean :visitante
      t.datetime :data_nascimento
      t.string :matricula
      t.references :perfil, foreign_key: true

      t.timestamps
    end
  end
end
