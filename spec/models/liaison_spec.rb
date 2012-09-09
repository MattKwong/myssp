# == Schema Information
#
# Table name: liaisons
#
#  id              :integer          not null, primary key
#  first_name      :string(255)
#  last_name       :string(255)
#  address1        :string(255)
#  created_at      :datetime
#  updated_at      :datetime
#  church_id       :integer
#  title           :string(255)
#  address2        :string(255)
#  city            :string(255)
#  state           :string(255)
#  zip             :string(255)
#  home_phone      :string(255)
#  cell_phone      :string(255)
#  work_phone      :string(255)
#  fax             :string(255)
#  email1          :string(255)
#  email2          :string(255)
#  name            :string(255)
#  liaison_type_id :integer
#  user_created    :boolean
#  scheduled       :boolean
#  registered      :boolean
#

require 'spec_helper'

describe Liaison do
  before (:each) do
    @attr = { :last_name => "Smith", :first_name => "John", :name => "John Smith",
              :address1 => "4410 S. Budlong Avenue",
              :city => "Los Angeles", :state => "CA", :zip => "90037",
              :email1 => "info@example.com", :cell_phone => "123-456-7890",
              :fax => "123-456-7890", :church_id => 1, :first_name => "John",
              :last_name => "Smith", :work_phone => "123-456-8901",
              :home_phone => "123-456-7890", :title => "Senior Pastor",
              :liaison_type_id => 2}
  end

  describe "Liaison name tests" do
    it "should require a first name" do
      no_name = Liaison.new(@attr.merge(:first_name => ""))
      no_name.should_not be_valid
    end

    it "should require a last name" do
      no_name = Liaison.new(@attr.merge(:last_name => ""))
      no_name.should_not be_valid
    end

    it "should create a liaison" do
      liaison = Liaison.create!(@attr)
      liaison.should be_valid
    end
  end

  describe "Address and city tests"  do
    it "should require an address1" do
      no_add1 = Liaison.new(@attr.merge(:address1 => ""))
      no_add1.should_not be_valid
    end

    it "should require a city" do
      no_city = Liaison.new(@attr.merge(:city => ""))
      no_city.should_not be_valid
    end
  end

  describe "State tests" do

    it "should require a state" do
      no_state = Liaison.new(@attr.merge(:state => ""))
      no_state.should_not be_valid
    end

    it "should be in a valid states abbreviation" do
      invalid_state = Liaison.new(@attr.merge(:state => "XX"))
      invalid_state.should_not be_valid
    end
  end

  describe "zip code tests" do

    it "should require a zip code" do
      no_zip = Liaison.new(@attr.merge(:zip => ""))
      no_zip.should_not be_valid
    end

    it "should be 5 digits" do
      bad_zip = Liaison.new(@attr.merge(:zip => "1234"))
      bad_zip.should_not be_valid
    end

    it "should only be digits" do
      bad_zip = Liaison.new(@attr.merge(:zip => "xxxxx"))
      bad_zip.should_not be_valid
    end

    it "should accept a valid zip code" do
      good_zip = Liaison.new(@attr)
      good_zip.should be_valid
    end
  end

  describe "email1 tests" do
    it "should not allow a blank email1" do        #email1 is required for liaisons
      no_email = Liaison.new(@attr.merge(:email1 => ""))
      no_email.should_not be_valid
    end

    it "should reject an invalid email" do
      bad_email = Liaison.new(@attr.merge(:email1 => "info@example"))
      bad_email.should_not be_valid
    end

    it "should accept a valid email" do
      good_email = Liaison.new(@attr)
      good_email.should be_valid
    end

    it "should reject a duplicate email" do
      first_email = Liaison.new(@attr)
      first_email.save!
      second_email = Liaison.new(@attr)
      second_email.should_not be_valid
    end
  end

  describe "email2 tests" do
    it "should allow a blank email2" do        #email2 is not required for liaisons
      no_email = Liaison.new(@attr.merge(:email2 => ""))
      no_email.should be_valid
    end

    it "should reject an invalid email" do
      bad_email = Liaison.new(@attr.merge(:email2 => "info@example"))
      bad_email.should_not be_valid
    end
  end

  describe "Work, Home, Cell and Fax tests" do
    it "should have at least one phone" do
      no_phones = Liaison.new(@attr.merge(:home_phone => "", :work_phone => "", :cell_phone => ""))
      no_phones.should_not be_valid
    end

    it "should reject an invalid work phone" do
      bad_phone = Liaison.new(@attr.merge(:work_phone => "123-4567"))
      bad_phone.should_not be_valid
    end
    it "should reject an invalid home phone" do
      bad_phone = Liaison.new(@attr.merge(:home_phone => "123-4567"))
      bad_phone.should_not be_valid
    end

    it "should reject an invalid cell phone" do
      bad_phone = Liaison.new(@attr.merge(:cell_phone => "123-4567"))
      bad_phone.should_not be_valid
    end

    it "should reject an invalid fax phone" do
      bad_phone = Liaison.new(@attr.merge(:fax => "123-4567"))
      bad_phone.should_not be_valid
    end

    it "should accept a valid phones" do
      good_phone = Liaison.new(@attr)
      good_phone.should be_valid
    end

  describe "Title tests" do
    it "should require a title" do
      no_title = Liaison.new(@attr.merge(:title => ""))
      no_title.should_not be_valid
    end
  end
  end
  end
