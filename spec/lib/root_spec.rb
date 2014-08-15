require 'spec_helper'


describe HttpBaseline do

  describe 'ResHTTPot namespace' do

    it 'should have VERSION constant' do
      HttpBaseline.constants.include?(:VERSION).should == true
    end

  end

end