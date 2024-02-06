# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ColorValidatable, type: :module do
  class TestModel
    include ActiveModel::Model
    include ColorValidatable

    attr_accessor :color

  end

  subject(:model_instance) { TestModel.new }

  context 'valid color' do
    it 'is valid for a valid color name' do
      model_instance.color = 'blue'
      expect(model_instance).to be_valid
    end

    it 'is valid for a valid hex RGB 6 color code' do
      model_instance.color = '#FF0000'
      expect(model_instance).to be_valid
    end

    it 'is valid for a valid hex RGB 3 color code' do
      model_instance.color = '#FFF'
      expect(model_instance).to be_valid
    end
  end

  context 'invalid color' do
    it 'is invalid for an invalid color name' do
      model_instance.color = 'invalidcolor'
      expect(model_instance).not_to be_valid
    end

    it 'is invalid for an invalid hex RGB 6 color code' do
      model_instance.color = '#GGG000'
      expect(model_instance).not_to be_valid
    end

    it 'is invalid for an invalid hex RGB 3 color code' do
      model_instance.color = '#GGG'
      expect(model_instance).not_to be_valid
    end

  end
end