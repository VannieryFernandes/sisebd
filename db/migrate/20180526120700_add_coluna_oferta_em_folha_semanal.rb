class AddColunaOfertaEmFolhaSemanal < ActiveRecord::Migration[5.1]
  def change
    add_column :folha_semanals, :oferta, :string
  end
end