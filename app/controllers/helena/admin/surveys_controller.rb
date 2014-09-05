require_dependency 'helena/application_controller'

module Helena
  module Admin
    class SurveysController < Admin::ApplicationController
      respond_to :html

      before_filter :add_breadcrumbs
      before_filter :load_survey, only: [:edit, :update, :move_up, :move_down, :destroy]

      def index
        @surveys = Helena::Survey.asc :position
      end

      def new
        add_breadcrumb t('helena.admin.surveys.new')
        @survey = Helena::Survey.new
        @survey.versions.build version: 0, survey_detail: Helena::SurveyDetail.new, file_resources: [Helena::FileResource.new]
      end

      def create
        add_breadcrumb t('helena.admin.surveys.new')

        @survey = Helena::Survey.new survey_params

        if @survey.save
          notify_successful_create_for(@survey.name)
        else
          notify_error
        end
        respond_with @survey, location: admin_surveys_path
      end

      def edit
        add_breadcrumb @survey.name

        @survey.draft_version.file_resources.build
      end

      def update
        if @survey.update_attributes survey_params
          notify_successful_update_for(@survey.name)
        else
          notify_error @survey
          add_breadcrumb @survey.name_was
        end
        respond_with @survey, location: admin_surveys_path
      end

      def move_up
        @survey.move_to! :higher
        respond_with @survey, location: admin_surveys_path
      end

      def move_down
        @survey.move_to! :lower
        respond_with @survey, location: admin_surveys_path
      end

      def destroy
        notify_successful_delete_for(@survey.name) if @survey.destroy
        respond_with @survey, location: admin_surveys_path
      end

      private

      def add_breadcrumbs
        add_breadcrumb Helena::Survey.model_name.human(count: 2), :admin_surveys_path
      end

      def versions_attributes
        [:version,
         :id,
         survey_detail_attributes: survey_detail_attributes,
         file_resources_attributes: file_resources_attributes]
      end

      def survey_detail_attributes
        [:title, :description]
      end

      def file_resources_attributes
        [:id, :source, :_destroy]
      end

      def survey_params
        params.require(:survey).permit(:name, :tag_list, :language, versions_attributes: versions_attributes)
      end

      def load_survey
        @survey = Helena::Survey.find params[:id]
      end
    end
  end
end
