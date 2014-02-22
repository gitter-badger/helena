require 'spec_helper'

describe Helena::SurveysController do
  routes { Helena::Engine.routes }

  context 'without authorization' do
    before { ApplicationController.any_instance.stub(:can_administer?).and_return false }

    specify 'trying to edit a survey throws an error' do
      survey = create :survey
      expect { get :edit, id: survey }.to raise_error(ActionController::RoutingError, 'Access Denied')
    end

    specify 'trying to update a survey throws an error' do
      survey = create :survey
      expect { patch :update, id: survey }.to raise_error(ActionController::RoutingError, 'Access Denied')
    end

    specify 'trying to delete a survey throws an error' do
      survey = create :survey
      expect { delete :destroy, id: survey }.to raise_error(ActionController::RoutingError, 'Access Denied')
    end
  end
end
