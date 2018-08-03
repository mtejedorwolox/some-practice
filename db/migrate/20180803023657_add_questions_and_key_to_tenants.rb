class AddQuestionsAndKeyToTenants < ActiveRecord::Migration[5.1]
  def change
    add_column :tenants, :api_key, :string
    add_reference :questions, :tenant, foreign_key: true
  end
end
