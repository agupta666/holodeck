require 'sinatra'
require 'haml'
require 'yaml'
require 'base64'
require 'zip'
require File.dirname(__FILE__) + '/holodeck'


run Sinatra::Application
