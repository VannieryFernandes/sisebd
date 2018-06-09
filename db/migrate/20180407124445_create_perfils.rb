class CreatePerfils < ActiveRecord::Migration[5.1]
  def change
    create_table :perfils do |t|
      t.string :nome

      t.timestamps
    end
  end
end
