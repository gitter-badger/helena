module Helena
  module Admin
    module Questions
      class RadioGroupsController < Admin::QuestionsController
        private

        def labels_attributes
          [:id, :position, :text, :value, :preselected, :_destroy]
        end

        def question_params
          params.require(:questions_radio_group).permit(:question_text,
                                                        :code,
                                                        :type,
                                                        :required,
                                                        labels_attributes: labels_attributes).merge(survey_id: @survey.id)
        end
      end
    end
  end
end
