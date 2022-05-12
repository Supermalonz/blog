class CreateComments < ActiveRecord::Migration[7.0]
  def change
    create_table :comments do |t|
      t.string :title, default: '', null: false
      t.text :body, default: '', null: false
      t.references :article

      t.timestamps
    end
  end
end
