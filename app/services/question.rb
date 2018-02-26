FILENAME = "#{Rails.root}/app/services/questions.yaml"

class Question
  attr_accessor :id, :question, :answer, :options

  def self.load_questions
    YAML::load(File.open(FILENAME))
  end

  def self.get_all
    self.load_questions
  end

  def self.get_by_id(id)
    self.load_questions.select{ |x| x.id == id.to_i }[0]
  end
end
