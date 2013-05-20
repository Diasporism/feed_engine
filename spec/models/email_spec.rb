require 'spec_helper'

describe Email do

  let!(:mail) { Email.create(from: "example", subject: "ahoy", body: "hoy", received_at: "Sat May 18 20:02:13 +0000 2013", uid: "07846")}

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

  describe ".received_at" do 

    context "given an email has a date for when it was received at" do 

      it "has a received at" do 
        expect(mail.received_at).to be
      end
    end
  end

  describe ".uid" do 

    context "given an email has a unique id" do 

      it "has a uid" do 
        expect(mail.uid).to be
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
end