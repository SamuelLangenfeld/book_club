require 'rails_helper'



RSpec.describe ApplicationHelper, type: :helper do
  describe 'format_date' do
    it "returns the date in the correct format, mm-dd-yyyy" do
      date=Date.new(2001, 2, 3)
      date_string=format_date(date)
      expect(date_string).to eq("02-03-2001")
    end
  end

  describe "format_time" do
    context "the entered time is empty" do
      it "returns an empty string" do
        time_string=""
        expect(format_time(time_string)).to eq("")
      end
    end

    context "the entered time is valid" do
      it "returns the time formatted into 12 hr day, hh:mm am/pm" do
        time_string="18:34"
        expect(format_time(time_string)).to eq("6:34 PM")
      end

      it "returns 12 if the hour is 00" do
        time_string="00:34"
        expect(format_time(time_string)).to eq("12:34 AM")
      end

      it "returns pm if the hour is 12" do
        time_string="12:34"
        expect(format_time(time_string)).to eq("12:34 PM")
      end

      it "returns am if the hour is less than 12" do
        time_string="08:34"
        expect(format_time(time_string)).to eq("8:34 AM")
      end
    end
  end
end
