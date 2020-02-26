class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |x|
      x.string :username
      x.string :password
      x.decimal :balance
    end
  end
end
