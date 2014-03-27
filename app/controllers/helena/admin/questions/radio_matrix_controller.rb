module Helena
  module Admin
    module Questions
      class RadioMatrixController < Admin::QuestionsController
        include Helena::Concerns::Questions::MatrixQuestions
      end
    end
  end
end
