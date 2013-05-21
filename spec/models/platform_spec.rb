require 'spec_helper'

describe Platform do 

  describe "#initialize" do 

    let(:user) {User.create(email: "yolo@email.com")}
    let(:platform) {Platform.new(user)}

    context "given a user has been passed in" do 

      it "has a user" do 
        expect(platform.user).to eq user
      end

      context "given a user is not passed in" do 

        it "raises an error" do 
        end
      end
    end
  end
end 