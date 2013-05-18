require 'spec_helper'

describe Email do

  let!(:mail) { Email.create(from: "example", subject: "ahoy", body: "hoy", received: "now")}

  describe ".from" do 

    context "given an email has from attribute" do 

      it "has a from" do 
        expect(mail.from).to be
      end
    end
  end


  describe ".subject" do 

    context "given an email has a subject" do 

      it "has a subject" do
        expect(mail.subject).to be
      end
    end
  end

  describe ".body" do 

    context "given an email has a body" do 

      it "has a body" do 
        expect(mail.body).to be
      end
    end
  end

  describe ".received" do 

    context "given an email has a received at" do 

      it "has a received at" do 
        expect(mail.received).to be
      end
    end
  end
end