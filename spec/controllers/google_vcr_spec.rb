#require 'spec_helper'
#
#describe 'google' do
#    it 'responds' do
#      VCR.use_cassette('google') do
#        response = RestClient.get 'http://google.com'
#        expect(response.headers).to eq({:date=>"Tue, 21 May 2013 19:31:19 GMT", :expires=>"-1", :cache_control=>"private, max-age=0", :content_type=>"text/html; charset=ISO-8859-1", :set_cookie=>["NID=67=FQyR4trg5ChPwGRuQTc3ETgXBHeg-MEYYac88zUmekBNHEU0apyvTCfCPXeTr2AC3dHpfooLchAHq5Mr3ZNbEI4zmCqYdtw3revusNzLPk-hgs8i5okGTaSEw75FpYl6; expires=Wed, 20-Nov-2013 19:31:19 GMT; path=/; domain=.google.com; HttpOnly", "PREF=ID=52d125a4148d14fe:FF=0:TM=1369164679:LM=1369164679:S=A3AAp26VcImbrNj0; expires=Thu, 21-May-2015 19:31:19 GMT; path=/; domain=.google.com"], :p3p=>"CP=\"This is not a P3P policy! See http://www.google.com/support/accounts/bin/answer.py?hl=en&answer=151657 for more info.\"", :server=>"gws", :x_xss_protection=>"1; mode=block", :x_frame_options=>"SAMEORIGIN", :transfer_encoding=>"chunked"})
#      end
#    end
#end