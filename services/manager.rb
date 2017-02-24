require 'active_record'
require 'require_all'
require 'yaml'


class Manager < ActiveRecord::Base

  private
  def self.is_valid_age? (string)
    true if Float(string) > 0 rescue false
  end

  def self.string_is_not_blank? (string)
    if string && !string.to_s.empty?
      true
    else
      false
    end
  end

end