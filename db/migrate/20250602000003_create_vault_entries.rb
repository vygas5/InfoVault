class CreateVaultEntries < ActiveRecord::Migration[8.1]
  def change
    create_table :vault_entries do |t|
      t.references :user, null: false, foreign_key: true
      t.string :title, null: false
      t.text :body
      t.integer :kind, null: false, default: 0

      t.timestamps
    end
  end
end
