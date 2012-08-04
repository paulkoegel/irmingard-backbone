class CreateGames < ActiveRecord::Migration

  def change
    create_table 'games', :force => true do |t|
      t.string :state
      t.timestamps
    end
  end

end
