module Classifier
  module FastText
    require "open3"

    CLASSIFIERS_DIR = Rails.configuration.classifiers['classifiers_dir']
    FAST_TEXT_DIR = Rails.configuration.classifiers['fast_text_path']

  	def self.train
      OffTopic.distinct.pluck(:language_code).each do |language_code|
        training_file_path = "#{CLASSIFIERS_DIR}/#{language_code}_training.txt"
        model_file_path = "#{CLASSIFIERS_DIR}/#{language_code}_model"
        pretrained_vectors_file_path = "#{FAST_TEXT_DIR}/pretrained_vectors/wiki.#{language_code}.vec"
  
        # writing training data to file
        File.open(training_file_path, 'w') do |file|
          OffTopic.where(language_code: language_code).each do |ot|
            ot.training_messages.each do |tm|
              file.write "__label__#{ot.id} #{tm.text}\n"
            end
          end
        end
  
        begin
          stdout, stderr, status = Open3.capture3("#{FAST_TEXT_DIR}/fasttext supervised -dim 300 -pretrainedVectors #{pretrained_vectors_file_path} -input #{training_file_path} -output #{model_file_path}")
          raise stderr unless status.success?
        ensure
          File.delete(training_file_path) if File.exists? training_file_path # cleanup - remove training file
        end

      end
    end

    def self.predict(text, language_code)
      model_file_path = "#{CLASSIFIERS_DIR}/#{language_code}_model.bin"

      if File.exists? model_file_path
      
        o, s = Open3.capture2("#{FAST_TEXT_DIR}/fasttext predict-prob #{model_file_path} -", stdin_data: text)
        
        label, probability = o.split(" ")
        off_topic_id = label.to_s[9..-1] # strip __label__
        off_topic_id = off_topic_id.to_i unless off_topic_id.nil?
      else
        off_topic_id = nil
        probability = nil
      end
  
      return off_topic_id, probability.to_f

    end

    def self.reset(language_code)
      model_file_path = "#{CLASSIFIERS_DIR}/#{language_code}_model.bin"
      File.delete(model_file_path) if File.exists? model_file_path # cleanup - remove model
    end
  end
end
