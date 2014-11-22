class HostsController < ApplicationController
  before_action :set_host, only: [:show]

  def index
    @hosts = Host.all
  end

  def show
  end

  private
    def set_host
      @host = Host.find(params[:id])
    end
end
