class CreateLessonTopics < ActiveRecord::Migration[8.0]
  def change
    create_table :lesson_topics do |t|
      t.references :lesson, foreign_key: true
      t.references :topic, foreign_key: true

      t.timestamps
    end
  end
end
