class CreateZaimApis < ActiveRecord::Migration
  def change
    create_table :zaim_apis do |t|
      t.string :access_token
      t.string :access_token_secret

      t.timestamps
    end
  end
end
