class AddRequestsToTenants < ActiveRecord::Migration[5.1]
  def change
    add_column :tenants, :request, :bigint, default: 0
  end
end
