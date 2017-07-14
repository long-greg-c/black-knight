class VersionsController < ApplicationController
  before_action :authenticate_user!

  before_filter :load_current_environment

  def show
  	@config_version = load_current_config_file.audits.where(version: params[:id]).first
    render json: @config_version
  end

  def index
    @config_versions =  load_current_config_file.audits.all
    render json: @config_versions
  end

  private

  def load_current_environment
    @current_deploy_environment = current_deploy_environment(params[:environment_id])
  end

  def load_current_config_file
    @current_deploy_environment.config_files.find (params[:config_file_id])
  end
end
