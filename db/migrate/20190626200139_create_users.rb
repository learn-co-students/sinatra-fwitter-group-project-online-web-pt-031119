class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |aspects|
      aspects.string :username
      aspects.string :email
      aspects.string :password_digest
    end
  end
end