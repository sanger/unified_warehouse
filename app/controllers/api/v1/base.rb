# frozen_string_literal: true

class Api::V1::Base < ApplicationController
  include JSONAPI::Pagination
  include JSONAPI::Fetching

  class_attribute :model_class

  def index
    jsonapi_paginate(model_class.all) do |paginated|
      render jsonapi: paginated
    end
  end
end
