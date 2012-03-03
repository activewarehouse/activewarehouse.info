require 'sinatra'
require 'sinatra/reloader' if development?

class Project
  attr_accessor :name, :latest_version, :published_at, :summary

  def initialize(name, latest_version, published_at, summary = nil)
    @name = name
    @summary = summary
    # TODO - fetch data and store it into Redis
    #version_info = settings.cache.fetch("gem-#{name}") do
    #  JSON.parse(open("https://rubygems.org/api/v1/versions/activewarehouse-etl.json").read)[0]
    #end

    @latest_version = latest_version #version_info['number']
    @published_at = DateTime.parse(published_at) #version_info['built_at']
  end

  def self.all
    [
      ['activewarehouse-etl', '1.0.0.rc1', '2012-03-03T00:00:00Z', 'A highly hackable Ruby ETL (Extract/Transform/Load) tool. <br/>Tested with MRI 1.9.3, 1.8.7, MySQL and Postgresql.<br/>Requires ActiveRecord 3+.'],
      ['adapter_extensions', '1.0.0.rc1', '2012-03-03T00:00:00Z', 'ActiveRecord extensions for bulk load and tables manipulations. <br/>Tested with MRI 1.9.3, 1.8.7, MySQL and Postgresql.<br/>Requires ActiveRecord 3+.'], 
      ['activewarehouse', '0.3.0', '2007-05-13T04:00:00Z', ''], 
      ['rails_sql_views', '0.8.0', '2010-08-25T04:00:00Z', ''], 
    ].map { |data| Project.new(*data) }
  end

end

class WebSite < Sinatra::Base
  configure :development do
   register Sinatra::Reloader
  end

  get '/' do
    @projects = Project.all
    erb :index
  end
end
