class AddJtiToUsers < ActiveRecord::Migration[8.0]
  def change
    # Add the column with a default value to avoid null violations
    add_column :users, :jti, :string, null: false, default: -> { "gen_random_uuid()" }

    # Create a unique index on the :jti column
    add_index :users, :jti, unique: true
  end
end