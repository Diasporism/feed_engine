require 'spec_helper'

describe Email do

  let!(:mail) { Email.create(from: "example", subject: "ahoy", body: "hoy", received: "now", uid: "07846")}

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

  describe "#save" do 

    it "takes in an email and saves the necessary parts" do
      pending "need to create a mock for mail"
      # mail = Mail::Message
      expect{ Email.save(mail) }.to change( Email, :count ).by(2)
    end
  end


  describe ".uid" do 

    context "given an email has a unique id" do 

      it "has a uid" do 
        expect(mail.uid).to be
      end
    end
  end
end