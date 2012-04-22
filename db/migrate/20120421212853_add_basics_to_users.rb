class AddBasicsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :name, :string

    add_column :users, :title, :string

    add_column :users, :dept, :string

    add_column :users, :projects, :string

    add_column :users, :bio, :text

  end
end
