require "spec_helper"
require "signup"
 describe Signup do
  describe "#save" do
    it "creates an account with one user" do
      account = stub_created(Account)
      stub_created(User)
      signup_mailer = stub_signup_mailer("example")
      logger = stub_logger
      signup = Signup.new(
        logger: logger,
        email: "user@example.com",
        account_name: "Example"
      )
       result = signup.save
       expect(Account).to have_received(:create!).with(name: "Example")
      expect(User).to have_received(:create!).
        with(account: account, email: "user@example.com")
      expect(signup_mailer).to have_received(:deliver)
      expect(logger).
        to have_received(:info).with("Your new example account")
      expect(result).to be(true)
    end
  end
   def stub_created(model)
    double(model.name).tap do |instance|
      allow(model).to receive(:create!).and_return(instance)
    end
  end
   def stub_signup_mailer(account_name)
    subject = "Your new #{account_name} account"
    double("signup mailer", subject: subject).tap do |signup_mailer|
      allow(signup_mailer).to receive(:deliver)
      allow(SignupMailer).to receive(:new).and_return(signup_mailer)
    end
  end
   def stub_logger
    double("logger").tap do |logger|
      allow(logger).to receive(:info)
    end
  end
end
