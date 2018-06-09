class CreateFolhaSemanals < ActiveRecord::Migration[5.1]
  def change
    create_table :folha_semanals do |t|
      t.references :usuario_turma, foreign_key: true
      t.boolean :presente
      t.boolean :trouxe_biblia
      t.boolean :trouxe_licao
      t.integer :capitulos_lidos

      t.timestamps
    end
  end
end
